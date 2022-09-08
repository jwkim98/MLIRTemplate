//===- ExampleDialect.cpp - Example dialect ---------------*- C++ -*-===//
//
// This file is licensed under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "MLIRTemplate/Dialects/ExampleDialect/ExampleDialect.hpp"
#include "MLIRTemplate/Dialects/ExampleDialect/ExampleOps.hpp"

using namespace mlir;
using namespace mlir::example;

#include "MLIRTemplate/Dialects/ExampleDialect/ExampleOpsDialect.cpp.inc"

//===----------------------------------------------------------------------===//
// Example dialect.
//===----------------------------------------------------------------------===//

void ExampleDialect::initialize() {
    addOperations<
#define GET_OP_LIST
#include "MLIRTemplate/Dialects/ExampleDialect/ExampleOps.cpp.inc"
        >();
}
