#
# Checking the getters (and also the C<locale> setter)
#
use v6.c;
use Test;
use Date::Calendar::FrenchRevolutionary;
use Date::Calendar::FrenchRevolutionary::Astronomical;
use Date::Calendar::FrenchRevolutionary::Arithmetic;

plan  3  # classes
   ×  2  # languages
   × 15  # accessors
   +  1; # special case

#
# Actually, this is not Bonaparte's coup in year VIII, but its anniversary one year later in year IX! Ooops!
#
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
  is($d.feast-long   , 'jour de la dentelaire');
  is($d.feast-caps   , 'Jour de la Dentelaire');
  is($d.day-of-year  , 48);
  is($d.day-of-décade,  8);
  is($d.décade-number,  5);
  is($d.daycount,  -21192);

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
  is($d.feast-long   , 'day of plumbago');
  is($d.feast-caps   , 'Day of Plumbago');
  is($d.day-of-year  , 48);
  is($d.day-of-décade,  8);
  is($d.décade-number,  5);
  is($d.daycount,  -21192);
}

$d-hi .= new(year => 228, month => 6, day => 10);
is($d-hi.day-of-décade, 10);

done-testing;
