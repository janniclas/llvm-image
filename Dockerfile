FROM ubuntu:20.04 as builder

ARG LLVM_INSTALL_DIR="/usr/local/llvm-12"

RUN apt -y update && apt install bash sudo -y

# installing LLVM
COPY scripts .
RUN ./InitializeEnvironment.sh
RUN ./add-dependencies-llvm.sh
RUN ./build-llvm.sh $(nproc) . ${LLVM_INSTALL_DIR} "llvmorg-12.0.0"
