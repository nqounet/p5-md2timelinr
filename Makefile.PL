use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
  VERSION   => '0.01',
  PREREQ_PM => {
    'ExtUtils::MakeMaker' => '6.63',
    'Mojolicious' => '3.55',
    'Path::Class' => '0.26',
    'Text::Markdown' => '1.000031',
  },
  test      => {TESTS => 't/*.t'}
);
