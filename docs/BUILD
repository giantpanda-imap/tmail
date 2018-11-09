/* ========================================================================
 * Copyright 1988-2007 University of Washington
 * Copyright 2008-2011 Mark Crispin
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * ========================================================================
 */

			 BUILD AND INSTALLATION NOTES
			 Last Updated: 15 April 2013

Table of Contents:
1. UNIX Build Notes
2. UNIX Installation Notes
3. Win32 Build Notes
4. Win32 Installation Notes


			       UNIX BUILD NOTES

     The default build on many systems with IPv4 only.  To build with IPv6,
add "IP=6" to the make command line, e.g.
	make lnp IP=6

     The default build is to build with SSL and disabling plaintext passwords
unless SSL/TLS encryption is in effect (SSLTYPE=nopwd).  This means that
OpenSSL MUST be installed before building the IMAP toolkit.  Please refer to
the SSLBUILD file for more information.

     To build without SSL, add "SSLTYPE=none" to the make command line.
Note that doing so will produce an IMAP server which is NON-COMPLIANT with
RFC 3501.

     You must build through the top-level panda-imap/Makefile, which will run
a "process" step the first time and create the panda-imap/c-client,
panda-imap/ipopd, and panda-imap/imapd directories in which building actually
takes place.

     Before doing a make on UNIX, you should read panda-imap/Makefile and see
if your system type is known.  The various system types are three-letter codes.
If your system type is known, then use this as the make option.  After the
first time you do a make, this option is remembered in a file called OSTYPE,
so just typing "make" suffices.

     For more generic builds, try slx (shadow passwords only) or lnp (PAM).

     There are other make options, described in panda-imap/src/osdep/Makefile.

     It's probably best to see if an existing port will work on your system
before inventing a new port.  Try:
	bsf		modern BSD

     If you must invent a new port, you need to create an entry in
panda-imap/Makefile and panda-imap/src/osdep/Makefile for your new port, as
well as osdep/os_???.h and osdep/os_???.c files with the appropriate
OS-dependent support for that system.  You also need to determine which setup
process to use. Note that some
compilers, support some aspects of ANSI C but not others;
c-client really beats on the full prototyping capability of ANSI C so you
have to use the non-ANSI source tree for such systems.

     If you send a new port back to us, we will make it available for others
who use your particular system type.

     The mbox driver is now enabled by default.  If the file "mbox" exists on
the user's home directory and is in UNIX mailbox format, then when INBOX is
opened this file will be selected as INBOX instead of the mail spool file.
Messages will be automatically transferred from the mail spool file into the
mbox file.  To disable this behavior, delete "mbox" from the EXTRADRIVERS list
in the top-level Makefile and rebuild.

			   UNIX INSTALLATION NOTES

     Binaries from the build are:
	panda-imap/mtest/mtest		c-client testbed program
	panda-imap/ipopd/ipop2d		POP2 daemon
	panda-imap/ipopd/ipop3d		POP3 daemon
	panda-imap/imapd/imapd		IMAP4rev1 daemon

     mtest is normally not used except by c-client developers.

STEP 1:	[x]inetd setup

     The ipop2d, ipop3d, and imapd daemons should be installed in a system
daemon directory and invoked by a listener such as xinetd or inetd.  In the
following examples, /usr/local/etc is used).

STEP 1(A): xinetd-specific setup

     If your system uses xinetd, the daemons are invoked by files in your
/etc/xinetd.d directory with names corresponding to the service names (that
is: imap, pop2, pop3).  You will need to consult your local xinetd
documentation to see what should go into these files.  Here is a a sample
/etc/xinetd.d/imap file:

service imap
{
	disable		= no
	socket_type	= stream
	wait		= no
	user		= root
	server		= /usr/local/etc/imapd
	groups		= yes
	flags		= REUSE IPv6
}

STEP 1(B): inetd-specific setup

     If your system still uses inetd, the daemons are invoked by your
/etc/inetd.conf file with lines such as:

pop	stream	tcp	nowait	root	/usr/local/etc/ipop2d	ipop2d
pop3	stream	tcp	nowait	root	/usr/local/etc/ipop3d	ipop3d
imap	stream	tcp	nowait	root	/usr/local/etc/imapd	imapd

     Note that different variants of UNIX have different versions of inetd,
so you should verify the precise form of these commands (for example, some
versions of inetd do not require the "nowait").

     IMPORTANT NOTE: inetd has a limit of how many new connections it will
allow in a certain interval, and when this limit is exceeded, it shuts down
the server.  If you have anything beyond a small-scale server, you are
probably going to run up against this limit.  You'll know when it happens;
your syslog will give the misleading message "imap/tcp server failing
(looping), service terminated" and users will complain that IMAP service is
unavailable for the next 10 minutes.  Similarly with "pop3/tcp server
failing"...

     It must be emphasized that this is *NOT* a bug in the IMAP or POP
servers, nor is it anything that I can "fix".  It is an inetd problem, and
the only way to fix it is to change inetd's behavior.

     By default, the parameters of this limit are (from inetd.c source code):

#define TOOMANY         40              /* don't start more than TOOMANY */
#define CNT_INTVL       60              /* servers in CNT_INTVL sec. */
#define RETRYTIME       (60*10)         /* retry after bind or server fail */

That is, no more than 40 connections (TOOMANY) in 60 seconds (CNT_INTL), and
if exceeded, shut down the server for 10 minutes (RETRYTIME).  This was a
good setting in the 1980s ARPAnet, but is much too small today.

     Some versions of inetd allow you to see a higher maximum in the
/etc/inetd.conf file.  Read "man inetd" and see if you see something like
this in the text:

     The wait/nowait entry is applicable to datagram sockets only [...]
     [...]  The optional ``max'' suffix (separated from
     ``wait'' or ``nowait'' by a dot) specifies the maximum number of server
     instances that may be spawned from inetd within an interval of 60 sec-
     onds. When omitted, ``max'' defaults to 40.

If you see this, then edit the /etc/inetd.conf entry for imapd to be
something like:

imap	stream	tcp	nowait.100	root	/usr/local/etc/imapd	imapd
 (or, if you use TCP wrappers)
imap	stream	tcp	nowait.100	root	/usr/local/etc/tcpd	imapd

     Otherwise, you'll need to edit the inetd source code to set TOOMANY to a
higher value, then rebuild inetd.


STEP 2:	services setup

     You may also have to edit your /etc/services (or Yellow Pages,
NetInfo, etc. equivalent) to register these services, such as:

pop		109/tcp
pop3		110/tcp
imap		143/tcp


STEP 3: PAM setup

     If your system has PAM (Pluggable Authentication Modules -- most
modern systems do) then you need to set up PAM authenticators for imap and
pop.  The correct file names are
	/etc/pam.d/imap
and
	/etc/pam.d/pop

     It probably works to copy your /etc/pam.d/ftpd file to the above two
names.

     Many people get these file names wrong, and then spend a lot of time
trying to figure out why it doesn't work.  Common mistakes are:
	/etc/pam.d/imapd
	/etc/pam.d/imap4
	/etc/pam.d/imap4rev1
	/etc/pam.d/ipop3d
	/etc/pam.d/pop3d
	/etc/pam.d/popd
	/etc/pam.d/pop3


STEP 4:	optional rimap setup

     If you want to enable the rimap capability, which allows users with a
suitable client and .rhosts file on the server to access IMAP services
without transmitting her password in the clear over the network, you need
to have /etc/rimapd as a link to the real copy of imapd.  Assuming you have
imapd installed on /usr/local/etc as above:
	% ln -s /usr/local/etc/imapd /etc/rimapd

     Technical note: rimap works by having the client routine tcp_aopen()
invoke `rsh _host_ exec /etc/rimapd' in an child process, and then returning
pipes to that process' standard I/O instead of a TCP socket.  You can set up
`e-mail only accounts' by making the shell be something which accepts only
that string and not ordinary UNIX shell commands.


STEP 4:	notes on privileges

     Neither user "root", not any other UID 0 account, can log in via IMAP or
POP.  "That's not a bug, it's a feature!"

     This software is designed to run without privileges.  The mail spool
directory must be protected 1777; that is, with world write and the sticky
bit.  Of course, mail *files* should be protected 600!

     An alternative to having the mail spool directory protected 1777, at the
cost of some performance, is to use the external "mlock" program, available
as part of the imap-utils package.  With mlock installed as /etc/mlock and
setgid mail, the spool directory can be protected 775 with group mail.
Please disregard this paragraph if you don't understand it COMPLETELY, and
know EXACTLY what to do without question.


STEP 5:	SVR4 specific setup

     There is one "gotcha" on System V Release 4 based systems such as
Solaris.  These systems do not use the standard UNIX mail format, but rather a
variant of that format that depends upon a bogus "Content-Length:" message
header.  This is widely recognized to have been a terrible mistake.  One
symptom of the problem is that under certain circumstances, a message may get
broken up into several messages.  I'm also aware of security bugs caused by
programs that foolishly trust "Content-Length:" headers with evil values.

    To fix your system, edit your sendmail.cf to change the Mlocal line to
have the -E flag.  A typical entry will lool like:

Mlocal, P=/usr/lib/mail.local, F=flsSDFMmnPE, S=10, R=20, A=mail.local -d $u

			      WIN32 BUILD NOTES

     Visual C++ 6.0 along with the current Microsoft Platform SDK
(specifically the CORE SDK and the Internet Development SDK) is required
to build on Windows 9x/Me/NT/2K/XP.  If you do not have the Platform SDK
installed or in your path properly, you'll get errors when building os_nt.c,
typically in env_nt.c, ssl_nt.c, ssl_w2k.c, or gss_shim.c.  You can download
the Microsoft Platform SDK from Microsoft's web site.

     There is also considerable debate about how new mail is to be snarfed.
I am currently using something that seems to work with WinSMTP.  Look at
the definition of MAILFILE in panda-imap/src/osdep/nt/mailfile.h and at the
sysinbox() function in panda-imap/src/osdep/nt/env_nt.c to see what's there
now, so you have a clue about how to hack it.

     To build under Windows 95/98/NT, connect to the panda-imap directory
and do:
	nmake -f makefile.nt
The resulting binaries will support SSL if either schannel.dll or
security.dll is installed in Windows, using the old, undocumented, SSL
interfaces.  You can also use this to build under Me/2000/XP, but it is
not the preferred build on this platform.

     To build with MIT Kerberos support, connect to the panda-imap directory
and do:
	nmake -f makefile.ntk
The resulting binaries will support SSL if either schannel.dll or
security.dll is installed in Windows, using the old, undocumented SSL
interfaces.  They will also support MIT Kerberos.  Note, however, that
these binaries will only run on systems which have the MIT Kerberos DLLs
installed, and will not run otherwise.

     To build under Windows Me/2000/XP, connect to the panda-imap directory
and do:
	nmake -f makefile.w2k
The resulting binaries will support SSL and Microsoft Kerberos, using the
official, documented, Microsoft interfaces.  Note, however, that these
binaries will not run under Windows 95, Windows 98, or Windows NT4.

			   WIN32 INSTALLATION NOTES

     The resulting binaries will be:
	panda-imap\mtest\mtest.exe	(testbed client)
	panda-imap\ipopd\ipop2d.exe	POP2 server
	panda-imap\ipopd\ipop3d.exe	POP3 server
	panda-imap\imapd\imapd.exe	IMAP4rev1 server

     These servers are stdio servers.  I wrote a simple network listener
for NT called inetlisn; currently it is available as:
	ftp://ftp.cac.washington.edu/mail/nt/inetlisn.tar
To build this, use "nmake" after connecting to the inetlisn directory.
inetlisn takes two arguments, the first being the port number and the second
being the binary to run to serve a connection on that port, e.g.
	c:\bin\inetlisn 143 c:\mail_daemons\imapd

     Note that NT imapd must be started as SYSTEM in order to be recognized as
being "not logged in"; otherwise it will preauth as whatever user it is
running as which is probably not what you want.  One way to have it run as
system is to have inetlisn run by an AT command, e.g. if the time now is
2:05PM, try something like:
	AT 14:06 "c:\bin\inetlisn 143 c:\mail_daemons\imapd"

     A more advanced network listener called wsinetd is available on:
	http://wsinetd.sourceforge.net
It is based on inetlisn, and essentially is a "completed" version of inetlisn.

     Bottom line: this is not plug-and-play.  If you're not a hacker and/or
are unwilling to invest the time to do some programming, you probably want to
buy a commercial server product.
