include(AddMLIRPython)

# Specifies that all MLIR packages are co-located under the `mlir_Example`
# top level package (the API has been embedded in a relocatable way).
# TODO: Add an upstream cmake param for this vs having a global here.
add_compile_definitions("MLIR_PYTHON_PACKAGE_PREFIX=mlir_Example.")


################################################################################
# Sources
################################################################################

declare_mlir_python_sources(ExamplePythonSources)

declare_mlir_dialect_python_bindings(
        ADD_TO_PARENT ExamplePythonSources
        ROOT_DIR "${CMAKE_CURRENT_SOURCE_DIR}/mlir_Example"
        TD_FILE dialects/ExampleOps.td
        SOURCES
        dialects/Example.py
        DIALECT_NAME Example)

declare_mlir_python_extension(ExamplePythonSources.Extension
        MODULE_NAME _ExampleDialects
        ADD_TO_PARENT ExamplePythonSources
        SOURCES
        ExampleExtension.cpp
        EMBED_CAPI_LINK_LIBS
        ExampleCAPI
        )

################################################################################
# Common CAPI
################################################################################

add_mlir_python_common_capi_library(ExamplePythonCAPI
        INSTALL_COMPONENT ExamplePythonModules
        INSTALL_DESTINATION python_packages/Example/mlir_Example/_mlir_libs
        OUTPUT_DIRECTORY "${MLIR_BINARY_DIR}/python_packages/Example/mlir_Example/_mlir_libs"
        RELATIVE_INSTALL_ROOT "../../../.."
        DECLARED_SOURCES
        ExamplePythonSources
        # TODO: Remove this in favor of showing fine grained registration once
        # available.
        MLIRPythonExtension.RegisterEverything
        MLIRPythonSources.Core
        )

################################################################################
# Instantiation of all Python modules
################################################################################

add_mlir_python_modules(ExamplePythonModules
        ROOT_PREFIX "${MLIR_BINARY_DIR}/python_packages/Example/mlir_Example"
        INSTALL_PREFIX "python_packages/Example/mlir_Example"
        DECLARED_SOURCES
        ExamplePythonSources
        # TODO: Remove this in favor of showing fine grained registration once
        # available.
        MLIRPythonExtension.RegisterEverything
        MLIRPythonSources
        COMMON_CAPI_LINK_LIBS
        ExamplePythonCAPI
        )
