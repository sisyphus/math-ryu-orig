use strict;
use warnings;
use Math::Ryu::L qw(:all);

use Test::More;

cmp_ok(fmtpy(ld2s(2 ** -16446)), '==', 0, "2 ** -16446 is zero");
cmp_ok(fmtpy(ld2s(2 ** -16445)), 'eq', '4e-4951', "2** -16445 is 4e-4951");
cmp_ok(fmtpy(ld2s(2 ** -16444)), 'eq', '7e-4951', "2** -16444 is 7e-4951");
cmp_ok(fmtpy(ld2s(2 ** -16443)), 'eq', '1.5e-4950', "2** -16443 is 1.5e-4950");
cmp_ok(fmtpy(ld2s(2 ** -16442)), 'eq', '3e-4950', "2** -16442 is 3e-4950");
cmp_ok(fmtpy(ld2s(2 ** -16441)), 'eq', '6e-4950', "2** -16441 is 6e-4950");
cmp_ok(fmtpy(ld2s(2 ** -16436)), 'eq', '1.866e-4948', "2** -16436 is 1.866e-4948");
cmp_ok(fmtpy(ld2s(2 ** -16436 + 2 ** -16445)), 'eq', '1.87e-4948', "2** -16436 + 2 ** -16445 is 1.87e-4948");

my $have_mpfr = 0;
eval{require Math::MPFR;};
if($@) {
  warn "Skipping remaining tests - Math::MPFR has failed to load\n";
  done_testing();
  exit 0;
}

if($Math::MPFR::VERSION < 4.14) {
  warn "Skipping remaining tests - Math::MPFR needs to be at least 4.14\n";
  done_testing();
  exit 0;
}

if(Math::MPFR::MPFR_VERSION_MAJOR() < 3 || (Math::MPFR::MPFR_VERSION_MAJOR() == 3  && Math::MPFR::MPFR_VERSION_PATCHLEVEL() < 6)) {
  warn "Skipping remaining tests - Math::MPFR needs to have been built against mpfr-3.1.6 or later\n";
  done_testing();
  exit 0;
}

for(1190 .. 1205, 590 .. 605,  90 .. 105, 0 .. 40) {
   my $mant = rand();
   my $exp = $_;
   $exp *= -1 if $_ % 3;
   my $n = $mant . 'e' . $exp;
   cmp_ok(fmtpy(ld2s($n)), 'eq', Math::MPFR::nvtoa($n), "$n renders ok");
}

done_testing();
