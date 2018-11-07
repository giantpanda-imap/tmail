# ========================================================================
# Copyright 1988-2006 University of Washington
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# ========================================================================


# Program:	MTEST Makefile
#
# Author:	Mark Crispin
#
# Date:		25 February 1996
# Last Edited:	30 August 2006


C = ../c-client
CCLIENTLIB = $C/c-client.a
SHELL = /bin/sh

# Get local definitions from c-client directory

CC = `cat $C/CCTYPE`
CFLAGS = -I$C `cat $C/CFLAGS`
LDFLAGS = $(CCLIENTLIB) `cat $C/LDFLAGS`

all:	mtest

mtest: $(CCLIENTLIB) mtest.o
	$(CC) $(CFLAGS) -o mtest mtest.o $(LDFLAGS)

mtest.o: $C/mail.h $C/misc.h $C/osdep.h $C/rfc822.h $C/smtp.h $C/nntp.h

$(CCLIENTLIB):
	cd $C;make

clean:
	rm -f *.o mtest || true

# A monument to a hack of long ago and far away...
love:
	@echo 'not war?'
