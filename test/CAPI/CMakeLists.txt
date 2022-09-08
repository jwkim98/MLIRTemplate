# Here we create a single aggregate shared library with the parts of the CAPI
# that we want to bundle together. Then we link a simple C executable
# against it to demonstrate that it does have the fully self contained
# core MLIR library and our own Example dialect.
add_mlir_aggregate(ExampleCAPITestLib
  SHARED
  EMBED_LIBS
  MLIRCAPIIR
  # TODO: Remove this in favor of showing fine grained dialect registration
  # (once available).
  MLIRCAPIRegisterEverything
  ExampleCAPI
)

add_llvm_executable(ExampleCAPITest
  ExampleCAPITest.c
)
llvm_update_compile_flags(ExampleCAPITest)
target_link_libraries(ExampleCAPITest
  PRIVATE ExampleCAPITestLib)
