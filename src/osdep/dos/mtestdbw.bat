@ECHO OFF
REM ========================================================================
REM Copyright 1988-2006 University of Washington
REM
REM Licensed under the Apache License, Version 2.0 (the "License");
REM you may not use this file except in compliance with the License.
REM You may obtain a copy of the License at
REM
REM     http://www.apache.org/licenses/LICENSE-2.0
REM
REM ========================================================================

REM Program:	Portable C client makefile -- MS-DOS B&W link
REM
REM Author:	Mark Crispin
REM
REM Date:	26 June 1994
REM Last Edited:30 August 2006

link /NOI /stack:32767 mtest.obj,mtest.exe,,cclient.lib llbwtcp.lib llibce.lib
