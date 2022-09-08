llvm_canonicalize_cmake_booleans(
        MLIR_ENABLE_BINDINGS_PYTHON
)

configure_lit_site_cfg(
        ${CMAKE_CURRENT_SOURCE_DIR}/lit.site.cfg.py.in
        ${CMAKE_CURRENT_BINARY_DIR}/lit.site.cfg.py
        MAIN_CONFIG
        ${CMAKE_CURRENT_SOURCE_DIR}/lit.cfg.py
)

set(EXAMPLE_TEST_DEPENDS
        #FileCheck count not
        ExampleCAPITest
        ExampleOpt
        ExampleTranslate
        )
if(MLIR_ENABLE_BINDINGS_PYTHON)
  list(APPEND EXAMPLE_TEST_DEPENDS ExamplePythonModules)
endif()

add_lit_testsuite(check-Example "Running the Example regression tests"
        ${CMAKE_CURRENT_BINARY_DIR}
        DEPENDS ${EXAMPLE_TEST_DEPENDS}
        )
set_target_properties(check-Example PROPERTIES FOLDER "Tests")

add_lit_testsuites(Example ${CMAKE_CURRENT_SOURCE_DIR} DEPENDS ${EXAMPLE_TEST_DEPENDS})

add_subdirectory(CAPI)
