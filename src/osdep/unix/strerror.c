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
 * Program:	Error number to string
 *
 * Author:	Mark Crispin
 *
 * Date:	1 August 1988
 * Last Edited:	30 August 2006
 */

/* Return implementation-defined string corresponding to error
 * Accepts: error number
 * Returns: string for that error
 */

char *strerror (int n)
{
  return (n >= 0 && n < sys_nerr) ? sys_errlist[n] : NIL;
}
