# Rust

## Introduction
* en.wikipedia.org/wiki/Rust_(programming_language)
* [The Rust Programming Language](doc.rust-lang.org/book) or simply The Book
* https://doc.rust-lang.org/rust-by-example/
* https://google.github.io/comprehensive-rust/
* https://braiins-uni.mag.wiki/choosing-rust.html

## Rust Language
* [The Rust Reference](doc.rust-lang.org/reference/)
* [Loops and other breakable expressions](https://doc.rust-lang.org/reference/expressions/loop-expr.html)
* [The Rust Core Library](https://doc.rust-lang.org/core/)
* Enum - https://en.wikipedia.org/wiki/Tagged_union
* Does not have variadic functions -> macros.

### Comments
* inner doc comments (starting with `//!` or `/*!`) can only appear before [items](https://doc.rust-lang.org/stable/reference/items.html)

### [Primitive Data Types](https://doc.rust-lang.org/core/#primitives)
* https://doc.rust-lang.org/core/primitive.array.html
  * https://doc.rust-lang.org/rust-by-example/primitives/array.html
* https://doc.rust-lang.org/core/primitive.str.html
* https://doc.rust-lang.org/core/primitive.slice.html
  * https://doc.rust-lang.org/book/ch04-03-slices.html

### [Modules](https://doc.rust-lang.org/core/#modules)
* https://doc.rust-lang.org/core/option/
* https://doc.rust-lang.org/core/result/
* https://doc.rust-lang.org/core/iter/
* https://doc.rust-lang.org/core/clone/
* https://doc.rust-lang.org/core/convert/
* https://doc.rust-lang.org/core/default/
* https://doc.rust-lang.org/core/ops/
  * https://doc.rust-lang.org/rust-by-example/trait/ops.html

### Traits
* https://doc.rust-lang.org/core/fmt/trait.Debug.html
* https://doc.rust-lang.org/core/fmt/trait.Display.html

### [Macros](https://doc.rust-lang.org/core/index.html#macros)
* https://doc.rust-lang.org/core/macro.assert.html
* https://doc.rust-lang.org/core/macro.assert_eq.html
* https://doc.rust-lang.org/core/macro.todo.html
* https://doc.rust-lang.org/core/macro.write.html

### Ownership
* https://doc.rust-lang.org/book/ch04-01-what-is-ownership.html
* assignment moves
* Copy types

### References
* https://doc.rust-lang.org/book/ch04-02-references-and-borrowing.html
* Automatic dereferencing
* `&&T -> &T`
* https://doc.rust-lang.org/core/ops/trait.Deref.html

### shadowing
* `let name: &str = name.trim();`

## [Standard Library](https://doc.rust-lang.org/std/)
* https://doc.rust-lang.org/std/macro.println.html
* https://doc.rust-lang.org/std/vec/
* https://doc.rust-lang.org/std/string/
* https://doc.rust-lang.org/std/fmt/
* https://doc.rust-lang.org/std/io/
  * https://doc.rust-lang.org/std/io/trait.BufRead.html
  * https://doc.rust-lang.org/std/io/struct.BufReader.html
* https://doc.rust-lang.org/std/path/
* https://doc.rust-lang.org/std/env/
  * https://doc.rust-lang.org/book/ch12-01-accepting-command-line-arguments.html
* https://doc.rust-lang.org/std/borrow/

## Recommended
* https://os.phil-opp.com/async-await/
* https://lexi-lambda.github.io/blog/2019/11/05/parse-don-t-validate/
* https://www.howtocodeit.com/articles/ultimate-guide-rust-newtypes
* https://www.howtocodeit.com/articles/master-hexagonal-architecture-rust
* crate api guidelines - https://rust-lang.github.io/api-guidelines/
* https://rust-unofficial.github.io/patterns/

## [Cargo](https://doc.rust-lang.org/cargo/)
```sh
cargo new
cargo check
cargo clean
cargo run
cargo doc --open
cargo clippy
cargo fmt
```

## Crates
* crates by popularity - https://crates.io/crates?sort=downloads
* https://lib.rs/
* https://github.com/awesome-rust-com/awesome-rust
* https://docs.rs/dashmap/latest/dashmap/struct.DashMap.html
* https://docs.rs/async-trait/latest/async_trait/
* https://crates.io/crates/futures
* https://docs.rs/argon2/latest/argon2/
* https://docs.rs/flume/latest/flume/
* https://doc.rust-lang.org/std/marker/struct.PhantomData.html
* mutex, rwlock - https://docs.rs/parking_lot/latest/parking_lot/
* https://docs.rs/auto_enums/latest/auto_enums/
* https://docs.rs/slog/latest/slog/
* https://docs.rs/pyo3/latest/pyo3/
* https://docs.rs/ndarray/latest/ndarray/
* https://github.com/hyperium/hyper/tree/master/examples
* https://github.com/spacejam/sled
* https://github.com/JasonShin/fp-core.rs
* https://crates.io/crates/cargo-audit
* https://docs.rs/genawaiter/latest/genawaiter/

### Regex
* https://docs.rs/regex/1.4.2/regex/struct.Regex.html#method.split

### Error handling
* https://doc.rust-lang.org/book/ch09-00-error-handling.html
* https://doc.rust-lang.org/std/error/
* https://docs.rs/anyhow/latest/anyhow/
* https://docs.rs/thiserror/latest/thiserror/
* https://doc.rust-lang.org/std/process/trait.Termination.html

### Tokio
* https://tokio.rs/
* https://tokio.rs/tokio/tutorial
  * Asynchrony - IO bound then message passing (oneshot::channel) otherwise sharded mutex.
  * Always bound everything with reasonable numbers.
* https://github.com/tokio-rs/mini-redis/blob/master/src/lib.rs
* https://github.com/tokio-rs/mini-redis/blob/master/src/db.rs
* https://github.com/tokio-rs/tokio/blob/master/examples/chat.rs
* https://www.youtube.com/watch?v=fTXuGRP1ee4[Actors with Tokio – a lesson in ownership - Alice Ryhl]
* https://ryhl.io/blog/actors-with-tokio/
* https://docs.rs/tokio-util/latest/tokio_util/index.html

### sqlx
* https://docs.rs/sqlx/latest/sqlx/
* https://github.com/launchbadge/sqlx/blob/main/README.md
* https://github.com/launchbadge/sqlx/blob/main/examples/postgres/chat/src/main.rs
* [Rust to PostgreSQL with SQLX | Rust By Example](https://gist.github.com/jeremychone/34d1e3daffc38eb602b1a9ab21298d10)

### Itertools
* https://docs.rs/itertools/latest/itertools/trait.Itertools.html#method.collect_tuple

## Nightly
* https://doc.rust-lang.org/std/iter/trait.Iterator.html#method.intersperse

## Extra
* https://github.com/rust-lang/rust
* rust-script - https://rust-script.org/
* rust announcements - https://blog.rust-lang.org/
* https://rust-lang.github.io/async-book/
* formating - https://rust-lang.github.io/rustfmt/
* linting - doc.rust-lang.org/stable/clippy
* https://doc.rust-lang.org/rustdoc/
* https://rust-lang.github.io/rustup/
* https://nnethercote.github.io/perf-book/
* [Rustonomicon (unsafe rust)](https://doc.rust-lang.org/nomicon/)
* https://without.boats/blog/why-async-rust/
* [The History of Rust by Steve Klabnik](https://youtu.be/79PSagCD_AY)
* [The Rust I Wanted Had No Future by Graydon Hoare](https://graydon2.dreamwidth.org/307291.html)

## RFC
### Pre-RFC
* <https://internals.rust-lang.org/t/pre-rfc-named-arguments/16413>

## Issues
* [Tracking Issue for "More Qualified Paths" #86935](https://github.com/rust-lang/rust/issues/86935)

## TODO
* [Rust Developer course texts](https://github.com/Global-rd/rust/)
* https://google.github.io/comprehensive-rust/exercises/concurrency/solutions-afternoon.html#broadcast-chat-application
* https://github.com/pretzelhammer/rust-blog/blob/master/posts/common-rust-lifetime-misconceptions.md
* https://itnext.io/leaky-abstractions-and-a-rusty-pin-fbf3b84eea1f
* https://github.com/rust-lang/rustlings
* ide for rust - areweideyet.com
* background code checker - https://github.com/Canop/bacon
* https://github.com/rust-lang/a-mir-formality
* https://docs.rs/ndarray/latest/ndarray/doc/ndarray_for_numpy_users/index.html
* https://pyo3.rs/v0.20.2/python_from_rust
* [Import sorting does not handle uppercase/lowercase consistently](https://github.com/rust-lang/rustfmt/issues/5269)
