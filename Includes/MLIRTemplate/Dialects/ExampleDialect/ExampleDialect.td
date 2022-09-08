//===- ExampleDialect.td - Example dialect -----------*- tablegen -*-===//
//
// This file is licensed under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#ifndef EXAMPLE_DIALECT
#define EXAMPLE_DIALECT

include "mlir/IR/OpBase.td"

//===----------------------------------------------------------------------===//
// Example dialect definition.
//===----------------------------------------------------------------------===//

def Example_Dialect : Dialect {
    let name = "example";
    let summary = "A Example out-of-tree MLIR dialect.";
    let description = [{
        This dialect is an example of an out-of-tree MLIR dialect designed to
        illustrate the basic setup required to develop MLIR-based tools without
        working inside of the LLVM source tree.
    }];
    let cppNamespace = "::mlir::example";

  let emitAccessorPrefix = kEmitAccessorPrefix_Prefixed;
}

//===----------------------------------------------------------------------===//
// Base Example operation definition.
//===----------------------------------------------------------------------===//

class Example_Op<string mnemonic, list<Trait> traits = []> :
        Op<Example_Dialect, mnemonic, traits>;

#endif // Example_DIALECT
