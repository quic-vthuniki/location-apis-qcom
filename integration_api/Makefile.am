AM_CFLAGS = \
    -DDEBUG \
    -I $(srcdir)/src/ \
    -I $(srcdir)/inc/ \
    -I $(top_srcdir)/location_api_msg_proto/src \
    -I $(top_srcdir)/client_api/inc \
    $(GPSUTILS_CFLAGS) \
    -std=c++17

ACLOCAL_AMFLAGS = -I m4
AM_CPPFLAGS = -std=c++17

requiredlibs = \
    $(GPSUTILS_LIBS) \
    ../location_api_msg_proto/src/liblocation_api_msg_proto.la \
    -lprotobuf-lite

h_sources = \
    src/LocationIntegrationApiImpl.h \
    inc/LocationIntegrationApi.h
c_sources = \
    src/LocationIntegrationApiImpl.cpp \
    src/LocationIntegrationApi.cpp

library_includedir = $(includedir)
library_include_HEADERS = inc/LocationIntegrationApi.h

liblocation_integration_api_la_SOURCES = \
    $(c_sources) $(h_sources)
liblocation_integration_api_la_h_sources = $(h_sources)

######################
# Build location_integration_api
######################

if USE_EXTERNAL_AP
AM_CFLAGS += -DFEATURE_EXTERNAL_AP
endif

if USE_GLIB
liblocation_integration_api_la_CFLAGS = -DUSE_GLIB $(AM_CFLAGS) @GLIB_CFLAGS@
liblocation_integration_api_la_LDFLAGS = -lstdc++ -g -Wl,-z,defs -lpthread @GLIB_LIBS@ -shared  -version-number @LT_VERSION_NUMBER@
liblocation_integration_api_la_CPPFLAGS = -DUSE_GLIB $(AM_CFLAGS) $(AM_CPPFLAGS) @GLIB_CFLAGS@
else
liblocation_integration_api_la_CFLAGS = $(AM_CFLAGS)
liblocation_integration_api_la_LDFLAGS = -lstdc++ -Wl,-z,defs -lpthread -shared  -version-number @LT_VERSION_NUMBER@
liblocation_integration_api_la_CPPFLAGS = $(AM_CFLAGS) $(AM_CPPFLAGS)
endif

liblocation_integration_api_la_LIBADD = $(requiredlibs) -lstdc++ -ldl

#Create and Install libraries
lib_LTLIBRARIES = liblocation_integration_api.la
