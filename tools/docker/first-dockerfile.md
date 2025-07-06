# First Dockerfile FROM scratch: Static vs. Dynamic Linking & Memory

This guide explores executable linking and memory, using a simple C "Hello World" program:

```c
// hello.c
#include <stdio.h>

int main() {
    printf("Hello from Docker!\n");
    return 0;
}
```

## 1. Static Executable: Self-Contained Simplicity

The easiest way to get a C program into a [FROM scratch](https://docs.docker.com/build/building/base-images/#create-a-parent-image-using-scratch) Docker image is to **statically link** it. This embeds all required code directly into your executable, making it self-contained.

* **Compile:** `gcc hello.c -o hello_static -static`
    * `-static`: Embeds all required [C standard library](https://en.wikipedia.org/wiki/C_standard_library) code, no runtime dependencies.
* **Check:** [`ldd hello_static`](https://man7.org/linux/man-pages/man1/ldd.1.html) shows "not a dynamic executable".
* **`Dockerfile.static`:**
```dockerfile
FROM scratch
COPY hello_static /hello_static
CMD ["/hello_static"]
```
```sh
docker build -t hello-static -f Dockerfile.static .
docker run --rm hello-static
```
* **Result:** Works immediately. Simplest for `FROM scratch`.

## 2. Dynamic Executable: Dependencies & Challenges

Most C programs link dynamically by default, depending on external **shared objects** ([.so](https://en.wikipedia.org/wiki/Shared_object) on Linux, [.dll](https://en.wikipedia.org/wiki/Dynamic-link_library) on Windows).

* **Compile:** `gcc hello.c -o hello_dynamic`
* **Check Dependencies (`ldd`):**
    * `ldd hello_dynamic` reveals:
        * `libc.so.6`: The [C standard library](https://en.wikipedia.org/wiki/C_standard_library) (`printf`, etc.).
        * `/lib64/ld-linux-x86-64.so.2`: The [dynamic linker/loader](https://en.wikipedia.org/wiki/Linker#Dynamic_linking). The [Linux kernel](https://en.wikipedia.org/wiki/Linux_kernel) loads this first.
        * `linux-vdso.so.1`: **vDSO** ([Virtual Dynamic Shared Object](https://en.wikipedia.org/wiki/VDSO)) - kernel-provided, not a file to copy.
* **ELF & `_start`:** Linux executables (.so`s too) are in [ELF (Executable and Linkable Format)](https://en.wikipedia.org/wiki/Executable_and_Linkable_Format). Programs start at an **entry point** (e.g., `_start`), which then calls `main()`. Use [`readelf -l hello_dynamic | grep "Requesting program interpreter"`](https://linux.die.net/man/1/readelf) to inspect ELF.
* **`FROM scratch` Failure:**
    * **`Dockerfile.broken`:**
```dockerfile
FROM scratch
COPY hello_dynamic /hello_dynamic
CMD ["/hello_dynamic"]
```
```sh
docker build -t hello-broken -f Dockerfile.broken .
docker run --rm hello-broken
```
    * **Error:** `exec /hello_dynamic: no such file or directory`.
    * **Reason:** The dynamic linker (`ld-linux-x86-64.so.2`) is missing inside the empty `scratch` image.
* **The Fix:** Copy the linker and `libc.so.6` to their exact expected paths within the Docker image.
    * **`Dockerfile.dynamic`:**
```dockerfile
FROM scratch
COPY libc.so.6 /lib/x86_64-linux-gnu/libc.so.6
COPY ld-linux-x86-64.so.2 /lib64/ld-linux-x86-64.so.2
COPY hello_dynamic /hello_dynamic
CMD ["/hello_dynamic"]
```
```sh
cp /lib/x86_64-linux-gnu/libc.so.6 .
cp /lib64/ld-linux-x86-64.so.2 .
docker build -t hello-dynamic -f Dockerfile.dynamic .
docker run --rm hello-dynamic
```
    * **Result:** Works, but image is larger due to copied libraries.

---

## 3. Process Memory & Shared Libraries

A running program ([process](https://en.wikipedia.org/wiki/Process_(computing))) has a [virtual memory space](https://en.wikipedia.org/wiki/Virtual_memory) divided into segments ([Memory layout of a C program](https://en.wikipedia.org/wiki/Memory_layout_of_a_C_program)):

```
High Address
+--------------------+
| Stack              | (Grows downwards, private to each thread)
|                    |
| Mmap Segment       | (For .so code/data, file mappings)
|                    |
| Heap               | (Grows upwards, private to each process)
|                    |
| BSS (Uninit. Data) |
| Data (Init. Data)  |
| Text (Code)        | (Read-only executable instructions)
+--------------------+ Low Address
```

* **Stack:** Local variables, function calls. Private per thread.
* **Heap:** Dynamic memory ([malloc](https://man7.org/linux/man-pages/man3/malloc.3.html)). Private per process.
* **Shared Objects (.so`s):**
    * Their **code and read-only data** are mapped into the **Mmap Segment**.
    * **Sharing:** The *same [physical RAM](https://en.wikipedia.org/wiki/Random-access_memory) pages* for the `.so`'s code are mapped into *multiple processes'* virtual spaces, saving physical memory.
    * **Writable Data:** Handled with **Copy-On-Write (COW)**. Initially shared, but a private copy is made for a process upon modification.

### Process Memory and MMU

* Multiple Processes, Same Physical Pages:
    * The same physical pages of RAM (where the .so's code and read-only data are actually stored) are mapped into the virtual address space of multiple different processes.
    * Each process will have a different virtual address for that shared library, but those different virtual addresses will all translate to the same physical address in RAM.
    * Imagine:
        * Process A's virtual address 0x7f000000 maps to physical page 0x12345.
        * Process B's virtual address 0x7e000000 maps to physical page 0x12345.
    * They both "see" the library at different virtual addresses in their own private address spaces, but they are both actually using the exact same physical memory for the code.
* No "Reference Outside": The process doesn't hold a "reference" that points outside of its own address space. Each process believes the code is within its own virtual address space. It's the kernel and MMU that handle the magic of mapping different virtual addresses from different processes to the same underlying physical memory.
    * From the perspective of your C code running inside the process, if it calls a function in libc.so.6, it's just calling a virtual address within its own process's address space. It doesn't "know" or "care" that other processes might have that same physical code mapped into their own separate virtual address spaces.

### Position-Independent Code (PIC)

* **What:** Code designed to work correctly regardless of where it's loaded in memory.
* **Why:** Essential for shared libraries (.so, .dll) because the OS loader can place them at any available virtual address.
* **How:** Achieved by using relative addressing. Compilers use flags like `-fPIC`.
