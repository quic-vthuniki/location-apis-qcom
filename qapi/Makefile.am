AM_CFLAGS = \
    -DDEBUG \
    -I $(srcdir)/src/ \
    -I $(srcdir)/inc/ \
    -I $(top_srcdir)/client_api/inc \
    $(GPSUTILS_CFLAGS) \
    -std=c++17

ACLOCAL_AMFLAGS = -I m4
AM_CPPFLAGS = -std=c++17

requiredlibs = \
    $(GPSUTILS_LIBS) \
    ../client_api/liblocation_client_api.la

h_sources = \
    inc/qapi_location.h

c_sources = \
    src/qapi_location.cpp

library_includedir = $(includedir)
library_include_HEADERS = $(h_sources)

liblocation_qapi_la_SOURCES = \
    $(c_sources) $(h_sources)

######################
# Build location_qapi
######################

if USE_GLIB
liblocation_qapi_la_CFLAGS = -DUSE_GLIB $(AM_CFLAGS) @GLIB_CFLAGS@
liblocation_qapi_la_LDFLAGS = -lstdc++ -g -Wl,-z,defs -lpthread @GLIB_LIBS@ -shared  -version-number @LT_VERSION_NUMBER@
liblocation_qapi_la_CPPFLAGS = -DUSE_GLIB $(AM_CFLAGS) $(AM_CPPFLAGS) @GLIB_CFLAGS@
else
liblocation_qapi_la_CFLAGS = $(AM_CFLAGS)
liblocation_qapi_la_LDFLAGS = -lstdc++ -Wl,-z,defs -lpthread -shared  -version-number @LT_VERSION_NUMBER@
liblocation_qapi_la_CPPFLAGS = $(AM_CFLAGS) $(AM_CPPFLAGS)
endif

liblocation_qapi_la_LIBADD = $(requiredlibs) -lstdc++

#Create and Install libraries
lib_LTLIBRARIES = liblocation_qapi.la
