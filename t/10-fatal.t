#
# Checking the checks at build time
#
use v6.c;
use Test;
use Date::Calendar::FrenchRevolutionary;
use Date::Calendar::FrenchRevolutionary::Astronomical;
use Date::Calendar::FrenchRevolutionary::Arithmetic;

my @lives = ((228,  1,  1, "correct")
           , (228,  1, 30, "correct")
           , (228, 12,  1, "correct")
           , (228, 12, 30, "correct")
           , (229, 13,  5, "correct additional day on a normal year")
           , ( 20, 13,  6, "leap day common to arithmetic and astronomical")
           , ( 24, 13,  6, "leap day common to arithmetic and astronomical")
           , (172, 13,  6, "leap day common to arithmetic and astronomical")
           , (272, 13,  6, "leap day common to arithmetic and astronomical")
             );
my @dies  = ((228,  1,  0, "day out of range")
           , (228,  1, 31, "day out of range")
           , (228, 12,  0, "day out of range")
           , (228, 12, 31, "day out of range")
           , (228,  0,  1, "month out of range")
           , (228, 14,  1, "month out of range")
           , (228, 13,  0, "additional day out of range")
           , (228, 13,  7, "additional day out of range on a leap year")
           , (229, 13,  6, "additional day out of range on a normal year")
             );

# Arithmetic dies, historical and astronomical live,
my @dies-arit = ((  3, 13, 6, "first astronomical leap day")
               , (  7, 13, 6, "second astronomical leap day")
               );

# Arithmetic lives, historical and astronomical die
my @lives-arit = ((  4, 13, 6, "first arithmetic leap day")
                , (  8, 13, 6, "second arithmetic leap day")
                );

# Astronomical dies, historic and arithmetic live
my @dies-astr = (( 52, 13, 6, "leap day")
               , (228, 13, 6, "leap day")
               , (268, 13, 6, "leap day")
               );

# Astronomical lives, historic and arithmetic die
my @lives-astr = (( 53, 13, 6, "leap day")
                , (230, 13, 6, "leap day")
                , (267, 13, 6, "leap day")
               );

plan 3 × (@lives.elems + @dies.elems + @dies-arit.elems + @lives-arit.elems + @dies-astr.elems + @lives-astr.elems);

my Date::Calendar::FrenchRevolutionary $d-fr;

for (|@lives, |@dies-arit, |@dies-astr) -> $test {
  my ($y, $m, $d, $text) = $test;
  $text = sprintf("%04d-%02d-%02d historical lives %s", $y, $m, $d, $text);
  lives-ok( {$d-fr .= new(year => $y, month => $m, day => $d) }, $text);
}

for (|@dies, |@lives-arit, |@lives-astr) -> $test {
  my ($y, $m, $d, $text) = $test;
  $text = sprintf("%04d-%02d-%02d historical dies %s", $y, $m, $d, $text);
  dies-ok( {$d-fr .= new(year => $y, month => $m, day => $d) }, $text);
}

my Date::Calendar::FrenchRevolutionary::Astronomical $d-ast;

for (|@lives, |@dies-arit, |@lives-astr) -> $test {
  my ($y, $m, $d, $text) = $test;
  $text = sprintf("%04d-%02d-%02d astronomical lives %s", $y, $m, $d, $text);
  lives-ok( {$d-ast .= new(year => $y, month => $m, day => $d) }, $text);
}

for (|@dies, |@lives-arit, |@dies-astr) -> $test {
  my ($y, $m, $d, $text) = $test;
  $text = sprintf("%04d-%02d-%02d astronomical dies %s", $y, $m, $d, $text);
  dies-ok( {$d-ast .= new(year => $y, month => $m, day => $d) }, $text);
}

my Date::Calendar::FrenchRevolutionary::Arithmetic $d-ari;

for (|@lives, |@lives-arit, |@dies-astr) -> $test {
  my ($y, $m, $d, $text) = $test;
  $text = sprintf("%04d-%02d-%02d arithmetic lives %s", $y, $m, $d, $text);
  lives-ok( {$d-ari .= new(year => $y, month => $m, day => $d) }, $text);
}

for (|@dies, |@dies-arit, |@lives-astr) -> $test {
  my ($y, $m, $d, $text) = $test;
  $text = sprintf("%04d-%02d-%02d arithmetic dies %s", $y, $m, $d, $text);
  dies-ok( {$d-ari .= new(year => $y, month => $m, day => $d) }, $text);
}

done-testing;
