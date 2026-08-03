AM_CFLAGS = \
    -DDEBUG \
    -I $(srcdir)/src/ \
    -I $(srcdir)/inc/ \
    -I $(top_srcdir)/location_api_msg_proto/src \
    -I $(top_builddir)/location_api_msg_proto/src \
    $(GPSUTILS_CFLAGS) \
    -std=c++17

ACLOCAL_AMFLAGS = -I m4
AM_CPPFLAGS = -std=c++17

requiredlibs = \
    $(GPSUTILS_LIBS) \
    ../location_api_msg_proto/src/liblocation_api_msg_proto.la \
    -lprotobuf-lite

h_sources = \
    src/LocationClientApiImpl.h \
    src/LCAReportLoggerUtil.h \
    inc/LocationClientApi.h

c_sources = \
    src/LocationClientApiImpl.cpp \
    src/LocationClientApi.cpp \
    src/LCAReportLoggerUtil.cpp

library_includedir = $(includedir)
library_include_HEADERS = inc/LocationClientApi.h

liblocation_client_api_la_SOURCES = \
    $(c_sources) $(h_sources)
liblocation_client_api_la_h_sources = $(h_sources)

######################
# Build location_client_api
######################

if USE_EXTERNAL_AP
AM_CFLAGS += -DFEATURE_EXTERNAL_AP
endif

if USE_GLIB
liblocation_client_api_la_CFLAGS = -DUSE_GLIB $(AM_CFLAGS) @GLIB_CFLAGS@
liblocation_client_api_la_LDFLAGS = -lstdc++ -g -Wl,-z,defs -lpthread @GLIB_LIBS@ -shared  -version-number @LT_VERSION_NUMBER@
liblocation_client_api_la_CPPFLAGS = -DUSE_GLIB $(AM_CFLAGS) $(AM_CPPFLAGS) @GLIB_CFLAGS@
else
liblocation_client_api_la_CFLAGS = $(AM_CFLAGS)
liblocation_client_api_la_LDFLAGS = -lstdc++ -Wl,-z,defs -lpthread -shared  -version-number @LT_VERSION_NUMBER@
liblocation_client_api_la_CPPFLAGS = $(AM_CFLAGS) $(AM_CPPFLAGS)
endif

liblocation_client_api_la_LIBADD = $(requiredlibs) -lstdc++ -ldl

#Create and Install libraries
lib_LTLIBRARIES = liblocation_client_api.la
