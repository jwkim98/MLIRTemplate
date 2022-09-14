cmake_minimum_required(VERSION 3.13.4)
project(example-dialect LANGUAGES CXX C)

set(CMAKE_BUILD_WITH_INSTALL_NAME_DIR ON)

set(CMAKE_CXX_STANDARD 17 CACHE STRING "C++ standard to conform to")
#
# CMake policy
#
cmake_policy(SET CMP0116 NEW)
find_package(MLIR REQUIRED CONFIG)

message(STATUS "Using MLIRConfig.cmake in: ${MLIR_DIR}")
message(STATUS "Using LLVMConfig.cmake in: ${LLVM_DIR}")

set(LLVM_RUNTIME_OUTPUT_INTDIR ${CMAKE_BINARY_DIR}/bin)
set(LLVM_LIBRARY_OUTPUT_INTDIR ${CMAKE_BINARY_DIR}/lib)
set(MLIR_BINARY_DIR ${CMAKE_BINARY_DIR})

list(APPEND CMAKE_MODULE_PATH "${MLIR_CMAKE_DIR}")
list(APPEND CMAKE_MODULE_PATH "${LLVM_CMAKE_DIR}")
include(TableGen)
include(AddLLVM)
include(AddMLIR)
include(HandleLLVMOptions)

if(MLIR_ENABLE_BINDINGS_PYTHON)
    include(MLIRDetectPythonEnv)
    mlir_configure_python_dev_packages()
endif()

include_directories(${LLVM_INCLUDE_DIRS})
include_directories(${MLIR_INCLUDE_DIRS})
include_directories(${PROJECT_SOURCE_DIR}/Includes)
include_directories(${PROJECT_BINARY_DIR}/Includes)
link_directories(${LLVM_BUILD_LIBRARY_DIR})
add_definitions(${LLVM_DEFINITIONS})

include(CMake/CodeCoverage.cmake)
include(CMake/CompileOptions.cmake)

add_subdirectory(Includes)
add_subdirectory(Sources)
if(MLIR_ENABLE_BINDINGS_PYTHON)
    message(STATUS "Enabling Python API")
    add_subdirectory(Python)
endif()
add_subdirectory(test)
add_subdirectory(Translate)
add_subdirectory(Opt)
