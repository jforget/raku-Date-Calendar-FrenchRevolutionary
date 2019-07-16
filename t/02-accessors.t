use v6.c;
use Test;
use Date::Calendar::FrenchRevolutionary;
use Date::Calendar::FrenchRevolutionary::Astronomical;
use Date::Calendar::FrenchRevolutionary::Arithmetic;

plan 54;

my Date::Calendar::FrenchRevolutionary               $d-hi .= new(year => 9, month => 2, day => 18);
my Date::Calendar::FrenchRevolutionary::Astronomical $d-as .= new(year => 9, month => 2, day => 18);
my Date::Calendar::FrenchRevolutionary::Arithmetic   $d-ar .= new(year => 9, month => 2, day => 18);

for ($d-hi, $d-as, $d-ar) -> $d {
  is($d.month, 2);
  is($d.day,  18);
  is($d.year,  9);
  is($d.month-name, 'Brumaire');
  is($d.month-abbr, 'Bru');
  is($d.locale,     'fr');
  is($d.day-name,   'Octidi');
  is($d.day-abbr,   'Oct');
  is($d.feast,      'dentelaire');

  $d.locale = 'en';

  is($d.day,  18);
  is($d.year,  9);
  is($d.month, 2);
  is($d.locale,     'en');
  is($d.day-name,   'Eightday');
  is($d.day-abbr,   'Eig');
  is($d.month-abbr, 'Fog');
  is($d.month-name, 'Fogarious');
  is($d.feast,      'plumbago');
}

done-testing;
