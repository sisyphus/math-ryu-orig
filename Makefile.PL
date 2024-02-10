use strict;
use warnings;
use ExtUtils::MakeMaker;

if($Config::Config{nvsize} == 8) {
  print "  Math::Ryu::L is not usable with this build of perl.\n",
        "  Install Math::Ryu instead\n";
  exit 0;
}

if($Config::Config{nvtype} eq '__float128') {
  print "  Neither Math::Ryu nor Math::Ryu::L is usable with this build of perl.\n";
  exit 0;
}

my $defines = '';

my %options = (

  NAME => 'Math::Ryu::L',
  PREREQ_PM    => { 'Test::More' => '0.88', },
  DEFINE       => $defines,
  LICENSE      => 'perl',
  INC          => '-IC:\cygwin64\home\Owner\git\ryu-ld\ryu',
  VERSION_FROM => 'L.pm',
  clean        => { FILES => '*.exe' },

  LIBS => [ -lryu ],
#  OBJECT       => '$(O_FILES)',
  META_MERGE   => {
    'meta-spec'  => { version => 2 },
    resources    => {
      repository   => {
        type         => 'git',
        url          => 'https://github.com/sisyphus/math-ryu-l.git',
        web          => 'https://github.com/sisyphus/math-ryu-l',
      },
    },
  },
);
WriteMakefile(%options);

# Remove the Makefile dependency. Causes problems on a few systems.
sub MY::makefile { '' }
