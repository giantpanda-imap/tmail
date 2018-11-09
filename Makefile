# ========================================================================
# Copyright      2013 Jonathan Abbey <jonabbey@arlut.utexas.edu>
# Copyright 2008-2011 Mark Crispin
# Copyright 1988-2008 University of Washington
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# ========================================================================


# Program:	IMAP Toolkit Makefile
#
# Author:	Mark Crispin
#
# Date:		7 December 1989
# Last Edited:	15 April 2013 (jonabbey)


# Normal command to build IMAP toolkit:
#  make <port> [EXTRAAUTHENTICATORS=xxx] [EXTRADRIVERS=xxx] [EXTRACFLAGS=xxx]
#	       [PASSWDTYPE=xxx] [SSLTYPE=xxx] [IP=n]


# Port name.  These refer to the *standard* compiler on the given system.
# This means, for example, that the hpx port is for HP's compiler and not for
# a non-standard compiler such as gcc.
#
# If you are using gcc and it is not the standard compiler on your system, try
# using an ANSI port that is close to what you have.  For example, if your
# system is SVR4ish, try lnx; if it's more BSDish, try mct, or bsi.
#
# The following ports are bundled:
# bsf	FreeBSD
# bsi	BSD/i386
# bso	OpenBSD (yes, yet another one...)
# cyg	Cygwin
# ldb	Debian Linux
# lfd	Fedora Linux
# lnx	Linux with traditional passwords and crypt() in the C library
#	 (see lnp, and slx)
# lnp	Linux with Pluggable Authentication Modules (PAM)
# lmd	Mandrake Linux
# lsu	SuSE Linux
# mnt	Atari ST Mint (not MacMint) aka FreeMint
# neb	NetBSD
# osi	Apple iPhone and iPod Touch
# osx	Mac OS X
# oxp	Mac OS X with Pluggable Authentication Modules (PAM)
# slx	Linux using -lcrypt to get the crypt() function


# Extra authenticators (e.g. OTP, Kerberos, etc.).  Adds linkage for
# auth_xxx.c and executes Makefile.xxx, where xxx is the name of the
# authenticator.  Some authenticators are only available from third parties.
#
# The following extra authenticators are bundled:
# gss	Kerberos V

EXTRAAUTHENTICATORS=


# Additional mailbox drivers.  Add linkage for xxxdriver.  Some drivers are
# only available from third parties.
#
# The following extra drivers are bundled:
# mbox	if file "mbox" exists on the home directory, automatically moves mail
#	 from the spool directory to "mbox" and uses "mbox" as INBOX.

EXTRADRIVERS=mbox


# Plaintext password type.  Defines how plaintext password authentication is
# done on this system.
#
# The following plaintext login types are bundled:
# afs	AFS authentication database
# dce	DCE authentication database
# gss	Kerberos V
# nul	plaintext authentication never permitted
# pam	PAM authentication (note: for Linux, you should use the "lnp" port
#	 instead of setting this...also, you may have to modify PAMLDFLAGS
#	 in the imap-[]/src/osdep/unix/Makefile
# std	system standard (typically passwd file), determined by port
# two	try alternative (defined by CHECKPWALT), then std

PASSWDTYPE=std


# SSL type.  Defines whether or not SSL support is on this system
#
# The following SSL types are bundled:
# none	no SSL support
# unix	SSL support using OpenSSL
# nopwd	SSL support using OpenSSL, and plaintext authentication permitted only
#	in SSL/TLS sessions
# unix.nopwd	same as nopwd
#
# SSLTYPE=nopwd is now the default as required by RFC 3501

SSLTYPE=nopwd


# IP protocol version
#
# The following IP protocol versions are defined:
# 4	(default) IPv4 support only
# 6	IPv6 and IPv4 support

IP=4
IP6=6


# The following extra compilation flags are defined.  None of these flags are
# recommended.  If you use these, include them in the EXTRACFLAGS.
#
# -DDISABLE_POP_PROXY
#	By default, the ipop[23]d servers offer POP->IMAP proxy access,
#	which allow a POP client to access mail on an IMAP server by using the
#	POP server as a go-between.  Setting this option disables this
#	facility.
#
# -DOLDFILESUFFIX=\"xxx\"
#	Change the default suffix appended to the backup .newsrc file from
#	"old".
#
# -DSTRICT_RFC822_TIMEZONES
#	Disable recognition of the non-standard UTC (0000), MET (+0100),
#	EET (+0200), JST (+0900), ADT (-0300), AST (-0400), YDT (-0800),
#	YST (-0900), and HST (-1000) symbolic timezones.
#
# -DBRITISH_SUMMER_TIME
#	Enables recognition of non-standard symbolic timezone BST as +0100.
#
# -DBERING_STANDARD_TIME
#	Enables recognition of non-standard symbolic timezone BST as -1100.
#
# -DNEWFOUNDLAND_STANDARD_TIME
#	Enables recognition of non-standard symbolic timezone NST as -0330.
#
# -DNOME_STANDARD_TIME
#	Enables recognition of non-standard symbolic timezone NST as -1100.
#
# -DSAMOA_STANDARD_TIME
#	Enables recognition of non-standard symbolic timezone SST as -1100.
#				
# -DY4KBUGFIX
#	Turn on the Y4K bugfix (yes, that's year 4000).  It isn't well-known,
#	but century years evenly divisible by 4000 are *not* leap years in the
#	Gregorian calendar.  A lot of "Y2K compilant" software does not know
#	about this rule.  Remember to turn this on sometime in the next 2000
#	years.
#
# -DUSEORTHODOXCALENDAR
#	Use the more accurate Eastern Orthodox calendar instead of the
#	Gregorian calendar.  The century years which are leap years happen
#	at alternating 400 and 500 year intervals without shifts every 4000
#	years.  The Orthodox and Gregorian calendars diverge by 1 day for
#	gradually-increasing intervals, starting at 2800-2900, and becoming
#	permanent at 48,300.
#
# -DUSEJULIANCALENDAR
#	Use the less accurate Julian calendar instead of the Gregorian
#	calendar.  Leap years are every 4 years, including century years.
#	My apologies to those in the English-speaking world who object to
#	the reform of September 2, 1752 -> September 14, 1752, since this
#	code still uses January 1 (which Julius Ceasar decreed as the start
#	of the year, which since 153 BCE was the day that Roman consuls
#	took office), rather than the traditional March 25 used by the
#	British.  As of 2005, the Julian calendar and the Gregorian calendar
#	diverge by 15 days.

EXTRACFLAGS=


# Extra linker flags (additional/alternative libraries, etc.)

EXTRALDFLAGS=


# Special make flags (e.g. to override make environment variables)

EXTRASPECIALS=
SPECIALS=


# Normal commands

CAT=cat
CD=cd
LN=ln -s
MAKE=make
MKDIR=mkdir
BUILDTYPE=rebuild
RM=rm -rf
SH=sh
SYSTEM=unix
TOOLS=tools
TOUCH=touch


# Primary build command

BUILD=$(MAKE) build EXTRACFLAGS='$(EXTRACFLAGS)'\
 EXTRALDFLAGS='$(EXTRALDFLAGS)'\
 EXTRADRIVERS='$(EXTRADRIVERS)'\
 EXTRAAUTHENTICATORS='$(EXTRAAUTHENTICATORS)'\
 PASSWDTYPE=$(PASSWDTYPE) SSLTYPE=$(SSLTYPE) IP=$(IP)\
 EXTRASPECIALS='$(EXTRASPECIALS)'


# Make the IMAP Toolkit

all:	c-client SPECIALS rebuild bundled

c-client:
	@echo Not processed yet.  In a first-time build, you must specify
	@echo the system type so that the sources are properly processed.
	@false


SPECIALS:
	echo $(SPECIALS) > SPECIALS


bsi lnp lyn mct mnt slx: an
	$(BUILD) BUILDTYPE=$@

# Knotheads moved Kerberos and SSL locations on these platforms

# Paul Vixie claims that all FreeBSD versions have working IPv6

bsf:	an
	$(TOUCH) ip6
	$(BUILD) BUILDTYPE=$@ IP=$(IP6) \
	PASSWDTYPE=pam \
	SPECIALS="GSSINCLUDE=/usr/include GSSLIB=/usr/lib PAMLDFLAGS=-lpam"

# I assume that Theo did the right thing for IPv6.  OpenBSD does not have PAM.

bso:	an
	$(TOUCH) ip6
	$(BUILD) BUILDTYPE=$@ IP=$(IP6) \
	SPECIALS="GSSINCLUDE=/usr/include GSSLIB=/usr/lib"

# Info from Joel Reicher about NetBSD SSL paths.  I assume it has PAM because pam is in NetBSD sources...

neb:	an
	$(TOUCH) ip6
	$(BUILD) BUILDTYPE=$@ IP=$(IP6) \
	PASSWDTYPE=pam \
	SPECIALS="GSSINCLUDE=/usr/include GSSLIB=/usr/lib PAMLDFLAGS=-lpam"

cyg:	an
	$(BUILD) BUILDTYPE=cyg \

ldb:	an
	$(BUILD) BUILDTYPE=lnp IP=$(IP6) \
	SPECIALS="GSSINCLUDE=/usr/include GSSLIB=/usr/lib MAILSPOOL=/var/mail"

lfd:	an
	$(BUILD) BUILDTYPE=lnp IP=$(IP6) \
	SPECIALS="GSSDIR=/usr/kerberos"

lmd:	an
	$(BUILD) BUILDTYPE=lnp IP=$(IP6) \
	SPECIALS="GSSINCLUDE=/usr/include GSSLIB=/usr/lib"

lsu:	an
	$(BUILD) BUILDTYPE=lnp IP=$(IP6) \
	SPECIALS="GSSDIR=/usr/kerberos"

# iToy does not have Kerberos or PAM.  It doesn't have a
# /System/Library/OpenSSL directory either, but the libcrypto shared library
# has these locations so this is what we will use.

osi:	an
	$(TOUCH) ip6
	$(BUILD) BUILDTYPE=osx IP=$(IP6) CC=arm-apple-darwin-gcc \
	EXTRACFLAGS="$(EXTRACFLAGS) -DMAC_OSX_KLUDGE=1 -Dhash_create=Hash_create -Dhash_destroy=Hash_destroy -Dlogout=Logout" \

oxp:	an
	$(TOUCH) ip6
	$(BUILD) BUILDTYPE=osx IP=$(IP6) \
	PASSWDTYPE=pam \
	EXTRACFLAGS="$(EXTRACFLAGS) -DMAC_OSX_KLUDGE=1" \
	SPECIALS="GSSINCLUDE=/usr/include GSSLIB=/usr/lib PAMDLFLAGS=-lpam"


# Linux shadow password support doesn't build on traditional systems, but most
# Linux systems are shadow these days.

lnx:	lnxnul an
	$(BUILD) BUILDTYPE=$@

lnxnul:
	@$(SH) -c '(test $(PASSWDTYPE) = nul) || make lnxok'

lnxok:
	@echo You are building for traditional Linux.  Most modern Linux
	@echo systems require that you build using make slx.
	@echo Do you want to continue this build?  Type y or n please:
	@$(SH) -c 'read x; case "$$x" in y) exit 0;; *) exit 1;; esac'
	@echo OK, I will remember that you really want to build for
	@echo traditional Linux.  You will not see this message again.
	@echo If you discover that you can not log in to the POP and IMAP
	@echo servers, then do the following commands:
	@echo % rm lnxok
	@echo % make clean
	@echo % make slx
	@$(TOUCH) lnxok


# Courtesy entries for Microsoft systems

nt:
	nmake /nologo /f makefile.nt

ntk:
	nmake /nologo /f makefile.ntk

w2k:
	nmake /nologo /f makefile.w2k


# SSL build choices

sslnopwd sslunix.nopwd sslsco.nopwd:
	@echo +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	@echo + Building in full compliance with RFC 3501 security
	@echo + requirements:
	@echo ++ TLS/SSL encryption is supported
	@echo ++ Unencrypted plaintext passwords are prohibited
	@echo +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

sslunix sslsco:
	@echo +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	@echo + Building in PARTIAL compliance with RFC 3501 security
	@echo + requirements:
	@echo + Compliant:
	@echo ++ TLS/SSL encryption is supported
	@echo + Non-compliant:
	@echo ++ Unencrypted plaintext passwords are permitted
	@echo +
	@echo + In order to rectify this problem, you MUST build with:
	@echo ++ SSLTYPE=$(SSLTYPE).nopwd
	@echo +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	@echo
	@echo Do you want to continue this build anyway?  Type y or n please:
	@$(SH) -c 'read x; case "$$x" in y) exit 0;; *) (make nounenc;exit 1);; esac'

nounenc:
	@echo +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	@echo + At your request, this build with unencrypted authentication has
	@echo + been CANCELLED.
	@echo + You must start over with a new make command.
	@echo +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


sslnone:
	@echo +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	@echo + Building in NON-COMPLIANCE with RFC 3501 security requirements:
	@echo + Non-compliant:
	@echo ++ TLS/SSL encryption is NOT supported
	@echo ++ Unencrypted plaintext passwords are permitted
	@echo +
	@echo + In order to rectify this problem, you MUST build with:
	@echo ++ SSLTYPE=nopwd
	@echo + You must also have OpenSSL or equivalent installed.
	@echo +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	@echo
	@echo Do you want to continue this build anyway?  Type y or n please:
	@$(SH) -c 'read x; case "$$x" in y) exit 0;; *) (make nonossl;exit 1);; esac'

nonossl:
	@echo +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	@echo + At your request, this build with no TLS/SSL support has been
	@echo + CANCELLED.
	@echo + You must start over with a new make command.
	@echo +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


# IP build choices

ip4:
	@echo +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	@echo + Building with IPv4 support
	@echo +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

ip6:
	@echo +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	@echo + Building with IPv6 support
	@echo +
	@echo + NOTE: Some versions of glibc have a bug in the getaddrinfo
	@echo + call which does DNS name resolution.  This bug causes host
	@echo + names to be canonicalized incorrectly, as well as doing an
	@echo + unnecessary and performance-sapping reverse DNS call.  This
	@echo + problem does not affect the IPv4 gethostbyname call.
	@echo +
	@echo + getaddrinfo works properly on Mac OS X and Windows.  However,
	@echo + the problem has been observed on some Linux systems.
	@echo +
	@echo + If you answer n to the following question the build will be
	@echo + cancelled and you must rebuild.  If you did not specify IPv6
	@echo + yourself, try adding IP6=4 to the make command line.
	@echo +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	@echo
	@echo Do you want to build with IPv6 anyway?  Type y or n please:
	@$(SH) -c 'read x; case "$$x" in y) exit 0;; *) (make noip6;exit 1);; esac'
	@echo OK, I will remember that you really want to build with IPv6.
	@echo You will not see this message again.
	@$(TOUCH) ip6

noip6:
	$(MAKE) clean
	@echo +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	@echo + At your request, this build with IPv6 has been CANCELLED.
	@echo + You must start over with a new make command.
	@echo +
	@echo + If you wish to rebuild without IPv6 support, do one of the
	@echo + following:
	@echo +
	@echo + 1. If you specified IP=6 on the make command line, omit it.
	@echo +
	@echo + 2. Some of the Linux builds automatically select IPv6.  If
	@echo + you choose one of those builds, add IP6=4 to the make command
	@echo + line.  Note that this is IP6=4, not IP=4.
	@echo +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

# C compiler types

an ua:
	@$(MAKE) ssl$(SSLTYPE)
	@echo Applying $@ process to sources...
	$(TOOLS)/$@ "$(LN)" src/c-client c-client
	$(TOOLS)/$@ "$(LN)" src/ansilib c-client
	$(TOOLS)/$@ "$(LN)" src/charset c-client
	$(TOOLS)/$@ "$(LN)" src/osdep/$(SYSTEM) c-client
	$(TOOLS)/$@ "$(LN)" src/mtest mtest
	$(TOOLS)/$@ "$(LN)" src/ipopd ipopd
	$(TOOLS)/$@ "$(LN)" src/imapd imapd
	$(TOOLS)/$@ "$(LN)" src/mailutil mailutil
	$(TOOLS)/$@ "$(LN)" src/mlock mlock
	$(TOOLS)/$@ "$(LN)" src/dmail dmail
	$(TOOLS)/$@ "$(LN)" src/tmail tmail
	$(LN) $(TOOLS)/$@ .

build:	OSTYPE rebuild rebuildclean bundled

OSTYPE:
	@$(MAKE) ip$(IP)
	@echo Building c-client for $(BUILDTYPE)...
	@$(TOUCH) SPECIALS
	echo `$(CAT) SPECIALS` $(EXTRASPECIALS) > c-client/SPECIALS
	$(CD) c-client;$(MAKE) $(BUILDTYPE) EXTRACFLAGS='$(EXTRACFLAGS)'\
	 EXTRALDFLAGS='$(EXTRALDFLAGS)'\
	 EXTRADRIVERS='$(EXTRADRIVERS)'\
	 EXTRAAUTHENTICATORS='$(EXTRAAUTHENTICATORS)'\
	 PASSWDTYPE=$(PASSWDTYPE) SSLTYPE=$(SSLTYPE) IP=$(IP)\
	 $(SPECIALS) $(EXTRASPECIALS)
	echo $(BUILDTYPE) > OSTYPE
	$(TOUCH) rebuild

rebuild:
	@$(SH) -c '(test $(BUILDTYPE) = rebuild -o $(BUILDTYPE) = `$(CAT) OSTYPE`) || (echo Already built for `$(CAT) OSTYPE` -- you must do \"make clean\" first && exit 1)'
	@echo Rebuilding c-client for `$(CAT) OSTYPE`...
	@$(TOUCH) SPECIALS
	$(CD) c-client;$(MAKE) all CC="`$(CAT) CCTYPE`" \
	 CFLAGS="`$(CAT) CFLAGS`" `$(CAT) SPECIALS`

rebuildclean:
	$(SH) -c '$(RM) rebuild || true'

bundled:
	@echo Building bundled tools...
	$(CD) mtest;$(MAKE)
	$(CD) ipopd;$(MAKE)
	$(CD) imapd;$(MAKE)
	$(CD) mailutil;$(MAKE)
	@$(SH) -c '(test -f /usr/include/sysexits.h ) || make sysexitwarn'
	$(CD) mlock;$(MAKE) || true
	$(CD) dmail;$(MAKE) || true
	$(CD) tmail;$(MAKE) || true


sysexitwarn:
	@echo +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	@echo + Hmm...it does not look like /usr/include/sysexits.h exists.
	@echo + Either your system is too ancient to have the sysexits.h
	@echo + include, or your C compiler gets it from some other location
	@echo + than /usr/include.  If your system is too old to have the
	@echo + sysexits.h include, you will not be able to build the
	@echo + following programs.
	@echo +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

clean:
	@echo Removing old processed sources and binaries...
	$(SH) -c '$(RM) an ua OSTYPE SPECIALS c-client mtest imapd ipopd mailutil mlock dmail tmail ip6 || true'
	$(CD) tools;$(MAKE) clean


# A monument to a hack of long ago and far away...
love:
	@echo not war?
