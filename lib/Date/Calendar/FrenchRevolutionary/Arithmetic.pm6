use v6.c;

use Date::Calendar::FrenchRevolutionary::Common;

class    Date::Calendar::FrenchRevolutionary::Arithmetic:ver<0.0.1>:auth<cpan:JFORGET>
    does Date::Calendar::FrenchRevolutionary::Common {

}

=begin pod

=head1 NAME

Date::Calendar::FrenchRevolutionary::Arithmetic - Conversions from / to the French Revolutionary calendar

=head1 SYNOPSIS

=begin code :lang<perl6>

use Date::Calendar::FrenchRevolutionary::Arithmetic;

=end code

=head1 DESCRIPTION

Date::Calendar::FrenchRevolutionary::Arithmetic     is     a     class
representing dates in the French Revolutionary calendar. It allows you
to convert  a Gregorian date into  a French Revolutionary date  or the
other  way. This  class uses  the  arithmetic rule  for computing  the
successive year lengths since the beginning of the calendar.

The Revolutionary calendar was in use  in France from 24 November 1793
(4 Frimaire  II) to 31  December 1805 (10  Nivôse XIV). An  attempt to
apply  the decimal  rule  (the  basis of  the  metric  system) to  the
calendar. Therefore, the week disappeared,  replaced by the décade. In
addition, all months have exactly 3 decades, no more, no less.

At first,  the year was  beginning on the  equinox of autumn,  for two
reasons.  First, the  republic had  been established  on 22  September
1792, which  happened to be the  equinox, and second, the  equinox was
the symbol of equality, the day and the night lasting exactly 12 hours
each. It  was therefore  in tune with  the republic's  motto "Liberty,
Equality, Fraternity". But  it was not practical, so  Romme proposed a
leap year rule similar to the Gregorian calendar rule.

The  distribution contains  two other  classes, one  where the  reform
replacing the astronomical rule by  the arithmetic rule took effect in
year XX  (1811), the other  where there was  no reform and  the automn
equinox rule stayed in effect even after year XX.

=head1 AUTHOR

Jean Forget <JFORGET at cpan dot org>

=head1 COPYRIGHT AND LICENSE

Copyright 2019 Jean Forget, all rights reserved

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod