get_filename_component(SRC_DIR ${SRC} DIRECTORY)

# Generate a git-describe version string from Git repository tags
if(GIT_EXECUTABLE AND NOT DEFINED VERSION)
  execute_process(
    COMMAND ${GIT_EXECUTABLE} describe --tags --match "v*"
    WORKING_DIRECTORY ${SRC_DIR}
    OUTPUT_VARIABLE GIT_DESCRIBE_VERSION
    RESULT_VARIABLE GIT_DESCRIBE_ERROR_CODE
    OUTPUT_STRIP_TRAILING_WHITESPACE
    )
  if(NOT GIT_DESCRIBE_ERROR_CODE)
    set(VERSION ${GIT_DESCRIBE_VERSION})
    message("Setting version to ${VERSION}.")
  endif()
endif()
 
# Final fallback: Just use a bogus version string that is semantically older
# than anything else and spit out a warning to the developer.
if(NOT DEFINED VERSION)
  set(VERSION v0.0.0-unknown)
  message(WARNING "Failed to determine VERSION from repository tags. Using default version \"${VERSION}\".")
endif()

configure_file(${SRC} ${DST} @ONLY)