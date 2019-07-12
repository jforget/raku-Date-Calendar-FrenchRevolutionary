use v6.c;

use Date::Calendar::FrenchRevolutionary::Common;

class    Date::Calendar::FrenchRevolutionary::Astronomical:ver<0.0.1>:auth<cpan:JFORGET>
    does Date::Calendar::FrenchRevolutionary::Common {

  method vnd1 {
    vnd1($.year + 1791);
  }

  method new-from-daycount(Int $count) {
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
          when 1800..1836 { $result = 23 }
          when 1840..1896 { $result = 22 }
          when 1900..1964 { $result = 23 }
          when 1968..2088 { $result = 22 }
          when 2100..2196 { $result = 22 }
          when 2200..2212 { $result = 23 }
          when 2216..2296 { $result = 22 }
          when 2300..2336 { $result = 23 }
          when 2340..2456 { $result = 22 }
          when 2500..2580 { $result = 22 }
          when 2600..2696 { $result = 22 }
          when 2700..2704 { $result = 23 }
          when 2708..2820 { $result = 22 }
          when 2900..2948 { $result = 22 }
          when 3000..3072 { $result = 22 }
          when 3100..3176 { $result = 22 }
          when 3300       { $result = 22 }
          when 3400..3420 { $result = 22 }
          when 3500..3544 { $result = 22 }
          when 3668..3696 { $result = 20 }
          when 3788..3796 { $result = 20 }
          when 3900..3908 { $result = 22 }
          when 4028..4096 { $result = 20 }
          when 4136..4196 { $result = 20 }
          when 4244..4296 { $result = 20 }
          when 4364..4476 { $result = 20 }
          when 4480..4496 { $result = 19 }
          when 4500..4596 { $result = 20 }
          when 4608..4696 { $result = 20 }
          when 4712..4824 { $result = 20 }
          when 4828..4896 { $result = 19 }
          when 4900..4944 { $result = 20 }
          when 4948..4996 { $result = 19 }
          when 5000..5056 { $result = 20 }
          when 5060..5096 { $result = 19 }
          when 5100..5164 { $result = 20 }
          when 5168..5272 { $result = 19 }
          when 5276       { $result = 18 }
          when 5280       { $result = 19 }
          when 5284..5296 { $result = 18 }
          when 5300..5384 { $result = 19 }
          when 5388       { $result = 18 }
          when 5392       { $result = 19 }
          when 5396       { $result = 18 }
          when 5400..5628 { $result = 19 }
          when 5632       { $result = 18 }
          when 5636       { $result = 19 }
          when 5640..5696 { $result = 18 }
          when 5700..5724 { $result = 19 }
          when 5728       { $result = 18 }
          when 5732       { $result = 19 }
          when 5736..5796 { $result = 18 }
          when 5800..5852 { $result = 19 }
          when 5856..5896 { $result = 18 }
          when 5900..5948 { $result = 19 }
          when 5952..6060 { $result = 18 }
          when 6064..6096 { $result = 17 }
          when 6100..6172 { $result = 18 }
          when 6176..6196 { $result = 17 }
          when 6200..6292 { $result = 18 }
          when 6296       { $result = 17 }
          when 6300       { $result = 19 }
          when 6304..6416 { $result = 18 }
          when 6420..6496 { $result = 17 }
          when 6500..6520 { $result = 18 }
          when 6524       { $result = 17 }
          when 6528       { $result = 18 }
          when 6532..6596 { $result = 17 }
          when 6600..6632 { $result = 18 }
          when 6636..6696 { $result = 17 }
          when 6700..6728 { $result = 18 }
          when 6732       { $result = 17 }
          when 6736       { $result = 18 }
          when 6740..6840 { $result = 17 }
          when 6844       { $result = 16 }
          when 6848       { $result = 17 }
          when 6852..6896 { $result = 16 }
          when 6900..6964 { $result = 17 }
          when 6968..6996 { $result = 16 }
          when 7000..7080 { $result = 17 }
          when 7084..7096 { $result = 16 }
          when 7100..7196 { $result = 17 }
          when 7200       { $result = 16 }
          when 7204       { $result = 17 }
          when 7208..7288 { $result = 16 }
          when 7292..7296 { $result = 15 }
          when 7300..7396 { $result = 16 }
          when 7400       { $result = 17 }
          when 7404..7408 { $result = 16 }
          when 7412       { $result = 17 }
          when 7416..7496 { $result = 16 }
          when 7500..7504 { $result = 17 }
          when 7508       { $result = 16 }
          when 7512..7516 { $result = 17 }
          when 7520..7636 { $result = 16 }
          when 7640..7696 { $result = 15 }
          when 7700..7748 { $result = 16 }
          when 7752       { $result = 15 }
          when 7756       { $result = 16 }
          when 7760..7788 { $result = 15 }
        }
        if $year-gr ≥ 7788  { $result = 15 }
      }
      when 1 {
        $result = 17;
        given $year-gr {
          when 1793..1797 { $result = 22 }
          when 1801..1869 { $result = 23 }
          when 1873..1897 { $result = 22 }
          when 1901..1993 { $result = 23 }
          when 1997..2097 { $result = 22 }
          when 2101..2117 { $result = 23 }
          when 2121..2197 { $result = 22 }
          when 2201..2245 { $result = 23 }
          when 2249..2297 { $result = 22 }
          when 2301..2365 { $result = 23 }
          when 2369..2489 { $result = 22 }
          when 2493..2497 { $result = 21 }
          when 2501..2597 { $result = 22 }
          when 2601..2613 { $result = 23 }
          when 2617..2697 { $result = 22 }
          when 2701..2729 { $result = 23 }
          when 2733..2853 { $result = 22 }
          when 2857..2897 { $result = 21 }
          when 2901..2977 { $result = 22 }
          when 2981..2997 { $result = 21 }
          when 3001..3209 { $result = 22 }
          when 3213..3297 { $result = 21 }
          when 3301..3325 { $result = 22 }
          when 3329..3397 { $result = 21 }
          when 3401..3453 { $result = 22 }
          when 3457..3497 { $result = 21 }
          when 3501..3569 { $result = 22 }
          when 3573..3685 { $result = 21 }
          when 3689..3697 { $result = 20 }
          when 3701..3797 { $result = 21 }
          when 3801..3813 { $result = 22 }
          when 3817..3897 { $result = 21 }
          when 3901..3929 { $result = 22 }
          when 3933..4041 { $result = 21 }
          when 4045..4097 { $result = 20 }
          when 4101..4153 { $result = 21 }
          when 4157..4197 { $result = 20 }
          when 4201..4269 { $result = 21 }
          when 4273..4297 { $result = 20 }
          when 4301..4397 { $result = 21 }
          when 4401..4497 { $result = 20 }
          when 4501..4513 { $result = 21 }
          when 4517..4597 { $result = 20 }
          when 4601..4629 { $result = 21 }
          when 4633..4697 { $result = 20 }
          when 4701..4729 { $result = 21 }
          when 4733..4849 { $result = 20 }
          when 4853..4897 { $result = 19 }
          when 4901..4957 { $result = 20 }
          when 4961..4997 { $result = 19 }
          when 5001..5085 { $result = 20 }
          when 5089..5097 { $result = 19 }
          when 5101..5193 { $result = 20 }
          when 5197..5297 { $result = 19 }
          when 5301       { $result = 20 }
          when 5305       { $result = 19 }
          when 5309       { $result = 20 }
          when 5313..5397 { $result = 19 }
          when 5401..5413 { $result = 20 }
          when 5417       { $result = 19 }
          when 5421..5425 { $result = 20 }
          when 5429..5497 { $result = 19 }
          when 5501..5529 { $result = 20 }
          when 5533       { $result = 19 }
          when 5537       { $result = 20 }
          when 5541..5657 { $result = 19 }
          when 5661..5697 { $result = 18 }
          when 5701..5769 { $result = 19 }
          when 5773..5797 { $result = 18 }
          when 5801..5881 { $result = 19 }
          when 5885..5897 { $result = 18 }
          when 5901..5977 { $result = 19 }
          when 5981..6089 { $result = 18 }
          when 6101..6197 { $result = 18 }
          when 6201       { $result = 19 }
          when 6205..6209 { $result = 18 }
          when 6213       { $result = 19 }
          when 6217..6297 { $result = 18 }
          when 6301..6317 { $result = 19 }
          when 6321..6445 { $result = 18 }
          when 6501..6549 { $result = 18 }
          when 6557       { $result = 18 }
          when 6601..6641 { $result = 18 }
          when 6701..6765 { $result = 18 }
          when 6873       { $result = 16 }
          when 6881..6897 { $result = 16 }
          when 6985       { $result = 16 }
          when 6993..6997 { $result = 16 }
          when 7101..7113 { $result = 18 }
          when 7121       { $result = 18 }
          when 7229       { $result = 16 }
          when 7237..7297 { $result = 16 }
          when 7305..7309 { $result = 16 }
          when 7317..7397 { $result = 16 }
          when 7437       { $result = 16 }
          when 7445..7497 { $result = 16 }
          when 7549..7657 { $result = 16 }
          when 7661..7697 { $result = 15 }
          when 7701..7785 { $result = 16 }
          when 7789       { $result = 15 }
        }
        if $year-gr ≥ 7789  { $result = 15 }
      }
      when 2 {
        $result = 22;
        given $year-gr {
          when 1802..2026 { $result = 23 }
          when 2102..2150 { $result = 23 }
          when 2202..2274 { $result = 23 }
          when 2302..2398 { $result = 23 }
          when 2502..2522 { $result = 23 }
          when 2602..2646 { $result = 23 }
          when 2702..2758 { $result = 23 }
          when 2894..2898 { $result = 21 }
          when 3002..3010 { $result = 23 }
          when 3102..3114 { $result = 23 }
          when 3246..3298 { $result = 21 }
          when 3362..3398 { $result = 21 }
          when 3486..3498 { $result = 21 }
          when 3602       { $result = 21 }
          when 3610..3698 { $result = 21 }
          when 3726..3798 { $result = 21 }
          when 3846..3898 { $result = 21 }
          when 3962..4062 { $result = 21 }
          when 4066..4098 { $result = 20 }
          when 4102..4182 { $result = 21 }
          when 4186..4198 { $result = 20 }
          when 4202..4298 { $result = 21 }
          when 4310..4426 { $result = 21 }
          when 4430..4498 { $result = 20 }
          when 4502..4542 { $result = 21 }
          when 4546..4598 { $result = 20 }
          when 4602..4654 { $result = 21 }
          when 4658..4698 { $result = 20 }
          when 4702..4758 { $result = 21 }
          when 4762..4878 { $result = 20 }
          when 4882       { $result = 19 }
          when 4886       { $result = 20 }
          when 4890..4898 { $result = 19 }
          when 4902..4986 { $result = 20 }
          when 4990..4998 { $result = 19 }
          when 5002..5098 { $result = 20 }
          when 5102..5114 { $result = 21 }
          when 5118       { $result = 20 }
          when 5122       { $result = 21 }
          when 5126..5218 { $result = 20 }
          when 5222..5298 { $result = 19 }
          when 5302..5326 { $result = 20 }
          when 5330..5398 { $result = 19 }
          when 5402..5454 { $result = 20 }
          when 5458..5498 { $result = 19 }
          when 5502..5566 { $result = 20 }
          when 5570..5670 { $result = 19 }
          when 5674..5698 { $result = 18 }
          when 5702..5802 { $result = 19 }
          when 5806..5810 { $result = 20 }
          when 5814..5886 { $result = 19 }
          when 5890..5898 { $result = 18 }
          when 5902..5990 { $result = 19 }
          when 5994       { $result = 18 }
          when 5998       { $result = 19 }
          when 6002..6098 { $result = 18 }
          when 6102..6122 { $result = 19 }
          when 6126       { $result = 18 }
          when 6130       { $result = 19 }
          when 6134..6198 { $result = 18 }
          when 6202..6234 { $result = 19 }
          when 6238       { $result = 18 }
          when 6242       { $result = 19 }
          when 6246..6298 { $result = 18 }
          when 6302..6346 { $result = 19 }
          when 6350..6474 { $result = 18 }
          when 6478..6498 { $result = 17 }
          when 6502..6586 { $result = 18 }
          when 6590..6598 { $result = 17 }
          when 6602..6666 { $result = 18 }
          when 6670..6698 { $result = 17 }
          when 6702..6794 { $result = 18 }
          when 6798..6802 { $result = 17 }
          when 6806       { $result = 18 }
          when 6810..6902 { $result = 17 }
          when 6906..6910 { $result = 18 }
          when 6914..6998 { $result = 17 }
          when 7002..7022 { $result = 18 }
          when 7026..7098 { $result = 17 }
          when 7102..7134 { $result = 18 }
          when 7138..7254 { $result = 17 }
          when 7258       { $result = 16 }
          when 7262       { $result = 17 }
          when 7266..7298 { $result = 16 }
          when 7302..7342 { $result = 17 }
          when 7346..7398 { $result = 16 }
          when 7402..7462 { $result = 17 }
          when 7466..7498 { $result = 16 }
          when 7502..7574 { $result = 17 }
          when 7578       { $result = 16 }
          when 7582       { $result = 17 }
          when 7586..7686 { $result = 16 }
          when 7690..7694 { $result = 15 }
          when 7698..7790 { $result = 16 }
        }
        if $year-gr ≥ 7790  { $result = 16 }
      }
      when 3 {
        $result = 22;
        given $year-gr {
          when 1795..1799 { $result = 23 }
          when 1803       { $result = 24 }
          when 1807..1899 { $result = 23 }
          when 1903..1931 { $result = 24 }
          when 1935..2059 { $result = 23 }
          when 2103..2183 { $result = 23 }
          when 2203..2299 { $result = 23 }
          when 2303..2307 { $result = 24 }
          when 2311..2427 { $result = 23 }
          when 2503..2551 { $result = 23 }
          when 2603..2675 { $result = 23 }
          when 2703..2787 { $result = 23 }
          when 2903..2919 { $result = 23 }
          when 3003..3039 { $result = 23 }
          when 3103..3147 { $result = 23 }
          when 3271..3299 { $result = 21 }
          when 3395..3399 { $result = 21 }
          when 3503..3515 { $result = 23 }
          when 3639..3699 { $result = 21 }
          when 3755..3799 { $result = 21 }
          when 3875..3899 { $result = 21 }
          when 3999..4095 { $result = 21 }
          when 4099       { $result = 20 }
          when 4107..4199 { $result = 21 }
          when 4223..4299 { $result = 21 }
          when 4343..4447 { $result = 21 }
          when 4451..4499 { $result = 20 }
          when 4503..4567 { $result = 21 }
          when 4571..4599 { $result = 20 }
          when 4603..4691 { $result = 21 }
          when 4695..4699 { $result = 20 }
          when 4703..4795 { $result = 21 }
          when 4799..4899 { $result = 20 }
          when 4903..4911 { $result = 21 }
          when 4915..4999 { $result = 20 }
          when 5003..5015 { $result = 21 }
          when 5019..5099 { $result = 20 }
          when 5103..5139 { $result = 21 }
          when 5143..5243 { $result = 20 }
          when 5247       { $result = 19 }
          when 5251       { $result = 20 }
          when 5255..5299 { $result = 19 }
          when 5303..5355 { $result = 20 }
          when 5359       { $result = 19 }
          when 5363       { $result = 20 }
          when 5367..5399 { $result = 19 }
          when 5403..5483 { $result = 20 }
          when 5487..5499 { $result = 19 }
          when 5503..5595 { $result = 20 }
          when 5599..5691 { $result = 19 }
          when 5695..5699 { $result = 18 }
          when 5703..5799 { $result = 19 }
          when 5803..5823 { $result = 20 }
          when 5827..5899 { $result = 19 }
          when 5903..5907 { $result = 20 }
          when 5911       { $result = 19 }
          when 5915       { $result = 20 }
          when 5919..6019 { $result = 19 }
          when 6023       { $result = 18 }
          when 6027..6031 { $result = 19 }
          when 6035..6099 { $result = 18 }
          when 6103..6151 { $result = 19 }
          when 6155..6199 { $result = 18 }
          when 6203..6263 { $result = 19 }
          when 6267       { $result = 18 }
          when 6271       { $result = 19 }
          when 6275..6299 { $result = 18 }
          when 6303..6375 { $result = 19 }
          when 6379       { $result = 18 }
          when 6383       { $result = 19 }
          when 6387..6487 { $result = 18 }
          when 6491..6495 { $result = 17 }
          when 6499..6599 { $result = 18 }
          when 6603..6619 { $result = 19 }
          when 6623       { $result = 18 }
          when 6627       { $result = 19 }
          when 6631..6695 { $result = 18 }
          when 6699       { $result = 17 }
          when 6703..6811 { $result = 18 }
          when 6815       { $result = 17 }
          when 6819       { $result = 18 }
          when 6823..6899 { $result = 17 }
          when 6903..6939 { $result = 18 }
          when 6943..6999 { $result = 17 }
          when 7003..7051 { $result = 18 }
          when 7055..7099 { $result = 17 }
          when 7103..7163 { $result = 18 }
          when 7167..7279 { $result = 17 }
          when 7283..7299 { $result = 16 }
          when 7303..7371 { $result = 17 }
          when 7375..7399 { $result = 16 }
          when 7403..7475 { $result = 17 }
          when 7479       { $result = 16 }
          when 7483       { $result = 17 }
          when 7487..7499 { $result = 16 }
          when 7503..7615 { $result = 17 }
          when 7619..7699 { $result = 16 }
          when 7703..7719 { $result = 17 }
          when 7723       { $result = 16 }
          when 7727       { $result = 17 }
          when 7731..7791 { $result = 16 }
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

=begin code :lang<perl6>

use Date::Calendar::FrenchRevolutionary::Astronomical;

=end code

=head1 DESCRIPTION

Date::Calendar::FrenchRevolutionary::Astronomical    is     a    class
representing dates in the French Revolutionary calendar. It allows you
to convert  a Gregorian date into  a French Revolutionary date  or the
other way. This  class uses the autumn equinox rule  for computing the
beginning of each year, even after year XX.

The Revolutionary calendar was in use  in France from 24 November 1793
(4 Frimaire  II) to 31  December 1805 (10  Nivôse XIV). An  attempt to
apply  the decimal  rule  (the  basis of  the  metric  system) to  the
calendar. Therefore, the week disappeared,  replaced by the décade. In
addition, all months have exactly 3 decades, no more, no less.

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

The  equinox  rule  has  been  generated  according  to  Reingold  and
Dershowitz's  book  I<Calendar  Calculations>  and  the  corresponding
Common Lisp  program C<calendrica-3.0.cl>.  I have found  that running
this  program with  the C<clisp>  interpreter gives  different results
from running the  same program with the C<gcl>  interpreter. The first
differences  occur  in  Gregorian  years 1807  and  1840.  The  French
Revolutionary calendar was  no longer in use, but still...  I think it
is caused by  a rounding error which pushes the  autumn equinox to the
wrong side of midnight. I will investigate this matter.

The values  used in this  version are  the values produced  by running
C<calendrica-3.0.cl> with C<clisp>.

In  addition,  the  algorithm  used  in  I<Calendar  Calculations>  is
reliable, I think, for a few  centuries, but not for several millenia.
The  problem is  I do  not know  when I  should stop  computing autumn
equinoxes. Let us say that after 500 or 1000 years, the errors will be
too many. Before that, we will have a few errors yet.

=head1 AUTHOR

Jean Forget <JFORGET at cpan dot org>

=head1 COPYRIGHT AND LICENSE

Copyright 2019 Jean Forget, all rights reserved

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod
