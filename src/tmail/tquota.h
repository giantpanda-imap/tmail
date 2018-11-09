/* ========================================================================
 * Copyright 1988-2007 University of Washington
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
 * Program:	Mail Delivery Module Quota Hook
 *
 * Author:	Mark Crispin
 *
 * Date:	10 September 2007
 * Last Edited:	10 September 2007
 */

/* Function prototypes */

long tmail_quota(STRING *msg, char *path, uid_t uid, char *tmp, char *sender,
                 long precedence);
