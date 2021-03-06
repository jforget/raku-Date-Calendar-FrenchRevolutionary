#
# Checking the checks at build time
#
use v6.c;
use Test;
use Date::Calendar::FrenchRevolutionary;
use Date::Calendar::FrenchRevolutionary::Astronomical;
use Date::Calendar::FrenchRevolutionary::Arithmetic;


plan 5;

my Date::Calendar::FrenchRevolutionary $d-fr;

lives-ok( {$d-fr .= new(year => 228, month => 6, day => 15) }, "Creation with default locale");
lives-ok( { $d-fr.locale = 'en' }, "Update of locale with a proper value");
dies-ok(  { $d-fr.locale = 'xx' }, "Update of locale with a wrong value");
lives-ok( {$d-fr .= new(year => 228, month => 6, day => 15, locale => 'en') }, "Creation with explicit locale with a proper value");
dies-ok(  {$d-fr .= new(year => 228, month => 6, day => 15, locale => 'xx') }, "Creation with explicit locale with wrong value");



done-testing;
