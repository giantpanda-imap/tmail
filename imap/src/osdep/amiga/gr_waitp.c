/* ========================================================================
 * Copyright 1988-2006 University of Washington
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * ========================================================================
 */

/*
 * Program:	UNIX Grim PID Reaper -- waitpid() version
 *
 * Author:	Mark Crispin
 *
 * Date:	30 November 1993
 * Last Edited:	30 August 2006
 */

/* Grim PID reaper
 * Accepts: process ID
 *	    kill request flag
 *	    status return value
 */

void grim_pid_reap_status (int pid,int killreq,void *status)
{
  if (killreq) kill(pid,SIGHUP);/* kill if not already dead */
  while ((waitpid (pid,status,NIL) < 0) && (errno != ECHILD));
}
