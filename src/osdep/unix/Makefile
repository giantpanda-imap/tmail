# ========================================================================
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

# Program:	C client makefile
#
# Author:	Mark Crispin
#
# Date:		11 May 1989
# Last Edited:	29 August 2011


# Command line build parameters

EXTRAAUTHENTICATORS=
EXTRADRIVERS=mbox
PASSWDTYPE=std
SSLTYPE=nopwd
IP=4


# The optimization level here for GCC ports is set here for a reason.  It's
# to get you to read this text.
# The general concensus seems to be that -O2 is the one to use.
# Over the years, I've been told to use many different settings, including -O6.
# In recent versions of GCC [as of 2/2005], -O6 generates bad code that, among
# other ill effects, causes infinite loops.
# -O3 seems to be safe, but empirical observation from our local expert
# indicates that in some (many?) cases -O3 code runs slower than -O2.

GCCOPTLEVEL= -O2


# Try to have some consistency in GCC builds.  We want optimization, but we
# also want to be able to debug.

GCCCFLAGS= -g $(GCCOPTLEVEL) -pipe -fno-omit-frame-pointer
GCC4CFLAGS= $(GCCCFLAGS) -Wno-pointer-sign


# Extended flags needed for SSL.  You may need to modify.

SSLDIR=/usr/local/ssl
SSLCERTS=$(SSLDIR)/certs
SSLKEYS=$(SSLCERTS)
SSLINCLUDE=$(SSLDIR)/include
SSLLIB=$(SSLDIR)/lib

SSLCRYPTO=-lcrypto

# RSA Security Inc. released the RSA public key encryption algorithm into
# the public domain on September 6, 2000.  There is no longer any need to
# use RSAREF.
SSLRSA= # -lRSAglue -lrsaref

SSLCFLAGS= -I$(SSLINCLUDE) -I$(SSLINCLUDE)/openssl\
 -DSSL_CERT_DIRECTORY=\"$(SSLCERTS)\" -DSSL_KEY_DIRECTORY=\"$(SSLKEYS)\"
SSLLDFLAGS= -L$(SSLLIB) -lssl $(SSLCRYPTO) $(SSLRSA) $(EXTRALDFLAGS)


# Extended flags needed for non-standard passwd types.  You may need to modify.

AFSDIR=/usr/afsws
AFSCFLAGS=-I$(AFSDIR)/include
AFSLIB=$(AFSDIR)/lib
AFSLDFLAGS=-L$(AFSLIB)/afs -L$(AFSLIB) -L$(AFSDIR)/domestic/lib\
 -lkauth -lprot -lubik -lauth -lrxkad -lrx -llwp -ldes -lcom_err\
 $(AFSLIB)/afs/util.a -laudit -lsys
# AFSLDFLAGS may also need -L/usr/ucblib -lucb
DCECFLAGS= -DDCE_MINIMAL -DPASSWD_OVERRIDE=\"/opt/pop3/passwd/passwd\"
DCELDFLAGS= -ldce
PAMLDFLAGS= -lpam -ldl


# Build parameters normally set by the individual port

CHECKPW=std
LOGINPW=std
SIGTYPE=bsd
CRXTYPE=std
ACTIVEFILE=/var/lib/news/active
SPOOLDIR=/var/spool
MAILSPOOL=$(SPOOLDIR)/mail
NEWSSPOOL=$(SPOOLDIR)/news
RSHPATH=/usr/bin/rsh
MD5PWD=/etc/cram-md5.pwd
# Tries one of the test alternatives below if not specified.
LOCKPGM=
# Test alternatives if LOCKPGM not specified
LOCKPGM1=/usr/libexec/mlock
LOCKPGM2=/usr/sbin/mlock
LOCKPGM3=/etc/mlock
LOCKPGM4=/usr/bin/mlock


# Default formats for creating new mailboxes and for empty mailboxes in the
# default namespace; must be set to the associated driver's prototype.
#
# The CREATEPROTO is the default format for new mailbox creation.
# The EMPTYPROTO is the default format for handling zero-byte files.
#
# Normally, this is set by the individual port.
#
# NOTE: namespace formats (e.g. mh and news) can not be set as a default format
# since they do not exist in the default namespace.  Also, it is meaningless to
# set certain other formats (e.g. mbx, mx, and mix) as the EMPTYPROTO since
# these formats can never be empty files.

CREATEPROTO=unixproto
EMPTYPROTO=unixproto


# Commands possibly overriden by the individual port

ARRC=ar rc
CC=cc
LN=ln -s
RANLIB=ranlib


# Standard distribution build parameters

DEFAULTAUTHENTICATORS=ext md5 pla log
#
# mh needs to be after any other directory format drivers (such as mx or mix)
# since otherwise mh will seize any directory that is under the mh path.
# However, mh needs to be before any sysinbox formats (such as mmdf or unix)
# since otherwise INBOX won't work correctly when mh_allow_inbox is set.
#
DEFAULTDRIVERS=imap nntp pop3 mix mx mbx tenex mtx mh mmdf unix news phile
CHUNKSIZE=65536

# Normally no need to change any of these

ARCHIVE=c-client.a
BINARIES=osdep.o mail.o misc.o newsrc.o smanager.o utf8.o utf8aux.o siglocal.o \
 dummy.o pseudo.o netmsg.o flstring.o fdstring.o \
 rfc822.o nntp.o smtp.o imap4r1.o pop3.o \
 unix.o mbx.o mmdf.o tenex.o mtx.o news.o phile.o mh.o mx.o mix.o
CFLAGS=-g

CAT=cat
MAKE=make
MV=mv
RM=rm -rf
SH=sh


# Primary build command

BUILD=$(MAKE) build EXTRACFLAGS='$(EXTRACFLAGS)'\
 EXTRALDFLAGS='$(EXTRALDFLAGS)'\
 EXTRADRIVERS='$(EXTRADRIVERS)' EXTRAAUTHENTICATORS='$(EXTRAAUTHENTICATORS)'\
 PASSWDTYPE=$(PASSWDTYPE) SSLTYPE=$(SSLTYPE) IP=$(IP)


# Here if no make argument established

missing: osdep.h
	$(MAKE) all `$(CAT) SPECIALS`

osdep.h:
	@echo You must specify what type of system
	@false


# Current ports

bsf:	# FreeBSD
	$(BUILD) `$(CAT) SPECIALS` OS=$@ \
	 SIGTYPE=psx CRXTYPE=nfs \
	 SPOOLDIR=/var \
	 ACTIVEFILE=/usr/local/news/lib/active \
	 RSHPATH=/usr/bin/rsh \
	 BASECFLAGS="$(GCCCFLAGS)" \
	 BASELDFLAGS="-lcrypt"

bsi:	# BSD/i386
	$(BUILD) `$(CAT) SPECIALS` OS=$@ \
	 CRXTYPE=nfs \
	 SPOOLDIR=/var NEWSSPOOL=/var/news/spool \
	 ACTIVEFILE=/var/news/etc/active \
	 RSHPATH=/usr/bin/rsh \
	 BASECFLAGS="$(GCCCFLAGS)"

bso:	# OpenBSD
	$(BUILD) `$(CAT) SPECIALS` OS=bsi \
	 SIGTYPE=psx CRXTYPE=nfs \
	 SPOOLDIR=/var \
	 ACTIVEFILE=/usr/local/news/lib/active \
	 RSHPATH=/usr/bin/rsh \
	 BASECFLAGS="$(GCCCFLAGS)"

cyg:	# Cygwin - note that most local file drivers don't work!!
	$(BUILD) `$(CAT) SPECIALS` OS=$@ \
	DEFAULTDRIVERS="imap nntp pop3 mbx unix phile" \
	SIGTYPE=psx CHECKPW=cyg LOGINPW=cyg CRXTYPE=std \
	SPOOLDIR=/var \
	ACTIVEFILE=/usr/local/news/lib/active \
	RSHPATH=/usr/bin/rsh \
	BASECFLAGS="$(GCCCFLAGS)" \
	BASELDFLAGS="-lcrypt" \
	CC=gcc

lnp:	# Linux Pluggable Authentication modules
	$(BUILD) `$(CAT) SPECIALS` OS=slx \
	 SIGTYPE=psx CHECKPW=pam CRXTYPE=nfs \
	 SPOOLDIR=/var/spool \
	 ACTIVEFILE=/var/lib/news/active \
	 RSHPATH=/usr/bin/rsh \
	 BASECFLAGS="$(GCCCFLAGS)" \
	 BASELDFLAGS="$(EXTRALDFLAGS) $(PAMLDFLAGS)"

lnx:	# Linux non-shadow passwords
	@echo You are building for traditional Linux *without* shadow
	@echo passwords and with the crypt function in the C library.
	@echo If your system has shadow passwords, or if crypt is not
	@echo in the C library, you must use slx!
	$(BUILD) `$(CAT) SPECIALS` OS=$@ \
	 SIGTYPE=psx CRXTYPE=nfs \
	 SPOOLDIR=/var/spool \
	 ACTIVEFILE=/var/lib/news/active \
	 RSHPATH=/usr/bin/rsh \
	 BASECFLAGS="$(GCCCFLAGS)"

mnt:	# Mint (FreeMint)
	$(BUILD) `$(CAT) SPECIALS` OS=$@ \
	 SIGTYPE=psx CRXTYPE=nfs \
	 SPOOLDIR=/var/spool \
	 ACTIVEFILE=/var/lib/news/active \
	 RSHPATH=/usr/bin/rsh \
	 BASECFLAGS="$(GCCCFLAGS)"

neb:	# NetBSD
	$(BUILD) `$(CAT) SPECIALS` OS=bsi \
	 CRXTYPE=nfs \
	 SPOOLDIR=/var \
	 ACTIVEFILE=/var/db/news/active \
	 RSHPATH=/usr/bin/rsh \
	 BASECFLAGS="$(GCCCFLAGS)" \
	 BASELDFLAGS="-lcrypt"

osx:	# Mac OS X
	$(BUILD) `$(CAT) SPECIALS` OS=$@ \
	 CRXTYPE=nfs \
	 SPOOLDIR=/var/spool MAILSPOOL=/var/mail \
	 RSHPATH=/usr/bin/rsh \
	 BASECFLAGS="$(GCC4CFLAGS)"

slx:	# Secure Linux
	@echo You are building for libc6/glibc versions of Secure Linux
	$(BUILD) `$(CAT) SPECIALS` OS=$@ \
	 SIGTYPE=psx CHECKPW=psx CRXTYPE=nfs \
	 SPOOLDIR=/var/spool \
	 ACTIVEFILE=/var/lib/news/active \
	 RSHPATH=/usr/bin/rsh \
	 BASECFLAGS="$(GCCCFLAGS)" \
	 BASELDFLAGS="-lcrypt"

# Build it!

build:	clean once $(ARCHIVE)

all:	$(ARCHIVE)

$(ARCHIVE): $(BINARIES)
	sh -c '$(RM) $(ARCHIVE) || true'
	@$(CAT) ./ARCHIVE
	@$(SH) ./ARCHIVE

.c.o:
	`$(CAT) CCTYPE` -c `$(CAT) CFLAGS` $*.c


# Cleanup

clean:
	sh -c '$(RM) auths.c crexcl.c ip_unix.c linkage.[ch] siglocal.c osdep*.[ch] *.o ARCHIVE *FLAGS *TYPE $(ARCHIVE) || true'


# Dependencies

dummy.o: mail.h misc.h osdep.h dummy.h
fdstring.o: mail.h misc.h osdep.h fdstring.h
flstring.o: mail.h misc.h osdep.h flstring.h
imap4r1.o: mail.h misc.h osdep.h imap4r1.h rfc822.h
mail.o: mail.h misc.h osdep.h rfc822.h linkage.h
mbx.o: mail.h misc.h osdep.h dummy.h
mh.o: mail.h misc.h osdep.h dummy.h
mix.o: mail.h misc.h osdep.h dummy.h
mx.o: mail.h misc.h osdep.h dummy.h
misc.o: mail.h misc.h osdep.h
mmdf.o: mail.h misc.h osdep.h pseudo.h dummy.h
mtx.o: mail.h misc.h osdep.h dummy.h
netmsg.o: mail.h misc.h osdep.h netmsg.h
news.o: mail.h misc.h osdep.h
newsrc.o: mail.h misc.h osdep.h newsrc.h
nntp.o: mail.h misc.h osdep.h netmsg.h smtp.h nntp.h rfc822.h
phile.o: mail.h misc.h osdep.h rfc822.h dummy.h
pseudo.o: pseudo.h
pop3.o: mail.h misc.h osdep.h rfc822.h
smanager.o: mail.h misc.h osdep.h
smtp.o: mail.h misc.h osdep.h smtp.h rfc822.h
rfc822.o: mail.h misc.h osdep.h rfc822.h
tenex.o: mail.h misc.h osdep.h dummy.h
unix.o: mail.h misc.h osdep.h unix.h pseudo.h dummy.h
utf8.o: mail.h misc.h osdep.h utf8.h tmap.c widths.c
utf8aux.o: mail.h misc.h osdep.h utf8.h


# OS-dependent

osdep.o:mail.h misc.h env.h fs.h ftl.h nl.h tcp.h \
	osdep.h env_unix.h tcp_unix.h \
	osdep.c env_unix.c fs_unix.c ftl_unix.c nl_unix.c tcp_unix.c ip_unix.c\
	auths.c crexcl.c flockcyg.c flocklnx.c flocksim.c fsync.c \
	gethstid.c getspnam.c \
	gr_wait.c gr_wait4.c gr_waitp.c \
	krb.c \
	auth_ext.c auth_gss.c auth_log.c auth_md5.c auth_ntl.c auth_pla.c \
	pmatch.c scandir.c setpgrp.c strerror.c truncate.c write.c \
	memmove.c memmove2.c memset.c \
	tz_bsd.c tz_nul.c tz_sv4.c \
	write.c sslstdio.c \
	strerror.c strpbrk.c strstr.c strtok.c strtoul.c \
	OSCFLAGS
	@echo Building OS-dependent module
	@echo If you get No such file error messages for files x509.h, ssl.h,
	@echo pem.h, buffer.h, bio.h, and crypto.h, that means that OpenSSL
	@echo is not installed on your system.  Either install OpenSSL first
	@echo or build with command: make `$(CAT) OSTYPE` SSLTYPE=none
	`$(CAT) CCTYPE` -c `$(CAT) CFLAGS` `$(CAT) OSCFLAGS` -c osdep.c

osdep.c: osdepbas.c osdepckp.c osdeplog.c osdepssl.c
	$(CAT) osdepbas.c osdepckp.c osdeplog.c osdepssl.c > osdep.c

osdepbas.c:
	@echo osdepbas.c not found...try make clean and new make
	@false

osdepckp.c:
	@echo osdepckp.c not found...try make clean and new make
	@false

osdeplog.c:
	@echo osdeplog.c not found...try make clean and new make
	@false

osdepssl.c:
	@echo osdepssl.c not found...try make clean and new make
	@false

siglocal.c:
	@echo siglocal.c not found...try make clean and new make
	@false

crexcl.c:
	@echo crexcl.c not found...do make clean and new make
	@false

ip_unix.c:
	@echo ip_unix.c not found...do make clean and new make
	@false

# Once-only environment setup

once:	onceenv ckp$(PASSWDTYPE) ssl$(SSLTYPE) osdep.c

onceenv:
	@echo Once-only environment setup...
	echo $(CC) > CCTYPE
	echo $(BASECFLAGS) '$(EXTRACFLAGS)' -DCHUNKSIZE=$(CHUNKSIZE) > CFLAGS
	echo -DCREATEPROTO=$(CREATEPROTO) -DEMPTYPROTO=$(EMPTYPROTO) \
	 -DMD5ENABLE=\"$(MD5PWD)\" -DMAILSPOOL=\"$(MAILSPOOL)\" \
	 -DANONYMOUSHOME=\"$(MAILSPOOL)/anonymous\" \
	 -DACTIVEFILE=\"$(ACTIVEFILE)\" -DNEWSSPOOL=\"$(NEWSSPOOL)\" \
	 -DRSHPATH=\"$(RSHPATH)\" -DLOCKPGM=\"$(LOCKPGM)\" \
	 -DLOCKPGM1=\"$(LOCKPGM1)\" -DLOCKPGM2=\"$(LOCKPGM2)\" \
	 -DLOCKPGM3=\"$(LOCKPGM3)\" -DLOCKPGM4=\"$(LOCKPGM4)\" > OSCFLAGS
	echo $(BASELDFLAGS) $(EXTRALDFLAGS) > LDFLAGS
	echo "$(ARRC) $(ARCHIVE) $(BINARIES);$(RANLIB) $(ARCHIVE)" > ARCHIVE
	echo $(OS) > OSTYPE
	./drivers $(EXTRADRIVERS) $(DEFAULTDRIVERS) dummy
	./mkauths $(EXTRAAUTHENTICATORS) $(DEFAULTAUTHENTICATORS)
	echo "  mail_versioncheck (CCLIENTVERSION);" >> linkage.c
	$(LN) os_$(OS).h osdep.h
	$(LN) os_$(OS).c osdepbas.c
	$(LN) log_$(LOGINPW).c osdeplog.c
	$(LN) sig_$(SIGTYPE).c siglocal.c
	$(LN) crx_$(CRXTYPE).c crexcl.c
	$(LN) ip$(IP)_unix.c ip_unix.c
	sh -c '(test $(OS) = sc5 -o $(OS) = sco -o ! -f /usr/include/sys/statvfs.h) && echo -DNOFSTATVFS >> OSCFLAGS || fgrep statvfs64 /usr/include/sys/statvfs.h > /dev/null || echo -DNOFSTATVFS64 >> OSCFLAGS'


# Password checkers

ckpafs:	# AFS
	@echo AFS password authentication
	echo $(AFSCFLAGS) >> OSCFLAGS
#	echo $(AFSLDFLAGS) >> LDFLAGS
# Note: Steve Roseman says that AFS libraries have to be lunk before SSL
	echo $(AFSLDFLAGS) `$(CAT) LDFLAGS` > LDFLAGS.tmp
	mv LDFLAGS.tmp LDFLAGS
	$(LN) ckp_afs.c osdepckp.c

ckpdce:	# DCE
	@echo DCE password authentication
	echo $(DCECFLAGS) >> OSCFLAGS
	echo $(DCELDFLAGS) >> LDFLAGS
	$(LN) ckp_dce.c osdepckp.c

ckpgss:	# Kerberos V (must have gss EXTRAAUTHENTICATOR as well)
	@echo Kerberos V password authentication
	$(LN) ckp_gss.c osdepckp.c

ckpnul:	# NUL authenticator (disables all plaintext authentication)
	@echo Plaintext authentication prohibited
	echo "  mail_parameters (NIL,SET_DISABLEPLAINTEXT,(void *) 1);" >> linkage.c
	$(LN) ckp_nul.c osdepckp.c

ckppam:	# Pluggable Authentication Modules authenticator
	@echo PAM password authentication
	echo $(PAMLDFLAGS) >> LDFLAGS
	$(LN) ckp_pam.c osdepckp.c

ckpstd:	# Port standard
	@echo Standard password authentication
	$(LN) ckp_$(CHECKPW).c osdepckp.c

ckptwo:	# Something plus standard
	@echo $(CHECKPWALT) password authentication first, then standard
	$(CAT) ckp_1st.c ckp_$(CHECKPWALT).c ckp_2nd.c ckp_$(CHECKPW).c \
	 ckp_3rd.c > osdepckp.c


# SSL support

sslnone:# No SSL
	@echo Building without SSL support
	$(LN) ssl_none.c osdepssl.c

sslnopwd: sslunix snopwd

sslunix.nopwd: sslnopwd

sslunix: sbasic sldunix

sbasic:	# UNIX OpenSSL
	@echo Building with SSL
	$(LN) ssl_unix.c osdepssl.c
	echo $(SSLCFLAGS) >> OSCFLAGS
	echo "  ssl_onceonlyinit ();" >> linkage.c

snopwd:	# Plaintext disable
	@echo Building with SSL and plaintext passwords disabled unless SSL/TLS
	echo "  mail_parameters (NIL,SET_DISABLEPLAINTEXT,(void *) 2);" >> linkage.c

sldunix:# Normal UNIX SSL load flags
	echo $(SSLLDFLAGS) >> LDFLAGS


# A monument to a hack of long ago and far away...

love:
	@echo not war?
