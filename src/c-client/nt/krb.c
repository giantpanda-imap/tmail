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
 * Program:	Heimdal Kerberos routines
 *
 * Author:	Mark Crispin
 *
 * Date:	4 March 2003
 * Last Edited:	8 November 2018
 */

#define PROTOTYPE(x) x
#include <gssapi/gssapi.h>
#include <gssapi/krb5.h>

long kerberos_server_valid(void);
long kerberos_try_kinit(OM_uint32 error);
char *kerberos_login(char *user, char *authuser, int argc, char *argv[]);

/* Kerberos server valid check
 * Returns: T if have keytab, NIL otherwise
 */

long kerberos_server_valid()
{
  return NIL;
}

/* Kerberos check for missing or expired credentials
 * Returns: T if should suggest running kinit, NIL otherwise
 */

long kerberos_try_kinit(OM_uint32 error)
{
  switch (error)
  {
  case KRB5KRB_AP_ERR_TKT_EXPIRED:
  case KRB5_FCC_NOFILE:  /* MIT */
  case KRB5_CC_NOTFOUND: /* Heimdal */
    return LONGT;
  }
  return NIL;
}

/* Kerberos server log in
 * Accepts: authorization ID as user name
 *          authentication ID as Kerberos principal
 *          argument count
 *          argument vector
 * Returns: logged in user name if logged in, NIL otherwise
 */

char *kerberos_login(char *user, char *authuser, int argc, char *argv[])
{
  return NIL;
}
