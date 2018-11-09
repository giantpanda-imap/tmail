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
 * Program:	SVR4-style Time Zone String
 *
 * Author:	Mark Crispin
 *
 * Date:	30 August 1994
 * Last Edited:	30 August 2006
 */


/* Append local timezone name
 * Accepts: destination string
 */

void rfc822_timezone (char *s,void *t)
{
  tzset ();			/* get timezone from TZ environment stuff */
  sprintf (s + strlen (s)," (%.50s)",
	   tzname[daylight ? (((struct tm *) t)->tm_isdst > 0) : 0]);
}
