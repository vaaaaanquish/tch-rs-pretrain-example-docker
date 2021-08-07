FROM rust

WORKDIR /app
RUN apt update &&\
    rm -rf ~/.cache &&\
    apt clean all &&\
    apt install -y cmake &&\
    apt install -y clang


# install libtorch=1.9.0
# https://pytorch.org/get-started/locally/
RUN wget https://download.pytorch.org/libtorch/cpu/libtorch-cxx11-abi-shared-with-deps-1.9.0%2Bcpu.zip -O libtorch.zip
RUN unzip -o libtorch.zip
ENV LIBTORCH /app/libtorch
ENV LD_LIBRARY_PATH /app/libtorch/lib:$LD_LIBRARY_PATH

# download weights file
# https://github.com/LaurentMazare/tch-rs/blob/master/examples/pretrained-models/main.rs
RUN wget https://github.com/LaurentMazare/ocaml-torch/releases/download/v0.1-unstable/resnet18.ot -O resnet18.ot

# file
COPY ./Cargo.toml /app/Cargo.toml
COPY ./src /app/src
COPY ./img /app/img

ENTRYPOINT [ "/bin/bash" ]
