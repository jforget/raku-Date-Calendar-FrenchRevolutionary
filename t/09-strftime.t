#
# Checking the formatting from strftime
#
# Work in progress
#
use v6.c;
use Test;
use Date::Calendar::FrenchRevolutionary;

my @tests = ((227,  1,  11, 'zzz',      11, 'placeholder')
           , (227,  1,  13, '%Y-%m-%d', 11, 'placeholder')
             );
plan 2 × @tests.elems;

for @tests -> $test {
  my ($y, $m, $d, $format, $length, $expected) = $test;
  my Date::Calendar::FrenchRevolutionary $d-fr .= new(year => $y, month => $m, day => $d);
  my $result = $d-fr.strftime($format);

  # Remembering RT ticket 100311 for the Perl 5 module DateTime::Calendar::FrenchRevolutionary
  # Even if the relations between UTF-8 and Perl6 are much simpler than between UTF-8 and Perl5
  # better safe than sorry
  is($result.chars, $length);
  is($result,       $expected);
}

done-testing;
