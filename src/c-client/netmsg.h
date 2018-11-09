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
 * Program:	Network message (SMTP/NNTP/POP2/POP3) routines
 *
 * Author:	Mark Crispin
 *
 * Date:	8 June 1995
 * Last Edited:	30 August 2006
 */

/* stream must be void* for use as readfn_t */
long netmsg_read(void *stream, unsigned long count, char *buffer);
FILE *netmsg_slurp(NETSTREAM *stream, unsigned long *size, unsigned long *hsiz);
