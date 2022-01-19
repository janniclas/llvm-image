FROM ubuntu:20.04


RUN apt -y update && apt install bash sudo -y

# installing LLVM
COPY scripts .
RUN ./InitializeEnvironment.sh
RUN ./AddDependencies.sh
RUN ./InstallLLVM.sh $(nproc) . "/usr/local/llvm-13" "llvmorg-13.0.0"
