AM_CFLAGS = \
    -I$(srcdir) \
    $(LOCPLA_CFLAGS) \
    $(GPSUTILS_CFLAGS) \
    $(QMIFW_CFLAGS) \
    -fno-short-enums \
    -D__func__=__PRETTY_FUNCTION__ \
    -DTARGET_USES_QCOM_BSP

h_sources = \
    location_service_v02.h \
    loc_api_v02_log.h \
    loc_api_v02_client.h \
    loc_api_sync_req.h \
    LocApiV02.h \
    loc_util_log.h

library_includedir = $(includedir)
library_include_HEADERS = $(h_sources)

libloc_api_v02_la_SOURCES = \
    LocApiV02.cpp \
    loc_api_v02_log.cpp \
    loc_api_v02_client.cpp \
    loc_api_sync_req.cpp \
    location_service_v02.c

if USE_GLIB
libloc_api_v02_la_CFLAGS = -DUSE_GLIB $(AM_CFLAGS) @GLIB_CFLAGS@
libloc_api_v02_la_LDFLAGS = -lstdc++ -Wl,-z,defs -lpthread @GLIB_LIBS@ -shared  -version-number @LT_VERSION_NUMBER@
libloc_api_v02_la_CPPFLAGS = -DUSE_GLIB $(AM_CFLAGS) $(AM_CPPFLAGS) @GLIB_CFLAGS@
else
libloc_api_v02_la_CFLAGS = $(AM_CFLAGS)
libloc_api_v02_la_LDFLAGS = -lstdc++ -Wl,-z,defs -lpthread -shared  -version-number @LT_VERSION_NUMBER@
libloc_api_v02_la_CPPFLAGS = $(AM_CFLAGS) $(AM_CPPFLAGS)
endif

libloc_api_v02_la_CXXFLAGS = -std=c++0x
libloc_api_v02_la_LIBADD = -lstdc++ -ldl $(QMIFW_LIBS) $(GPSUTILS_LIBS)

#Create and Install libraries
lib_LTLIBRARIES = libloc_api_v02.la
