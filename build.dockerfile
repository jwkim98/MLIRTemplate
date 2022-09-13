FROM ubuntu:20.04 AS environment
WORKDIR /app
RUN apt-get update && apt-get install gcc g++ git make ninja-build python3-pip -y
RUN pip3 install numpy  && pip3 install pybind11
RUN git pull git@github.com:llvm/llvm-project.git

FROM environment AS llvmBuild
WORKDIR /app/llvm-project
RUN cmake -S llvm -B build -G Ninja -DCMAKE_BUILD_TYPE=Release \
    -DMLIR_ENABLE_BINDINGS_PYTHON=ON  -DLLVM_ENABLE_PROJECTS=mlir -DCMAKE_BUILD_TYPE=Release \
    -DLLVM_TARGETS_TO_BUILD="AArch64;ARM;X86;Hexagon" \
RUN cmake --build build --target all -j$(nproc) && ninja install

FROM llvmBuild AS installTemplate
WORKDIR /app
COPY . MLIRTemplate
WORKDIR /app/MLIRTemplate
RUN cmake -G Ninja -DCMAKE_BUILD_TYPE=Debug .
RUN cmake --build . --target all -j6