use strict;
use warnings;
use Math::Ryu::L qw(:all);

use Test::More;

cmp_ok($Math::Ryu::L::VERSION, 'eq', '0.01', "\$Math::Ryu::L::VERSION is as expected");

my $s = fmtpy(ld2s(sqrt 2));

cmp_ok($s, 'eq', '1.4142135623730950488', "fmtpy(ld2s(sqrt(2))) is as expected");

done_testing();
