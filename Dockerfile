FROM ubuntu:20.04 AS environment
WORKDIR /app

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Seoul
RUN apt-get update && apt-get -yq install gcc g++ git cmake ninja-build python3 python3-pip protobuf-compiler \
    build-essential checkinstall zlib1g-dev libssl-dev wget
RUN wget https://github.com/Kitware/CMake/releases/download/v3.22.2/cmake-3.22.2.tar.gz && tar -zxvf cmake-3.22.2.tar.gz
RUN cd cmake-3.22.2 && ./bootstrap && make -j$(nproc) && make install
WORKDIR /app
RUN pip3 install numpy  && pip3 install pybind11
RUN git clone https://github.com/llvm/llvm-project.git

FROM environment AS llvm_build
RUN cmake -S llvm-project/llvm -B llvm-project/build -G Ninja -DCMAKE_BUILD_TYPE=Release \
     -DPython3_EXECUTABLE="/usr/bin/python3" \
    -DMLIR_ENABLE_BINDINGS_PYTHON=ON  -DLLVM_ENABLE_PROJECTS=mlir -DCMAKE_BUILD_TYPE=Release \
    -DLLVM_TARGETS_TO_BUILD="AArch64;ARM;X86;Hexagon"
RUN cmake --build llvm-project/build --target all -j6
RUN cd llvm-project/build && ninja install

FROM llvm_build AS install_template
WORKDIR /app
COPY . MLIRTemplate
WORKDIR /app/MLIRTemplate
RUN cmake -G Ninja -DCMAKE_BUILD_TYPE=Debug .
RUN cmake --build . --target all -j6