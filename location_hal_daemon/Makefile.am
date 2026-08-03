AM_CFLAGS = \
    -DDEBUG \
    -I $(srcdir) \
    -I $(top_srcdir)/location_api_msg_proto/src \
    -I $(top_builddir)/location_api_msg_proto/src \
    $(GPSUTILS_CFLAGS) \
     -std=c++17

if USE_SYSTEMD
AM_CFLAGS += -DINIT_SYSTEM_SYSTEMD
else
AM_CFLAGS += -DINIT_SYSTEM_SYSV
endif

if USE_FEATURE_AUTOMOTIVE
AM_CFLAGS += -DFEATURE_AUTOMOTIVE
endif

requiredlibs = \
    $(GPSUTILS_LIBS) \
    ../location_api_msg_proto/src/liblocation_api_msg_proto.la \
    -lprotobuf-lite

h_sources = \
    LocHalDaemonClientHandler.h \
    LocationApiService.h

c_sources = \
    LocHalDaemonClientHandler.cpp \
    LocationApiService.cpp \
    main.cpp

location_hal_daemon_SOURCES = \
    $(c_sources) $(h_sources)

######################
# Build location_hal_daemon
######################

if USE_GLIB
location_hal_daemon_CFLAGS = -DUSE_GLIB $(AM_CFLAGS) @GLIB_CFLAGS@
location_hal_daemon_LDFLAGS = -lstdc++ -g -Wl,-z,defs -lpthread @GLIB_LIBS@
location_hal_daemon_CPPFLAGS = -DUSE_GLIB $(AM_CFLAGS) $(AM_CPPFLAGS) @GLIB_CFLAGS@
else
location_hal_daemon_CFLAGS = $(AM_CFLAGS)
location_hal_daemon_LDFLAGS = -Wl,-z,defs -lpthread
location_hal_daemon_CPPFLAGS = $(AM_CFLAGS) $(AM_CPPFLAGS)
endif

location_hal_daemon_LDADD = $(requiredlibs) -ldl

bin_PROGRAMS = location_hal_daemon

if USE_SYSTEMD
systemdsystemunit_DATA = location_hal_daemon.service
tmpfiles_DATA = location_hal_daemon-tmpfilesd.conf
endif

EXTRA_DIST = location_hal_daemon.service location_hal_daemon-tmpfilesd.conf
