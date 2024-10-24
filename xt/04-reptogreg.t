#
# Checking the conversion from the historical variant of French Revolutionary to Gregorian
#
use v6.c;
use Test;
use Date::Calendar::FrenchRevolutionary;

my @tests = (("1792-09-22",    1,  1,  1),
             ("1793-10-23",    2,  2,  2),
             ("1794-07-27",    2, 11,  9), # the demise of Robespierre
             ("1794-11-23",    3,  3,  3),
             ("1795-10-05",    4,  1, 13), # Saint-Roch church demonstration
             ("1795-12-25",    4,  4,  4),
             ("1797-01-24",    5,  5,  5),
             ("1798-02-24",    6,  6,  6),
             ("1799-11-09",    8,  2, 18), # Bonaparte's coup
             ("1801-03-29",    9,  7,  8),
             ("1804-04-30",   12,  8, 10),
             ("1807-06-01",   15,  9, 12),
             ("1810-07-03",   18, 10, 14),
             ("1813-08-04",   21, 11, 16),
             ("1816-09-04",   24, 12, 18),
             ("2000-01-01",  208,  4, 12), # Y2K compatible? Will your computer freeze or what?
             ("2001-05-11",  209,  8, 22), # So long, Douglas, and thanks for all the fun
             ("2791-09-23", 1000,  1,  1),
             ("2792-09-22", 1001,  1,  1),
             ("3791-09-22", 2000,  1,  1),
             ("3792-09-22", 2001,  1,  1),
             ("4791-09-23", 3000,  1,  1),
             ("4792-09-22", 3001,  1,  1),
             ("5791-09-22", 4000,  1,  1),
             ("5792-09-21", 4001,  1,  1),
             ("6791-09-22", 5000,  1,  1),
             ("6792-09-21", 5001,  1,  1),
             ("7791-09-21", 6000,  1,  1),
             ("7792-09-21", 6001,  1,  1),
             );
plan @tests.elems;

for @tests -> $test {
  my ($str, $y, $m, $d) = $test;
  my Date::Calendar::FrenchRevolutionary $d-fr .= new(year => $y, month => $m, day => $d);
  is($d-fr.to-date.gist, $str);
}

done-testing;
