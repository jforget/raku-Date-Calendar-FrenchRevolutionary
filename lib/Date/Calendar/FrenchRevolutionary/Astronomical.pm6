use v6.c;

use Date::Calendar::FrenchRevolutionary::Common;

class    Date::Calendar::FrenchRevolutionary::Astronomical:ver<0.0.3>:auth<cpan:JFORGET>
    does Date::Calendar::FrenchRevolutionary::Common {

  method BUILD(Int:D :$year, Int:D :$month, Int:D :$day, Str :$locale = 'fr') {
    $._chek-build-args($year, $month, $day, $locale, &vnd1);
    $._build-from-args($year, $month, $day, $locale);
  }

  method vnd1 {
    vnd1($.year + 1791);
  }

  method new-from-daycount(Int $count where  { $_ ≥ -24161 }) {
    my ($y, $m, $d) = $.elems-from-daycount($count, &vnd1);
    $.new(year => $y, month => $m, day => $d);
  }

  our sub vnd1(Int:D $year-gr --> Int) {
    my $result;
    given $year-gr %4 {
      when 0 {
        $result = 21;
        given $year-gr {
          when 1792..1796 { $result = 22 }
          when 1800..1840 { $result = 23 }
          when 1844..1896 { $result = 22 }
          when 1900..1964 { $result = 23 }
          when 1968..2088 { $result = 22 }
          when 2100..2196 { $result = 22 }
          when 2200..2212 { $result = 23 }
          when 2216..2296 { $result = 22 }
          when 2300..2336 { $result = 23 }
          when 2340..2460 { $result = 22 }
          when 2500..2584 { $result = 22 }
          when 2600..2696 { $result = 22 }
          when 2700..2704 { $result = 23 }
          when 2708..2828 { $result = 22 }
          when 2900..2948 { $result = 22 }
          when 3000..3068 { $result = 22 }
          when 3100..3188 { $result = 22 }
          when 3300..3308 { $result = 22 }
          when 3400..3428 { $result = 22 }
          when 3500..3548 { $result = 22 }
          when 3668..3696 { $result = 20 }
          when 3788..3796 { $result = 20 }
          when 3900       { $result = 22 }
          when 4020..4096 { $result = 20 }
          when 4136..4196 { $result = 20 }
          when 4256..4296 { $result = 20 }
          when 4372..4480 { $result = 20 }
          when 4484..4496 { $result = 19 }
          when 4500..4696 { $result = 20 }
          when 4716..4828 { $result = 20 }
          when 4832..4896 { $result = 19 }
          when 4900..4944 { $result = 20 }
          when 4948..4996 { $result = 19 }
          when 5000..5056 { $result = 20 }
          when 5060..5096 { $result = 19 }
          when 5100..5172 { $result = 20 }
          when 5176..5284 { $result = 19 }
          when 5288..5296 { $result = 18 }
          when 5300..5496 { $result = 19 }
          when 5500..5512 { $result = 20 }
          when 5516..5624 { $result = 19 }
          when 5628..5696 { $result = 18 }
          when 5700..5740 { $result = 19 }
          when 5744..5796 { $result = 18 }
          when 5800..5852 { $result = 19 }
          when 5856..5896 { $result = 18 }
          when 5900..5964 { $result = 19 }
          when 5968..6076 { $result = 18 }
          when 6080..6096 { $result = 17 }
          when 6100..6188 { $result = 18 }
          when 6192..6196 { $result = 17 }
          when 6200..6296 { $result = 18 }
          when 6300       { $result = 19 }
          when 6304..6412 { $result = 18 }
          when 6416..6496 { $result = 17 }
          when 6500..6524 { $result = 18 }
          when 6528..6596 { $result = 17 }
          when 6600..6636 { $result = 18 }
          when 6640..6696 { $result = 17 }
          when 6700..6748 { $result = 18 }
          when 6752..6860 { $result = 17 }
          when 6864..6896 { $result = 16 }
          when 6900..6972 { $result = 17 }
          when 6976..6996 { $result = 16 }
          when 7000..7084 { $result = 17 }
          when 7088..7096 { $result = 16 }
          when 7100..7192 { $result = 17 }
          when 7196..7296 { $result = 16 }
          when 7300..7304 { $result = 17 }
          when 7308..7396 { $result = 16 }
          when 7400..7416 { $result = 17 }
          when 7420..7496 { $result = 16 }
          when 7500..7528 { $result = 17 }
          when 7532..7640 { $result = 16 }
          when 7644..7696 { $result = 15 }
          when 7700..7752 { $result = 16 }
          when 7756..7788 { $result = 15 }
        }
        if $year-gr ≥ 7788  { $result = 15 }
      }
      when 1 {
        $result = 22;
        given $year-gr {
          when 1801..1869 { $result = 23 }
          when 1901..1997 { $result = 23 }
          when 2101..2117 { $result = 23 }
          when 2201..2245 { $result = 23 }
          when 2301..2369 { $result = 23 }
          when 2493..2497 { $result = 21 }
          when 2601..2613 { $result = 23 }
          when 2701..2733 { $result = 23 }
          when 2861..2897 { $result = 21 }
          when 2981..2997 { $result = 21 }
          when 3221..3297 { $result = 21 }
          when 3341..3397 { $result = 21 }
          when 3461..3497 { $result = 21 }
          when 3581..3693 { $result = 21 }
          when 3697       { $result = 20 }
          when 3701..3797 { $result = 21 }
          when 3817..3897 { $result = 21 }
          when 3933..4045 { $result = 21 }
          when 4049..4097 { $result = 20 }
          when 4101..4165 { $result = 21 }
          when 4169..4197 { $result = 20 }
          when 4201..4277 { $result = 21 }
          when 4281..4297 { $result = 20 }
          when 4301..4397 { $result = 21 }
          when 4401..4497 { $result = 20 }
          when 4501..4513 { $result = 21 }
          when 4517..4597 { $result = 20 }
          when 4601..4625 { $result = 21 }
          when 4629..4697 { $result = 20 }
          when 4701..4741 { $result = 21 }
          when 4745..4857 { $result = 20 }
          when 4861..4897 { $result = 19 }
          when 4901..4969 { $result = 20 }
          when 4973..4997 { $result = 19 }
          when 5001..5085 { $result = 20 }
          when 5089..5097 { $result = 19 }
          when 5101..5201 { $result = 20 }
          when 5205..5297 { $result = 19 }
          when 5301..5313 { $result = 20 }
          when 5317..5397 { $result = 19 }
          when 5401..5425 { $result = 20 }
          when 5429..5497 { $result = 19 }
          when 5501..5541 { $result = 20 }
          when 5545..5653 { $result = 19 }
          when 5657..5697 { $result = 18 }
          when 5701..5765 { $result = 19 }
          when 5769..5797 { $result = 18 }
          when 5801..5877 { $result = 19 }
          when 5881..5897 { $result = 18 }
          when 5901..5989 { $result = 19 }
          when 5993..6097 { $result = 18 }
          when 6101       { $result = 19 }
          when 6105..6197 { $result = 18 }
          when 6201..6217 { $result = 19 }
          when 6221..6297 { $result = 18 }
          when 6301..6329 { $result = 19 }
          when 6333..6441 { $result = 18 }
          when 6445..6497 { $result = 17 }
          when 6501..6553 { $result = 18 }
          when 6557..6597 { $result = 17 }
          when 6601..6665 { $result = 18 }
          when 6669..6697 { $result = 17 }
          when 6701..6777 { $result = 18 }
          when 6781..6885 { $result = 17 }
          when 6889..6897 { $result = 16 }
          when 6901..7097 { $result = 17 }
          when 7101..7109 { $result = 18 }
          when 7113..7221 { $result = 17 }
          when 7225..7297 { $result = 16 }
          when 7301..7333 { $result = 17 }
          when 7337..7397 { $result = 16 }
          when 7401..7445 { $result = 17 }
          when 7449..7497 { $result = 16 }
          when 7501..7557 { $result = 17 }
          when 7561..7665 { $result = 16 }
          when 7669..7697 { $result = 15 }
          when 7701..7777 { $result = 16 }
          when 7781..7789 { $result = 15 }
        }
        if $year-gr ≥ 7789  { $result = 15 }
      }
      when 2 {
        $result = 22;
        given $year-gr {
          when 1802..1898 { $result = 23 }
          when 1902       { $result = 24 }
          when 1906..2026 { $result = 23 }
          when 2102..2150 { $result = 23 }
          when 2202..2274 { $result = 23 }
          when 2302..2398 { $result = 23 }
          when 2502..2522 { $result = 23 }
          when 2602..2646 { $result = 23 }
          when 2702..2766 { $result = 23 }
          when 2890..2898 { $result = 21 }
          when 3002..3006 { $result = 23 }
          when 3102..3126 { $result = 23 }
          when 3254..3298 { $result = 21 }
          when 3370..3398 { $result = 21 }
          when 3490..3498 { $result = 21 }
          when 3610..3698 { $result = 21 }
          when 3726..3798 { $result = 21 }
          when 3846..3898 { $result = 21 }
          when 3962..4074 { $result = 21 }
          when 4078..4098 { $result = 20 }
          when 4102..4194 { $result = 21 }
          when 4198       { $result = 20 }
          when 4202..4298 { $result = 21 }
          when 4314..4426 { $result = 21 }
          when 4430..4498 { $result = 20 }
          when 4502..4542 { $result = 21 }
          when 4546..4598 { $result = 20 }
          when 4602..4654 { $result = 21 }
          when 4658..4698 { $result = 20 }
          when 4702..4770 { $result = 21 }
          when 4774..4886 { $result = 20 }
          when 4890..4898 { $result = 19 }
          when 4902..5098 { $result = 20 }
          when 5102..5114 { $result = 21 }
          when 5118..5226 { $result = 20 }
          when 5230..5298 { $result = 19 }
          when 5302..5342 { $result = 20 }
          when 5346..5398 { $result = 19 }
          when 5402..5454 { $result = 20 }
          when 5458..5498 { $result = 19 }
          when 5502..5570 { $result = 20 }
          when 5574..5682 { $result = 19 }
          when 5686..5698 { $result = 18 }
          when 5702..5794 { $result = 19 }
          when 5798       { $result = 18 }
          when 5802..5898 { $result = 19 }
          when 5902..5906 { $result = 20 }
          when 5910..6022 { $result = 19 }
          when 6026..6098 { $result = 18 }
          when 6102..6134 { $result = 19 }
          when 6138..6198 { $result = 18 }
          when 6202..6246 { $result = 19 }
          when 6250..6298 { $result = 18 }
          when 6302..6358 { $result = 19 }
          when 6362..6470 { $result = 18 }
          when 6474..6498 { $result = 17 }
          when 6502..6582 { $result = 18 }
          when 6586..6598 { $result = 17 }
          when 6602..6690 { $result = 18 }
          when 6694..6698 { $result = 17 }
          when 6702..6802 { $result = 18 }
          when 6806..6898 { $result = 17 }
          when 6902..6914 { $result = 18 }
          when 6918..6998 { $result = 17 }
          when 7002..7026 { $result = 18 }
          when 7030..7098 { $result = 17 }
          when 7102..7138 { $result = 18 }
          when 7142..7250 { $result = 17 }
          when 7254..7298 { $result = 16 }
          when 7302..7362 { $result = 17 }
          when 7366..7398 { $result = 16 }
          when 7402..7474 { $result = 17 }
          when 7478..7498 { $result = 16 }
          when 7502..7586 { $result = 17 }
          when 7590..7694 { $result = 16 }
          when 7698       { $result = 15 }
          when 7702..7790 { $result = 16 }
        }
        if $year-gr ≥ 7790  { $result = 16 }
      }
      when 3 {
        $result = 22;
        given $year-gr {
          when 1795..1799 { $result = 23 }
          when 1803..1807 { $result = 24 }
          when 1811..1899 { $result = 23 }
          when 1903..1931 { $result = 24 }
          when 1935..2059 { $result = 23 }
          when 2103..2183 { $result = 23 }
          when 2203..2299 { $result = 23 }
          when 2303..2307 { $result = 24 }
          when 2311..2431 { $result = 23 }
          when 2503..2551 { $result = 23 }
          when 2603..2675 { $result = 23 }
          when 2703..2795 { $result = 23 }
          when 2903..2915 { $result = 23 }
          when 3003..3039 { $result = 23 }
          when 3103..3159 { $result = 23 }
          when 3283..3299 { $result = 21 }
          when 3503..3515 { $result = 23 }
          when 3639..3699 { $result = 21 }
          when 3755..3799 { $result = 21 }
          when 3875..3899 { $result = 21 }
          when 3991..4099 { $result = 21 }
          when 4111..4199 { $result = 21 }
          when 4227..4299 { $result = 21 }
          when 4343..4455 { $result = 21 }
          when 4459..4499 { $result = 20 }
          when 4503..4571 { $result = 21 }
          when 4575..4599 { $result = 20 }
          when 4603..4683 { $result = 21 }
          when 4687..4699 { $result = 20 }
          when 4703..4799 { $result = 21 }
          when 4803..4899 { $result = 20 }
          when 4903..4911 { $result = 21 }
          when 4915..4999 { $result = 20 }
          when 5003..5027 { $result = 21 }
          when 5031..5099 { $result = 20 }
          when 5103..5143 { $result = 21 }
          when 5147..5255 { $result = 20 }
          when 5259..5299 { $result = 19 }
          when 5303..5371 { $result = 20 }
          when 5375..5399 { $result = 19 }
          when 5403..5483 { $result = 20 }
          when 5487..5499 { $result = 19 }
          when 5503..5595 { $result = 20 }
          when 5599..5699 { $result = 19 }
          when 5703..5711 { $result = 20 }
          when 5715..5799 { $result = 19 }
          when 5803..5823 { $result = 20 }
          when 5827..5899 { $result = 19 }
          when 5903..5935 { $result = 20 }
          when 5939..6047 { $result = 19 }
          when 6051..6099 { $result = 18 }
          when 6103..6159 { $result = 19 }
          when 6163..6199 { $result = 18 }
          when 6203..6271 { $result = 19 }
          when 6275..6299 { $result = 18 }
          when 6303..6383 { $result = 19 }
          when 6387..6495 { $result = 18 }
          when 6499       { $result = 17 }
          when 6503..6599 { $result = 18 }
          when 6603..6607 { $result = 19 }
          when 6611..6699 { $result = 18 }
          when 6703..6719 { $result = 19 }
          when 6723..6831 { $result = 18 }
          when 6835..6899 { $result = 17 }
          when 6903..6943 { $result = 18 }
          when 6947..6999 { $result = 17 }
          when 7003..7055 { $result = 18 }
          when 7059..7099 { $result = 17 }
          when 7103..7167 { $result = 18 }
          when 7171..7279 { $result = 17 }
          when 7283..7299 { $result = 16 }
          when 7303..7387 { $result = 17 }
          when 7391..7399 { $result = 16 }
          when 7403..7611 { $result = 17 }
          when 7615..7699 { $result = 16 }
          when 7703..7723 { $result = 17 }
          when 7727..7791 { $result = 16 }
        }
        if $year-gr ≥ 7791  { $result = 16 }
      }
    }
    $result;
  }
}

=begin pod

=head1 NAME

Date::Calendar::FrenchRevolutionary::Astronomical - Conversions from / to the French Revolutionary calendar

=head1 SYNOPSIS

Converting from a Gregorian date to a French Revolutionary date

=begin code :lang<perl6>

use Date::Calendar::FrenchRevolutionary::Astronomical;
my  Date                                              $Bonaparte's-coup-gr;
my  Date::Calendar::FrenchRevolutionary::Astronomical $Bonaparte's-coup-fr;

$Bonaparte's-coup-gr .= new(1799, 11, 9);
$Bonaparte's-coup-fr .= new-from-date($Bonaparte's-coup-gr);

say $Bonaparte's-coup-fr;
# ---> "0008-02-18" for 18 Brumaire VIII
say "{.day-name} {.day} {.month-name} {.year} {.feast-long}" with  $Bonaparte's-coup-fr;
# ---> "Octidi 18 Brumaire 8 jour de la dentelaire"

=end code

Converting from a French Revolutionary date to a Gregorian date

=begin code :lang<perl6>

use Date::Calendar::FrenchRevolutionary::Astronomical;
my  Date::Calendar::FrenchRevolutionary::Astronomical $Robespierre's-downfall-frv:
my  Date                                              $Robespierre's-downfall-grg;

$Robespierre's-downfall-frv .= new(year =>  2, month => 11, day =>  9);
$Robespierre's-downfall-grg  = $Robespierre's-downfall-frv.to-date;
say $Robespierre's-downfall-grg;

=end code

=head1 DESCRIPTION

Date::Calendar::FrenchRevolutionary::Astronomical    is     a    class
representing dates in the French Revolutionary calendar. It allows you
to convert  a Gregorian date into  a French Revolutionary date  or the
other way. This  class uses the autumn equinox rule  for computing the
beginning of each year, even after year XX.

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
1792, which  happened to be the  equinox, and second, the  equinox was
the symbol of equality, the day and the night lasting exactly 12 hours
each. It  was therefore  in tune with  the republic's  motto "Liberty,
Equality, Fraternity". But  it was not practical, so  Romme proposed a
leap year rule similar to the Gregorian calendar rule.

The  distribution contains  two other  classes, one  where the  reform
replacing the astronomical rule by  the arithmetic rule took effect in
year  XX (1811),  the  other  where this  reform  took  effect at  the
creation of the calendar.

=head1 PROBLEMS AND KNOWN BUGS

Previously, the equinox rule had  been generated according to Reingold
and Dershowitz's  book I<Calendar Calculations> and  the corresponding
Common Lisp  program C<calendrica-3.0.cl>.  I have found  that running
this  program with  the C<clisp>  interpreter gives  different results
from running the  same program with the C<gcl>  interpreter. The first
differences  occur  in  Gregorian  years 1807  and  1840.  The  French
Revolutionary calendar was  no longer in use, but still...  I think it
is caused by  a rounding error which pushes the  autumn equinox to the
wrong side of midnight.

Anyhow, the  values used in  this version  are the values  produced by
running C<calendar.l>,  which are  identical when running  C<clisp> or
C<gcl>. No more rounding errors (I still have to check, though).

In  addition,  the  algorithm  used  in  I<Calendar  Calculations>  is
reliable, I think, for a few  centuries, but not for several millenia.
The  problem is  I do  not know  when I  should stop  computing autumn
equinoxes. Let us say that after 500 or 1000 years, the errors will be
too many. Before that, we will already have a few errors.

=head1 AUTHOR

Jean Forget <JFORGET at cpan dot org>

=head1 COPYRIGHT AND LICENSE

Copyright 2019 Jean Forget, all rights reserved

This library is  free software; you can redistribute  it and/or modify
it under the Artistic License 2.0.

=end pod
