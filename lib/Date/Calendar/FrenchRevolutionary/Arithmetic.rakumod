use v6.d;

use Date::Calendar::Strftime;
use Date::Calendar::FrenchRevolutionary::Common;

unit class    Date::Calendar::FrenchRevolutionary::Arithmetic:ver<0.1.1>:auth<zef:jforget>:api<1>
         does Date::Calendar::FrenchRevolutionary::Common
         does Date::Calendar::Strftime;

method BUILD(Int:D :$year, Int:D :$month, Int:D :$day, Str :$locale = 'fr', Int :$daypart = daylight()) {
  self!check-build-args($year, $month, $day, $locale, &vnd1);
  self!build-from-args( $year, $month, $day, $locale, $daypart);
}

method vnd1 {
  vnd1($.year + 1791);
}

method new-from-daycount(Int $count where  { $_ ≥ -24161 }, Int :$daypart = daylight()) {
  my ($y, $m, $d) = $.elems-from-daycount($count, &vnd1);
  $.new(year => $y, month => $m, day => $d, daypart => $daypart);
}

our sub vnd1(Int:D $year-gr --> Int) {
  # say $year-gr, ' ', nb_jc6($year-gr), ' ', nb_f29($year-gr);
  457 + nb_jc6($year-gr)
      - nb_f29($year-gr);
}

sub nb_jc6(Int:D $year-gr --> Int) {
  my $year-fr = $year-gr - 1792;
  floor($year-fr / 4) - floor($year-fr / 100) + floor($year-fr / 400) - floor($year-fr / 4000);
}
sub nb_f29(Int:D $year-gr --> Int) {
  floor($year-gr / 4) - floor($year-gr / 100) + floor($year-gr / 400);
}

=begin pod

=head1 NAME

Date::Calendar::FrenchRevolutionary::Arithmetic - Conversions from / to the French Revolutionary calendar

=head1 SYNOPSIS

Converting from a Gregorian date to a French Revolutionary date

=begin code :lang<raku>

use Date::Calendar::FrenchRevolutionary::Arithmetic;
my  Date $Bonaparte's-coup-gr;
my  Date::Calendar::FrenchRevolutionary::Arithmetic
         $Bonaparte's-coup-fr;

$Bonaparte's-coup-gr .= new(1799, 11, 9);
$Bonaparte's-coup-fr .= new-from-date($Bonaparte's-coup-gr);

say $Bonaparte's-coup-fr;
# ---> "0008-02-19" for 19 Brumaire VIII
#     (the arithmetic variant differs from the historical variant in year VIII)
say "{.day-name} {.day} {.month-name} {.year} {.feast-long}" with  $Bonaparte's-coup-fr;
# ---> "Nonidi 19 Brumaire 8 jour de la grenade"

=end code

Converting from a French Revolutionary date to a Gregorian date

=begin code :lang<raku>

use Date::Calendar::FrenchRevolutionary::Arithmetic;
my  Date::Calendar::FrenchRevolutionary::Arithmetic
         $Robespierre's-downfall-frv;
my  Date $Robespierre's-downfall-grg;

$Robespierre's-downfall-frv .= new(year =>  2, month => 11, day =>  9);
$Robespierre's-downfall-grg  = $Robespierre's-downfall-frv.to-date;
say $Robespierre's-downfall-grg;
# --> 1794-07-27

=end code


=head1 DESCRIPTION

Date::Calendar::FrenchRevolutionary::Arithmetic     is     a     class
representing dates in the French Revolutionary calendar. It allows you
to convert  a Gregorian date into  a French Revolutionary date  or the
other  way. This  class uses  the  arithmetic rule  for computing  the
successive year lengths since the beginning of the calendar.

The Revolutionary calendar was in use  in France from 24 November 1793
(4 Frimaire  II) to 31 December  1805 (10 Nivôse XIV).  The modules in
this distribution  extend the  calendar to  the present  and to  a few
centuries in the future, not limiting to Gregorian year 1805.

This new calendar was an attempt  to apply the decimal rule (the basis
of  the   metric  system)  to   the  calendar.  Therefore,   the  week
disappeared, replaced by the décade, a 10-day period. In addition, all
months have exactly 3 decades, no more, no less.

Since 12 months of 30 days each do not make a full year (365.24 days),
there are 5 or 6 additional days at  the end of a year. These days are
called  "Sans-culottides", named  after  a political  faction, but  we
often find the phrase "jours complémentaires" (additional days). These
days do not  belong to any month, but for  programming purposes, it is
convenient to consider they form a 13th month.

At first,  the year was  beginning on the  equinox of autumn,  for two
reasons.  First, the  republic had  been established  on 22  September
1792, which happened to be the  equinox, and second, the equinox was a
symbol for  equality, the day and  the night lasting exactly  12 hours
each. It  was therefore  in tune with  the republic's  motto "Liberty,
Equality, Fraternity". But  it was not practical, so  Romme proposed a
leap year  rule similar  to the Gregorian  calendar rule.  This module
assumes that  Romme's arithmetic  rule was in  effect since  the first
year of the calendar.

The  distribution contains  two other  classes, one  where the  reform
replacing the astronomical rule by  the arithmetic rule took effect in
year XX  (1811), the other  where there was  no reform and  the autumn
equinox rule stayed in effect even after year XX.

=head1 USAGE

See the documentation for the main class, C<Date::Calendar::FrenchRevolutionary>.

=head1 AUTHOR

Jean Forget <J2N-FORGET at orange dot fr>

=head1 COPYRIGHT AND LICENSE

Copyright (c) 2019, 2020, 2024, 2025 Jean Forget, all rights reserved

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod
