#
# Checking the formatting of the feasts
#
use v6.c;
use Test;
use Date::Calendar::FrenchRevolutionary;

my @tests = ((227,  1,  11, 'pomme de terre', 14, "jour de la pomme de terre", "Jour de la Pomme de terre", "potato"       , "Day of Potato")
           , (227,  1,  13, 'potiron'       ,  7, "jour du potiron"          , "Jour du Potiron"          , "squash"       , "Day of Squash")
           , (227,  1,  25, 'bœuf'          ,  4, "jour du bœuf"             , "Jour du Bœuf"             , "ox"           , "Day of Ox")
           , (227,  2,  16, 'chervis'       ,  7, "jour du chervis"          , "Jour du Chervis"          , "skirret"      , "Day of Skirret"      )
           , (227,  5,  14, 'avelinier'     ,  9, "jour de l'avelinier"      , "Jour de l'Avelinier"      , "common hazel" , "Day of Common hazel" )
           , (227,  7,  14, 'hêtre'         ,  5, "jour du hêtre"            , "Jour du Hêtre"            , "beech tree"   , "Day of Beech tree"   )
           , (227,  9,  16, 'œillet'        ,  6, "jour de l'œillet"         , "Jour de l'Œillet"         , "carnation"    , "Day of Carnation"    )
           , (227, 12,  26, 'bigarade'      ,  8, "jour de la bigarade"      , "Jour de la Bigarade"      , "bitter orange", "Day of Bitter orange")
           , (227, 13,   5, 'récompenses'   , 11, "jour des récompenses"     , "Jour des Récompenses"     , "rewards"      , "Day of Rewards"      )
             );
plan 6 × @tests.elems;

for @tests -> $test {
  my ($y, $m, $d, $short, $length, $long, $caps, $short-en, $caps-en) = $test;
  my Date::Calendar::FrenchRevolutionary $d-fr .= new(year => $y, month => $m, day => $d);
  my $feast-short = $d-fr.feast;
  is($feast-short, $short);

  # Remembering RT ticket 100311 for the Perl 5 module DateTime::Calendar::FrenchRevolutionary
  # Even if the relations between UTF-8 and Perl6 are much simpler than between UTF-8 and Perl5
  # better safe than sorry
  is($feast-short.chars, $length);

  is($d-fr.feast-long,   $long);
  is($d-fr.feast-caps,   $caps);

  $d-fr.locale = 'en';
  is($d-fr.feast,        $short-en);
  is($d-fr.feast-caps,   $caps-en);
}

done-testing;
