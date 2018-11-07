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
 * Program:	SVR4 Signals
 *
 * Author:	Mark Crispin
 *
 * Date:	29 April 1997
 * Last Edited:	30 August 2006
 */
 
#include <signal.h>

/* Arm a signal
 * Accepts: signal number
 *	    desired action
 * Returns: old action
 */

void *arm_signal (int sig,void *action)
{
  return (void *) sigset (sig,action);
}
