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

REM Program:	Set default prototype for DOS/NT
REM
REM Author:	Mark Crispin
REM
REM Date:	 9 October 1995
REM Last Edited: 30 August 2006

REM Set the default drivers
ECHO #define CREATEPROTO %1proto >> LINKAGE.H
ECHO #define APPENDPROTO %2proto >> LINKAGE.H
