ARG UBUNTU_VERSION=24.04
FROM ubuntu:${UBUNTU_VERSION}
ARG PROJECT_NAME=example-project
ARG MODULAR_VERSION=25.4
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC
ENV PATH=${PATH}:/root/.pixi/bin
# https://docs.modular.com/mojo/manual/get-started/
RUN <<EOF
apt update
apt install -y curl clang # `mojo build` needs a c++ compiler
curl -fsSL https://pixi.sh/install.sh | sh
EOF
RUN <<EOF
pixi init $PROJECT_NAME -c https://conda.modular.com/max-nightly/ -c conda-forge &&
  cd $PROJECT_NAME
pixi add "modular=${MODULAR_VERSION}"
pixi add mojo-jupyter
pixi add jupyterlab
echo Done
EOF
