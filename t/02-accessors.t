use v6.c;
use Test;
use Date::Calendar::FrenchRevolutionary;

plan 8;

my Date::Calendar::FrenchRevolutionary $d .= new(year => 9, month => 2, day => 18);

is($d.month, 2);
is($d.day,  18);
is($d.year,  9);
is($d.locale,     'fr');

$d.locale = 'en';

is($d.day,  18);
is($d.year,  9);
is($d.month, 2);
is($d.locale,     'en');

done-testing;
