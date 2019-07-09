use v6.c;
use Test;
use Date::Calendar::FrenchRevolutionary;
use Date::Calendar::FrenchRevolutionary::Astronomical;
use Date::Calendar::FrenchRevolutionary::Arithmetic;

plan 24;

my Date::Calendar::FrenchRevolutionary               $d-hi .= new(year => 9, month => 2, day => 18);
my Date::Calendar::FrenchRevolutionary::Astronomical $d-as .= new(year => 9, month => 2, day => 18);
my Date::Calendar::FrenchRevolutionary::Arithmetic   $d-ar .= new(year => 9, month => 2, day => 18);

for ($d-hi, $d-as, $d-ar) -> $d {
  is($d.month, 2);
  is($d.day,  18);
  is($d.year,  9);
  is($d.locale,     'fr');

  $d.locale = 'en';

  is($d.day,  18);
  is($d.year,  9);
  is($d.month, 2);
  is($d.locale,     'en');
}

done-testing;
