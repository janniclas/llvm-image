FROM ubuntu:20.04


RUN apt -y update && apt install bash sudo -y

# installing LLVM
COPY scripts .
RUN ./InitializeEnvironment.sh
RUN ./AddDependencies.sh
RUN ./InstallLLVM.sh $(nproc) . "/usr/local/llvm-12" "llvmorg-12.0.0"
