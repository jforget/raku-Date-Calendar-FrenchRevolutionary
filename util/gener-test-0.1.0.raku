#!/usr/bin/env raku
# -*- encoding: utf-8; indent-tabs-mode: nil -*-
#
# Générer les données de test pour 12-conv-old.rakutest et 13-conv-new.rakutest
# Generate test data for 12-conv-old.rakutest and 13-conv-new.rakutest
#

use v6.d;
use Date::Calendar::Strftime:ver<0.1.0>;
use Date::Calendar::Aztec;
use Date::Calendar::Aztec::Cortes;
use Date::Calendar::Bahai;
use Date::Calendar::Bahai::Astronomical;
use Date::Calendar::Coptic;
use Date::Calendar::Ethiopic;
use Date::Calendar::Hebrew;
use Date::Calendar::Hijri;
use Date::Calendar::Gregorian;
use Date::Calendar::FrenchRevolutionary;
use Date::Calendar::FrenchRevolutionary::Arithmetic;
use Date::Calendar::FrenchRevolutionary::Astronomical;
use Date::Calendar::Julian;
use Date::Calendar::Julian::AUC;
use Date::Calendar::Maya;
use Date::Calendar::Maya::Astronomical;
use Date::Calendar::Maya::Spinden;
use Date::Calendar::Persian;
use Date::Calendar::Persian::Astronomical;

my %class =   a0 => 'Date::Calendar::Aztec'
            , a1 => 'Date::Calendar::Aztec::Cortes'
            , ba => 'Date::Calendar::Bahai'
            , be => 'Date::Calendar::Bahai::Astronomical'
            , gr => 'Date::Calendar::Gregorian'
            , co => 'Date::Calendar::Coptic'
            , et => 'Date::Calendar::Ethiopic'
            , fr => 'Date::Calendar::FrenchRevolutionary'
            , fa => 'Date::Calendar::FrenchRevolutionary::Arithmetic'
            , fe => 'Date::Calendar::FrenchRevolutionary::Astronomical'
            , he => 'Date::Calendar::Hebrew'
            , hi => 'Date::Calendar::Hijri'
            , jl => 'Date::Calendar::Julian'
            , jc => 'Date::Calendar::Julian::AUC'
            , m0 => 'Date::Calendar::Maya'
            , m1 => 'Date::Calendar::Maya::Astronomical'
            , m2 => 'Date::Calendar::Maya::Spinden'
            , pe => 'Date::Calendar::Persian'
            , pa => 'Date::Calendar::Persian::Astronomical'
            ;

gener-old-sunset(  'ba', 229,  8,  3);
gener-old-sunset(  'be', 232, 12, 21);
gener-old-sunset(  'co', 231,  6, 13);
gener-old-sunset(  'et', 230,  1, 15);
gener-old-midnight('fr', 232,  3, 28);
gener-old-midnight('fa', 230,  7,  7);
gener-old-midnight('fe', 231,  4,  5);
gener-old-midnight('gr', 229, 10, 24);
gener-old-sunset(  'he', 231, 12, 11);
gener-old-sunset(  'hi', 229,  7, 25);
gener-old-midnight('jl', 233,  6,  4);
gener-old-midnight('jc', 232,  7, 18);
gener-old-midnight('pe', 230, 10, 19);
gener-old-midnight('pa', 229, 11, 14);
say '-' x 50;
gener-old-maya(    'm0', 233,  2, 23);
gener-old-maya(    'm1', 230,  7, 14);
gener-old-maya(    'm2', 233,  3,  4);
gener-old-maya(    'a0', 232, 12, 25);
gener-old-maya(    'a1', 231,  5,  4);
say '-' x 50;
gener-new-sunset(  'ba', 229,  8,  3);
gener-new-sunset(  'be', 232, 12, 21);
gener-new-sunset(  'co', 231,  6, 13);
gener-new-sunset(  'et', 230,  1, 15);
gener-new-midnight('fr', 232,  3, 28);
gener-new-midnight('fa', 230,  7,  7);
gener-new-midnight('fe', 231,  4,  5);
gener-new-midnight('gr', 229, 10, 24);
gener-new-sunset(  'he', 231, 12, 11);
gener-new-sunset(  'hi', 229,  7, 25);
gener-new-midnight('jl', 233,  6,  4);
gener-new-midnight('jc', 232,  7, 18);
gener-new-midnight('pe', 230, 10, 19);
gener-new-midnight('pa', 229, 11, 14);
say '-' x 50;
gener-new-maya(    'm0', 233,  2, 23);
gener-new-maya(    'm1', 230,  7, 14);
gener-new-maya(    'm2', 233,  3,  4);
gener-new-maya(    'a0', 232, 12, 25);
gener-new-maya(    'a1', 231,  5,  4);

sub gener-old-sunset($key, $year, $month, $day) {
  gener-old($key, $year, $month, $day);
}

sub gener-old-midnight($key, $year, $month, $day) {
  gener-old($key, $year, $month, $day);
}

sub gener-old($key, $year, $month, $day) {
  my Date::Calendar::FrenchRevolutionary $df1 .= new(year => $year, month => $month, day => $day);
  my     $d1  = $df1.to-date(%class{$key});
  my Str $s1  = $d1 .strftime('"%A %d %b %Y"');
  my Str $sf1 = $df1.strftime('"%a %d %b %Y ☼"');
  my Str $gr1 = $df1.to-date.gist;
  my Int $lg-s1 = 30;
  my Int $lg-sf = 19;
  if $s1 .chars < $lg-s1 { $s1  ~= ' ' x ($lg-s1 - $s1 .chars); }
  if $sf1.chars < $lg-sf { $sf1 ~= ' ' x ($lg-sf - $sf1.chars); }
  my Str $day-x   = sprintf("%2d", $day);
  my Str $month-x = sprintf("%2d", $month);
  print qq:to<EOF>
       , ($year, $month-x, $day-x, before-sunrise, '$key', $s1, $sf1, "$gr1 shift to daylight")
       , ($year, $month-x, $day-x, daylight,       '$key', $s1, $sf1, "$gr1 no problem")
       , ($year, $month-x, $day-x, after-sunset,   '$key', $s1, $sf1, "$gr1 shift to daylight")
  EOF
}


sub gener-new-sunset($key, $year, $month, $day) {
  gener-new(0, $key, $year, $month, $day);
}

sub gener-new-midnight($key, $year, $month, $day) {
  gener-new(1, $key, $year, $month, $day);
}

sub gener-new($midnight, $key, $year, $month, $day) {
  my Date::Calendar::FrenchRevolutionary $df1 .= new(year => $year, month => $month, day => $day);
  my Date::Calendar::FrenchRevolutionary $df2 .= new-from-daycount($df1.daycount + 1);
  my     $d1  = $df1.to-date(%class{$key});
  my     $d2  = $df2.to-date(%class{$key});
  my Str $s1  = $d1 .strftime("%A %d %b %Y");
  my Str $s2  = $d2 .strftime("%A %d %b %Y");
  my Str $sf1 = $df1.strftime("%a %d %b %Y");
  my Str $sf2 = $df2.strftime("%a %d %b %Y");
  my Str $gr1 = $df1.to-date.gist;
  my Str $gr2 = $df2.to-date.gist;
  my Str $day-x   = sprintf("%2d", $day);
  my Str $month-x = sprintf("%2d", $month);
  my Int $lg = 26;
  my Str $w1 = ''; if $s1.chars < $lg { $w1 = ' ' x ($lg - $s1.chars); }
  my Str $w2 = ''; if $s1.chars < $lg { $w2 = ' ' x ($lg - $s2.chars); }
  if $midnight {
    print qq:to<EOF>
         , ($year, $month-x, $day-x, before-sunrise, '$key', "$s1 ☾"$w1, "$sf1 ☾", "Gregorian: $gr1")
         , ($year, $month-x, $day-x, daylight,       '$key', "$s1 ☼"$w1, "$sf1 ☼", "Gregorian: $gr1")
         , ($year, $month-x, $day-x, after-sunset,   '$key', "$s1 ☽"$w1, "$sf1 ☽", "Gregorian: $gr1")
    EOF
  }
  else {
    print qq:to<EOF>
         , ($year, $month-x, $day-x, before-sunrise, '$key', "$s1 ☾"$w1, "$sf1 ☾", "Gregorian: $gr1")
         , ($year, $month-x, $day-x, daylight,       '$key', "$s1 ☼"$w1, "$sf1 ☼", "Gregorian: $gr1")
         , ($year, $month-x, $day-x, after-sunset,   '$key', "$s2 ☽"$w2, "$sf1 ☽", "Gregorian: $gr1")
    EOF
  }
}

sub gener-old-maya($key, $year, $month, $day) {
  my Date::Calendar::FrenchRevolutionary $df1 .= new(year => $year, month => $month, day => $day);
  my Date::Calendar::FrenchRevolutionary $df0 .= new-from-daycount($df1.daycount - 1);
  my Date::Calendar::FrenchRevolutionary $df2 .= new-from-daycount($df1.daycount + 1);
  my Str $sf1 = $df1.strftime('"%a %d %b %Y ☼"');
  my     $d0  = $df0.to-date(%class{$key});
  my     $d1  = $df1.to-date(%class{$key});
  my     $d2  = $df2.to-date(%class{$key});
  my Str $s1  = $d1 .strftime('"%e %B %V %A"');
  my Str $l0  = $d0 .strftime( '%e %B ') ~ $d1.strftime( '%V %A');
  my Str $l2  = $d1 .strftime( '%e %B ') ~ $d2.strftime( '%V %A');
  my Str $gr1 = $df1.to-date.gist;
  my Int $lg-s1 = 24;
  my Int $lg-sf = 19;
  if $s1 .chars < $lg-s1 { $s1  ~= ' ' x ($lg-s1 - $s1 .chars); }
  if $sf1.chars < $lg-sf { $sf1 ~= ' ' x ($lg-sf - $sf1.chars); }
  my Str $day-x   = sprintf("%2d", $day);
  my Str $month-x = sprintf("%2d", $month);
  print qq:to<EOF>
       , ($year, $month-x, $day-x, before-sunrise, '$key', $s1, $sf1, "$gr1 wrong intermediate date, should be $l0")
       , ($year, $month-x, $day-x, daylight,       '$key', $s1, $sf1, "$gr1 no problem")
       , ($year, $month-x, $day-x, after-sunset,   '$key', $s1, $sf1, "$gr1 wrong intermediate date, should be $l2")
  EOF
}

sub gener-new-maya($key, $year, $month, $day) {
  my Date::Calendar::FrenchRevolutionary $df1 .= new(year => $year, month => $month, day => $day);
  my Date::Calendar::FrenchRevolutionary $df0 .= new-from-daycount($df1.daycount - 1);
  my Date::Calendar::FrenchRevolutionary $df2 .= new-from-daycount($df1.daycount + 1);
  my Str $sf0 = $df1.strftime('"%a %d %b %Y ☾"');
  my Str $sf1 = $df1.strftime('"%a %d %b %Y ☼"');
  my Str $sf2 = $df1.strftime('"%a %d %b %Y ☽"');
  my     $d0  = $df0.to-date(%class{$key});
  my     $d1  = $df1.to-date(%class{$key});
  my     $d2  = $df2.to-date(%class{$key});
  my Str $s1  = $d1.strftime('"%e %B %V %A"');
  my Str $s0  = $d0.strftime('"%e %B ') ~ $d1.strftime('%V %A"');
  my Str $s2  = $d1.strftime('"%e %B ') ~ $d2.strftime('%V %A"');
  my Str $gr1 = $df1.to-date.gist;
  my Str $gr2 = $df2.to-date.gist;
  my Int $lg-s1 = 23;
  my Int $lg-sf = 19;
  if $s0 .chars < $lg-s1 { $s0  ~= ' ' x ($lg-s1 - $s0 .chars); }
  if $s1 .chars < $lg-s1 { $s1  ~= ' ' x ($lg-s1 - $s1 .chars); }
  if $s2 .chars < $lg-s1 { $s2  ~= ' ' x ($lg-s1 - $s2 .chars); }
  if $sf0.chars < $lg-sf { $sf0 ~= ' ' x ($lg-sf - $sf0.chars); }
  if $sf1.chars < $lg-sf { $sf1 ~= ' ' x ($lg-sf - $sf1.chars); }
  if $sf2.chars < $lg-sf { $sf2 ~= ' ' x ($lg-sf - $sf2.chars); }
  my Str $day-x   = sprintf("%2d", $day);
  my Str $month-x = sprintf("%2d", $month);
  print qq:to<EOF>
       , ($year, $month-x, $day-x, before-sunrise, '$key', $s0, $sf0, "Gregorian: $gr1")
       , ($year, $month-x, $day-x, daylight,       '$key', $s1, $sf1, "Gregorian: $gr1")
       , ($year, $month-x, $day-x, after-sunset,   '$key', $s2, $sf2, "Gregorian: $gr1")
  EOF
}

=begin pod

=head1 NAME

gener-test-0.1.0.raku -- Generation of test data

=head1 SYNOPSIS

  raku gener-test-0.1.0.raku > /tmp/test-data

copy-paste from /tmp/test-data to the tests scripts.

=head1 DESCRIPTION

This  program  uses  the  various  C<Date::Calendar::>R<xxx>  classes,
version 0.0.x and  API 0, to generate test data  for version 0.1.0 and
API 1.  After the  test data  are generated,  check them  with another
source (the calendar  functions in Emacs, some  websites, some Android
apps). Please remember that the other sources do not care about sunset
(and sunrise for the civil Maya and Aztec calendars) and that you will
have to mentally shift the results before the comparison.

And after  the data are  checked, copy-paste  the lines into  the test
scripts C<xt/12-conv-old.rakutest> and C<xt/13-conv-new.rakutest>.

In C<xt/12-conv-old.rakutest>,  fill the C<@data-maya> array  with the
lines listing Maya and Aztec  dates and fill the C<@data-others> array
with the lines listing other dates. Then cut the lines listing C<'gr'>
dates  and  paste  them  into  the C<@data-greg>  array  and  add  the
Gregorian date with  the 'YYYY-MM-AA' format at the end  of each array
line.

In C<xt/13-conv-new.rakutest>,  fill the C<@data-maya> array  with the
lines listing  Maya and Aztec dates  and fill the C<@data>  array with
the lines listing other dates.

Remember  that you  need to  erase the  first comma  in each  chunk of
copied-pasted code.

Test data are generated only for C<Date::Calendar::FrenchRevolutionary>,
not for the arithmetic and astronomical variants.

All computed  dates are daylight  dates. So  it does not  matter which
version  and API  are  such  and such  classes.  Daylight dates  gives
exactly the  same results with version  0.1.0 / API 1  as with version
0.0.x / API 0.

If  you compare  the various  repositories,  you will  find that  this
C<gener-test-0.1.0.raku>  program is  poorly written  compared to  the
homonymous programs in the other repositories. This is because this is
the first fully functional version. The other are later versions, with
further refinements. I consider that including this refinements into a
fully functional program is not worthwhile.

=head1 AUTHOR

Jean Forget <J2N-FORGET at orange dot fr>

=head1 COPYRIGHT AND LICENSE

Copyright (c) 2024, 2025 Jean Forget, all rights reserved

This program is  free software; you can redistribute  it and/or modify
it under the Artistic License 2.0.

=end pod
