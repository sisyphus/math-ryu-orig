#ifdef  __MINGW32__
#ifndef __USE_MINGW_ANSI_STDIO
#define __USE_MINGW_ANSI_STDIO 1
#endif
#endif

#define PERL_NO_GET_CONTEXT 1

#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#define __STDC_WANT_DEC_FP__ 1
#include <ryu.h>
#include <generic_128.h>    /* modified to include stdbool.h */
#include <ryu_generic_128.h>
#include <stdbool.h>
#include <quadmath.h>

#include "math_ryu_l_include.h"

typedef struct floating_decimal_128 t_fd128;

SV * ld2s(pTHX_ SV * nv) {
  char * buff;
  SV * outsv;

  Newxz(buff, LD_BUF, char); /* LD_BUF defined in math_ryu_l)include.h, along with D_BUF and F128_BUF */

  if(buff == NULL) croak("Failed to allocate memory for string buffer in ld2s sub");
  generic_to_chars(long_double_to_fd128(SvNV(nv)), buff);
  outsv = newSVpv(buff, 0);
  Safefree(buff);
  return outsv;
}

int _SvIOK(SV * sv) {
    if(SvIOK(sv)) return 1;
    return 0;
}

int _SvNOK(SV * sv) {
    if(SvNOK(sv)) return 1;
    return 0;
}

int _SvPOK(SV * sv) {
    if(SvPOK(sv)) return 1;
    return 0;
}

int _SvIOKp(SV * sv) {
    if(SvIOKp(sv)) return 1;
    return 0;
}


MODULE = Math::Ryu::L  PACKAGE = Math::Ryu::L

PROTOTYPES: DISABLE

SV *
ld2s (nv)
	SV *	nv
CODE:
  RETVAL = ld2s (aTHX_ nv);
OUTPUT:  RETVAL

int
_SvIOK (sv)
	SV *	sv

int
_SvNOK (sv)
	SV *	sv

int
_SvPOK (sv)
	SV *	sv

int
_SvIOKp (sv)
	SV *	sv

