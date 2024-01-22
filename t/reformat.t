# Test the re-formatting of d2s() provided by fmtpy();
use strict;
use warnings;
use Math::Ryu qw(:all);

use Test::More;

my $mpfr = 0;
eval {require Math::MPFR;};

$mpfr = 1 unless $@;

if($mpfr) {
  $mpfr = 0 unless Math::MPFR::_MPFR_VERSION() >  196869;
  $mpfr = 0 if $Math::MPFR::VERSION < 4.12;
}

my $pinf = 2 ** 1500;
my $ninf = -$pinf;
my $nan = $pinf / $pinf;

cmp_ok($nan, '!=', $nan, "NaN != NaN");
cmp_ok($pinf + $ninf, '!=', $pinf + $ninf, "Inf - Inf != Inf - Inf");

#cmp_ok(fmtjs(d2s($pinf)), 'eq', 'Infinity', "js: infinity ok");
cmp_ok(fmtpy(d2s($pinf)), 'eq', 'inf', "py: infinity ok");

if($mpfr) {
  cmp_ok(fmtpy(d2s($pinf)), 'eq', lc(Math::MPFR::nvtoa($pinf)), "Math::MPFR test 1: ok"); # case-insensitive comparison required
}

#cmp_ok(fmtjs(d2s($ninf)), 'eq', '-Infinity', "js: -infinity ok");
cmp_ok(fmtpy(d2s($ninf)), 'eq', '-inf', "py: -infinity ok");

if($mpfr) {
  cmp_ok(fmtpy(d2s($ninf)), 'eq', lc(Math::MPFR::nvtoa($ninf)), "Math::MPFR test 2: ok"); # case-insensitive comparison required
}

#cmp_ok(fmtjs(d2s($nan)), 'eq', 'NaN', "js: nan ok");
cmp_ok(fmtpy(d2s($nan)), 'eq', 'nan', "py: nan ok");

if($mpfr) {
  cmp_ok(fmtpy(d2s($nan)), 'eq', lc(Math::MPFR::nvtoa($nan)), "Math::MPFR test 3: ok"); # case-insensitive comparison required
}

#cmp_ok(fmtjs('0E0'), 'eq', '0', "js: 0E0 ok");
#cmp_ok(fmtjs('-0E0'), 'eq', '0', "js: -0E0 ok");
cmp_ok(fmtpy('0E0'), 'eq', '0.0', "py: 0E0 ok");
cmp_ok(fmtpy('-0E0'), 'eq', '-0.0', "py: -0E0 ok");

if($mpfr) {
  cmp_ok(fmtpy('0E0'), 'eq', Math::MPFR::nvtoa(0.0), "Math::MPFR test 4: ok");
  cmp_ok(fmtpy('-0E0'), 'eq', Math::MPFR::nvtoa(-0.0), "Math::MPFR test 5: ok");
}

my $s = '12345.8';
cmp_ok(fmtpy($s), 'eq', $s, "py: $s ok");

if($mpfr) {
  cmp_ok(fmtpy($s), 'eq', Math::MPFR::nvtoa($s), "Math::MPFR test 6: ok");
}

cmp_ok(fmtpy(d2s(11.00071e-10)), 'eq', '1.100071e-09', 'py: 11.00071e-10 ok');

if($mpfr) {
  cmp_ok(fmtpy(d2s(11.00071e-10)), 'eq', Math::MPFR::nvtoa(d2s(11.00071e-10)), "Math::MPFR test 7: ok");
}

cmp_ok(fmtpy(d2s(-11.00071e-10)), 'eq', '-1.100071e-09', 'py: -11.00071e-10 ok');

if($mpfr) {
  cmp_ok(fmtpy(d2s(-11.00071e-10)), 'eq', Math::MPFR::nvtoa(d2s(-11.00071e-10)), "Math::MPFR test 8: ok");
}

cmp_ok(fmtpy(d2s(1e-10)), 'eq', '1e-10', 'py: 1e-10 ok');

if($mpfr) {
  cmp_ok(fmtpy(d2s(1e-10)), 'eq', Math::MPFR::nvtoa(d2s(1e-10)), "Math::MPFR test 9: ok");
}

cmp_ok(fmtpy(d2s(-1e-10)), 'eq', '-1e-10', 'py: -1e-10 ok');

if($mpfr) {
  cmp_ok(fmtpy(d2s(-1e-10)), 'eq', Math::MPFR::nvtoa(d2s(-1e-10)), "Math::MPFR test 10: ok");
}

cmp_ok(fmtpy(d2s(1234567.89)), 'eq', '1234567.89', 'py: 1234567.89 ok');

if($mpfr) {
  cmp_ok(fmtpy(d2s(1234567.89)), 'eq', '1234567.89', "Math::MPFR test 11: ok");
}

cmp_ok(fmtpy(d2s(1.1234567890123456e25)), 'eq', '1.1234567890123457e+25', 'js: 1.1234567890123456e25 ok');

if($mpfr) {
  cmp_ok(fmtpy(d2s(1.1234567890123456e25)), 'eq', '1.1234567890123457e+25', "Math::MPFR test 12: ok");
}

cmp_ok(fmtpy(d2s(9e125)), 'eq', '9e+125', 'js: 9e125 ok');

if($mpfr) {
  cmp_ok(fmtpy(d2s(9e125)), 'eq', '9e+125', "Math::MPFR test 13: ok");
}

cmp_ok(fmtpy(d2s(9.123e125)), 'eq', '9.123e+125', 'js: 9.123e125 ok');

if($mpfr) {
  cmp_ok(fmtpy(d2s(9.123e125)), 'eq', '9.123e+125', "Math::MPFR test 14: ok");
}

cmp_ok(fmtpy(d2s(91144e125)), 'eq', '9.1144e+129', 'js: 91144e125 ok');

if($mpfr) {
  cmp_ok(fmtpy(d2s(91144e125)), 'eq', '9.1144e+129', "Math::MPFR test 15: ok");
}

cmp_ok(fmtpy(d2s(1e23)), 'eq', '1e+23', 'js: 9e125 ok');

if($mpfr) {
  cmp_ok(fmtpy(d2s(1e23)), 'eq', '1e+23', "Math::MPFR test 16: ok");
}

for(0.1, 0.12, 0.123) {
  cmp_ok(fmtpy(d2s($_)), 'eq', $_, "js: $_ renders as expected");
}

if($mpfr) {
  for my $iteration (1..10) {
    my $sign = $iteration & 1 ? '-' : '';
    for my $exp(0..50) {
      $exp *= -1 if $iteration & 1;
      my $rand =  $sign . rand() . "e$exp";
      my $num = $rand + 0;
      cmp_ok(fmtpy(d2s($num)), 'eq', Math::MPFR::nvtoa($num), "fmtpy() format agrees with nvtoa(): " . sprintf("%.17g", $num));
    }
  }

  for my $num(0.1, 0.12, 0.123, 0.1234, 0.12345, 0.123456, 0.1234567, 0.12345678, 0.123456789, 0.1234567890, 0.12345678901, 0.123456789012,
             0.1234567890123, 0.12345678901234, 0.123456789012345, 0.1234567890123456, 0.12345678901234567, 0.123456789012345678,
             0.1234567890123456789, 0.12345678901234567894) {
    cmp_ok(fmtpy(d2s($num)), 'eq', Math::MPFR::nvtoa($num), "fmtpy() format agrees with nvtoa(): " . sprintf("%.17g", $num));
  }

}

done_testing();

__END__

