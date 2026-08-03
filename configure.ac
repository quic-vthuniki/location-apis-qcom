# configure.ac -- Autoconf script for gps location-apis
#
# Process this file with autoconf to produce a configure script

# Requires autoconf tool later than 2.61
AC_PREREQ(2.61)
# Initialize the gps location-apis package version 1.0.0
AC_INIT([location-apis],1.0.0)
# Does not strictly follow GNU Coding standards
AM_INIT_AUTOMAKE([foreign subdir-objects])
# Disables auto rebuilding of configure, Makefile.ins
AM_MAINTAINER_MODE
# Verifies the --srcdir is correct by checking for the path
AC_CONFIG_SRCDIR([Makefile.am])
# defines some macros variable to be included by source
AC_CONFIG_HEADERS([config.h])
AC_CONFIG_MACRO_DIR([m4])

# Checks for programs.
AC_PROG_LIBTOOL
AC_PROG_CXX
AC_PROG_CC
AM_PROG_CC_C_O
AC_PROG_AWK
AC_PROG_CPP
AC_PROG_INSTALL
AC_PROG_LN_S
AC_PROG_MAKE_SET
PKG_PROG_PKG_CONFIG

m4_define([LT_MAJOR], [1])
m4_define([LT_MINOR], [0])
m4_define([LT_PATCH], [0])

AC_SUBST([LT_VERSION], LT_MAJOR.LT_MINOR.LT_PATCH)
AC_SUBST([LT_VERSION_NUMBER], LT_MAJOR:LT_MINOR:LT_PATCH)

# Checks for libraries.
AC_PATH_PROG([PROTOC], [protoc])
if test "x$PROTOC" = "x"; then
      AC_MSG_ERROR([protoc compiler not found])
fi

PKG_CHECK_MODULES([GPSUTILS], [location-hal])
AC_SUBST([GPSUTILS_CFLAGS])
AC_SUBST([GPSUTILS_LIBS])

AC_ARG_WITH([qmi],
    AC_HELP_STRING([--with-qmi=DIR],
                   [Specify the location of the qmi-framework headers, bypassing pkg-config]),
    [qmidir=$withval],
    [qmidir=""])

if test "x$qmidir" != "x"; then
    QMIFW_CFLAGS="-I${qmidir}"
    QMIFW_LIBS="-lqcci -lqcsi -lqencdec -lqmi_common"
else
    PKG_CHECK_MODULES([QMIFW], [qmi-framework])
fi
AC_SUBST([QMIFW_CFLAGS])
AC_SUBST([QMIFW_LIBS])

PKG_CHECK_MODULES([PROTOBUF], [protobuf >= 25.3],
        [protobuf_update=yes], [protobuf_update=no])

AC_MSG_NOTICE([Have updated protobuf version - ${protobuf_update}])
AM_CONDITIONAL([PROTOBUF_INC_LIBS], [test "${protobuf_update}" = "yes"])

AC_CHECK_FUNCS([strlcpy strlcat])

if test "x$ac_cv_func_strlcpy" = "xno"; then
    AC_DEFINE([USE_G_STRLCPY], [1], [use G LIB Strcpy])
    AM_CONDITIONAL([USE_G_STRLCPY], [true])
else
    AC_DEFINE([USE_G_STRLCPY], [0], [Do not use G LIB Strcpy])
    AM_CONDITIONAL([USE_G_STRLCPY], [false])
fi

if test "x$ac_cv_func_strlcat" = "xno"; then
    AC_DEFINE([USE_G_STRLCAT], [1], [use G LIB Strcat])
    AM_CONDITIONAL([USE_G_STRLCAT], [true])
else
    AC_DEFINE([USE_G_STRLCAT], [0], [Do not use G LIB Strcat])
    AM_CONDITIONAL([USE_G_STRLCAT], [false])
fi

AC_ARG_WITH([external_ap],
    AC_HELP_STRING([--with-external_ap=@<:@dir@:>@],
        [Using External Application Processor]),
    [],
    with_external_ap=no)

if test "x$with_external_ap" != "xno"; then
    CPPFLAGS="${CPPFLAGS} -DFEATURE_EXTERNAL_AP"
fi

AM_CONDITIONAL(USE_EXTERNAL_AP, test "x${with_external_ap}" = "xyes")

AC_ARG_WITH([qsocket],
       AC_HELP_STRING([--with-qsocket], [kernel supports qsocket]))

AM_CONDITIONAL(USE_QSOCKET, test "x${with_qsocket}" = "xyes")

AC_ARG_WITH([systemd],
      AC_HELP_STRING([--with-systemd],
         [systemd enable, building LE systems which has systemd]))

AM_CONDITIONAL(USE_SYSTEMD, test "x${with_systemd}" = "xyes")

AC_ARG_WITH([auto_feature],
    AC_HELP_STRING([--with-auto_feature=@<:@dir@:>@],
        [Using Automotive feature]),
    [],
    with_auto_feature=no)

if test "x$with_auto_feature" != "xno"; then
    CPPFLAGS="${CPPFLAGS} -DFEATURE_AUTOMOTIVE"
fi

AM_CONDITIONAL(USE_FEATURE_AUTOMOTIVE, test "x${with_auto_feature}" = "xyes")

AC_ARG_WITH([locpla_includes],
      AC_HELP_STRING([--with-locpla-includes=@<:@dir@:>@],
         [specify the path to locpla-includes in loc-pla_git.bb]),
      [locpla_incdir=$withval],
      with_locpla_includes=no)

if test "x$with_locpla_includes" != "xno"; then
   AC_SUBST(LOCPLA_CFLAGS, "-I${locpla_incdir}")
fi

AC_SUBST([CPPFLAGS])

AC_ARG_WITH([glib],
      AC_HELP_STRING([--with-glib],
         [enable glib, building HLOS systems which use glib]))

if (test "x${with_glib}" = "xyes"); then
        AC_DEFINE(ENABLE_USEGLIB, 1, [Define if HLOS systems uses glib])
        PKG_CHECK_MODULES(GTHREAD, gthread-2.0 >= 2.16, dummy=yes,
                                AC_MSG_ERROR(GThread >= 2.16 is required))
        PKG_CHECK_MODULES(GLIB, glib-2.0 >= 2.16, dummy=yes,
                                AC_MSG_ERROR(GLib >= 2.16 is required))
        GLIB_CFLAGS="$GLIB_CFLAGS $GTHREAD_CFLAGS"
        GLIB_LIBS="$GLIB_LIBS $GTHREAD_LIBS"

        AC_SUBST(GLIB_CFLAGS)
        AC_SUBST(GLIB_LIBS)
fi

AM_CONDITIONAL(USE_GLIB, test "x${with_glib}" = "xyes")

AC_CONFIG_FILES([ \
        Makefile \
        location_api_msg_proto/Makefile \
        location_api_msg_proto/src/Makefile \
        loc_api/loc_api_v02/Makefile \
        utils/loc_socket/Makefile \
        client_api/Makefile \
        integration_api/Makefile \
        location_hal_daemon/Makefile \
        qapi/Makefile \
        location-apis.pc \
        ])

AC_OUTPUT
