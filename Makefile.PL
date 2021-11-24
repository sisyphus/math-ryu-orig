use strict;
use warnings;
use ExtUtils::MakeMaker;

if($Config::Config{nvsize} > 8) {
  print "  Math::Ryu is currently not usable with this build of perl,\n",
        "  because \$Config{nvsize} ($Config::Config{nvsize}) is greater than 8\n";

  exit 0;
}
my %options = (

  NAME => 'Math::Ryu',
  LIBS => ['-lryu'],
  PREREQ_PM    => { 'Test::More' => '0.88', },
  LICENSE      => 'perl',
  VERSION_FROM => 'Ryu.pm',
  META_MERGE   => {
    'meta-spec'  => { version => 2 },
    resources    => {
      repository   => {
        type         => 'git',
        url          => 'https://github.com/sisyphus/math-ryu.git',
        web          => 'https://github.com/sisyphus/math-ryu',
      },
    },
  },
);
WriteMakefile(%options);

# Remove the Makefile dependency. Causes problems on a few systems.
sub MY::makefile { '' }
