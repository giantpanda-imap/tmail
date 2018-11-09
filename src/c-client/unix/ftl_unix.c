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
 * Program:	UNIX crash management routines
 *
 * Author:	Mark Crispin
 *
 * Date:	1 August 1988
 * Last Edited:	30 August 2006
 */

/* Report a fatal error
 * Accepts: string to output
 */

void fatal(char *string)
{
    MM_FATAL(string); /* pass up the string */
    syslog(LOG_ALERT, "IMAP toolkit crash: %.100s", string);
    abort(); /* die horribly */
}
