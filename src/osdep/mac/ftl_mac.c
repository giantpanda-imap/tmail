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
 * Program:	Mac crash management routines
 *
 * Author:	Mark Crispin
 *
 * Date:	26 January 1992
 * Last Edited:	30 August 2006
 */

/* Report a fatal error
 * Accepts: string to output
 */

void fatal (char *string)
{
  mm_fatal (string);		/* pass up the string */
				/* nuke the resolver */
  if (resolveropen) CloseResolver ();
  abort ();			/* die horribly */
}
