# LLVM Docker Image

This image contains an installation of LLVM on Ubuntu. It is intended to be used as a base image by images, which need LLVM installed to compile their Application.
The image size is rather large ~2.8GB, but the build time is about ~3 hours.

## Example usage

The image tags are based on their branch names. There is one branch for every version we support. You can use a specific version like this `FROM janniclas:llvm-image:12.0.0`. The latest tag is currently not supported, so make sure to define the version of llvm you want to use. 


## Acknowledges
The build scripts are heavily inspired by the definitions in [phasar](https://github.com/secure-software-engineering/phasar).