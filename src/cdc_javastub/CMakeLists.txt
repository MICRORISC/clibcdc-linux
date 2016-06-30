cmake_minimum_required(VERSION 2.8)
set(project cdc_javastub)

find_package(Java REQUIRED)
find_package(JNI REQUIRED)

if (JNI_FOUND)
	message (STATUS "JNI_INCLUDE_DIRS=${JNI_INCLUDE_DIRS}")
	message (STATUS "JNI_LIBRARIES=${JNI_LIBRARIES}")
	include_directories(${JNI_INCLUDE_DIRS})
endif()

set(cdc_javastub_SRC_FILES
	${CMAKE_SOURCE_DIR}/src/CDCImpl.cpp
	${CMAKE_SOURCE_DIR}/src/CDCImplException.cpp
	${CMAKE_SOURCE_DIR}/src/CDCMessageParser.cpp
	${CMAKE_SOURCE_DIR}/src/CDCMessageParserException.cpp
	${CMAKE_SOURCE_DIR}/src/CDCReceiveException.cpp
	${CMAKE_SOURCE_DIR}/src/CDCSendException.cpp
	CDCLib_JavaStub.cpp
)

include_directories(${CMAKE_SOURCE_DIR}/include/cdc_javastub)
include_directories(${CMAKE_SOURCE_DIR}/include)

add_library(${project} SHARED ${cdc_javastub_SRC_FILES})

#target_link_libraries(${project} cdc)

install(TARGETS ${project} DESTINATION ${CMAKE_INSTALL_PREFIX}/lib)
