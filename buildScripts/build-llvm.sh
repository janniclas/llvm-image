#!/bin/bash

set -e

num_cores=1
target_dir=./
re_number="^[0-9]+$"
re_llvm_release="^llvmorg-[0-9]+\.[0-9]+\.[0-9]+$"

readonly num_cores=${1}
readonly build_dir="${2}"
readonly dest_dir="${3}"
readonly llvm_release="${4}"

if [ "$#" -ne 4 ] || ! [[ "$num_cores" =~ ${re_number} ]] || ! [ -d "${build_dir}" ] || ! [[ "${llvm_release}" =~ ${re_llvm_release} ]]; then
	echo "usage: <prog> <# cores> <build dir> <install dir> <LLVM release (e.g. 'llvmorg-9.0.0')>" >&2
	exit 1
fi

readonly llvm_version=${llvm_release##*-} # i.e. 10.0.0, if llvm_release is "llvmorg-10.0.0"
readonly llvm_major_rev=${llvm_version%%.*}  # i.e. 10, if llvm_release is "llvmorg-10.0.0"


echo "Getting the LLVM source code..."
if [ ! -d "${build_dir}/llvm-project" ]; then
    echo "Getting the complete LLVM source code"
	git clone https://github.com/llvm/llvm-project.git "${build_dir}"/llvm-project
fi

echo "Building LLVM..."
cd "${build_dir}"/llvm-project/
git checkout "${llvm_release}"
mkdir -p build
cd build
cmake -G "Ninja" -DLLVM_ENABLE_PROJECTS='clang;clang-tools-extra;libcxx;libcxxabi;libunwind;lld;compiler-rt;debuginfo-tests' -DCMAKE_BUILD_TYPE=Release -DLLVM_ENABLE_EH=ON -DLLVM_ENABLE_RTTI=ON -DLLVM_LINK_LLVM_DYLIB=ON -DLLVM_ENABLE_DUMP=ON -DLLVM_BUILD_EXAMPLES=Off -DLLVM_INCLUDE_EXAMPLES=Off -DLLVM_BUILD_TESTS=Off -DLLVM_INCLUDE_TESTS=Off ../llvm
cmake --build .

