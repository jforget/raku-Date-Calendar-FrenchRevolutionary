use v6.c;

use Date::Calendar::FrenchRevolutionary::Common;
use Date::Calendar::FrenchRevolutionary::Astronomical;
use Date::Calendar::FrenchRevolutionary::Arithmetic;

class    Date::Calendar::FrenchRevolutionary:ver<0.0.2>:auth<cpan:JFORGET>
    does Date::Calendar::FrenchRevolutionary::Common {

  method new-from-daycount(Int $count) {
    my ($y, $m, $d) = $.elems-from-daycount($count, &vnd1);
    $.new(year => $y, month => $m, day => $d);
  }

  method vnd1 {
    vnd1($.year + 1791);
  }

  our sub vnd1(Int:D $year-gr --> Int) {
    if $year-gr < 1811 {
      return Date::Calendar::FrenchRevolutionary::Astronomical::vnd1($year-gr);
    }
    else {
      return Date::Calendar::FrenchRevolutionary::Arithmetic::vnd1($year-gr);
    }
  }

}

=begin pod

=head1 NAME

Date::Calendar::FrenchRevolutionary - Conversions from / to the French Revolutionary calendar

=head1 SYNOPSIS

Converting from a Gregorian date to a French Revolutionary date

=begin code :lang<perl6>

use Date::Calendar::FrenchRevolutionary;
my Date                                $Bonaparte's-coup-gr .= new(1799, 11, 9);
my Date::Calendar::FrenchRevolutionary $Bonaparte's-coup-fr .= new-from-date($Bonaparte's-coup-gr);
say $Bonaparte's-coup-fr;
# ---> "0008-02-18" for 18 Brumaire VIII
say "{.day-name} {.day} {.month-name} {.year} {.feast-long}" with  $Bonaparte's-coup-fr;
# ---> "Octidi 18 Brumaire 8 jour de la dentelaire"

=end code

Converting from a  French Revolutionary date to a Gregorian date

=begin code :lang<perl6>

use Date::Calendar::FrenchRevolutionary;
my Date::Calendar::FrenchRevolutionary $Robespierre's-downfall-fr .= new(year    =>  2
                                                                       , month   => 11
                                                                       , day     =>  9);
my Date                                $Robespierre's-downfall-gr =  $Robespierre's-downfall-fr.to-date;
say $Robespierre's-downfall-gr;

=end code

=head1 DESCRIPTION

Date::Calendar::FrenchRevolutionary is  a class representing  dates in
the  French  Revolutionary  calendar.  It  allows  you  to  convert  a
Gregorian date into a French Revolutionary date or the other way.

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

The distribution  contains two other  classes, one where there  was no
reform and the automn equinox rule stayed in effect, another where the
arithmetic rule was established since the beginning of the calendar.

=head1 METHODS

=head2 Constructors

=head3 new

Create a French  Revolutionary date by giving the year,  month and day
numbers and optionaly the locale.

=head3 new-from-date

Build a  French Revolutionary date  by cloning an object  from another
class.  This  other  class  can  be the  core  class  C<Date>  or  any
C<Date::Calendar::xxx> class with a C<daycount> method.

=head3 new-from-daycount

Build a French Revolutionary date from the Modified Julian Day number.

=head2 Accessors

=head3 year, month, day

The numbers defining the date.

=head3 month-name

The month of the date, as a string. This depends on the date's current
locale.

=head3 day-name

The name of the day within  the I<décade> (ten-day period). It depends
on the date's current locale.

=head3 feast, feast-long, feast-caps

The name  of the  feast of  the day, according  to the  date's current
locale.

While the  C<feast> method gives  the feast unadorned:  C<"safran"> or
C<"saffron">,  the  C<feast-long> method  adds  a  prefix: C<"jour  du
safran"> or C<"day of saffron">. In addition, the C<feast-caps> method
use titlecase  for the prefix  and the  feast: C<"Jour du  Safran"> or
C<"Day of Saffron">.

=head2 Other Methods

=head3 to-date

Clones  the   date  into   a  core  class   C<Date>  object   or  some
C<Date::Calendar::>I<xxx> compatible calendar  class. The target class
name is given as a positional parameter.

To convert a date from a  calendar to another, you have two conversion
styles,  a "push"  conversion and  a "pull"  conversion. For  example,
while converting from the astronomical  date "1 Vendémiaire IV" to the
arithmetic variant, you can code:

=begin code :lang<perl6>

use Date::Calendar::FrenchRevolutionary::Astronomical;
use Date::Calendar::FrenchRevolutionary::Arithmetic;
my Date::Calendar::FrenchRevolutionary::Astronomical $d-in .= new(year  => 4
                                                                , month => 1
                                                                , day   => 1);
my Date::Calendar::FrenchRevolutionary::Arithmetic $d-out-push;
my Date::Calendar::FrenchRevolutionary::Arithmetic $d-out-pull;

$d-out-push = $d-in.to-date("Date::Calendar::Arithmetic");
$d-out-pull .= new-from-date($d-in);

=end code

When converting I<from> Gregorian, use the pull style. When converting
I<to> Gregorian, use the push style. When converting from any calendar
other than Gregorian  to any other calendar other  than Gregorian, use
the style you prefer.

=head1 PROBLEMS AND KNOWN BUGS

The  validation  of  C<new>  parameters  is  very  basic.  Especially,
checking the day  number ignores the month value and  you can create a
date  with the  30th I<sans-culottide>  (additional day),  despite the
fact  that normal  and  leap  years have  respectively  only  5 and  6
additional days.

About  the  astronomical  variant:  the conversion  values  have  been
computed with an  algorithm implemented in Common Lisp.  There are two
problems with  this: First, the  conversion values have  been computed
for a period spanning 6 millenia,  although the algorithm is not valid
over  this  whole  period.  Second,  the  Common  Lisp  program  gives
different results when running under C<clisp> or C<gcl>. I do not know
yet the  reason. I  suppose it  is a rounding  error which  pushes the
autumn equinox to the wrong side of midnight, but it deserves a deeper
analysis.

=head1 SEE ALSO

=head2 Perl 5 Software

L<DateTime>

L<DateTime::Calendar::FrenchRevolutionary>
or L<https://github.com/jforget/DateTime-Calendar-FrenchRevolutionary>

L<Date::Convert::French_Rev> or L<https://github.com/jforget/Date-Convert-French_Rev>

L<Date::Converter>

=head2 Other Software

date(1), strftime(3)

F<calendar/cal-french.el>  in emacs-21.2  or later  or xemacs  21.1.8,
forked in L<https://github.com/jforget/emacs-lisp-cal-french>

L<https://www.gnu.org/software/apl/Bits_and_Pieces/calfr.apl.html> or L<https://github.com/jforget/apl-calendar-french>

L<https://www.hpcalc.org/details/7309> or L<https://github.com/jforget/hp48-hp50-French-Revolutionary-calendar>

L<https://github.com/jforget/hp41-calfr>

CALENDRICA 4.0 -- Common Lisp, which can be download in the "Resources" section of
L<https://www.cambridge.org/us/academic/subjects/computer-science/computing-general-interest/calendrical-calculations-ultimate-edition-4th-edition?format=PB&isbn=9781107683167>
(Actually, I have used the 3.0 version which is not longer available)

French Calendar for Android at
L<https://f-droid.org/packages/ca.rmen.android.frenchcalendar/>
or L<https://github.com/caarmen/FRCAndroidWidget>
and L<https://github.com/caarmen/french-revolutionary-calendar>

Thermidor for Android at L<https://github.com/jhbadger/Thermidor-Android>

A Ruby program at L<https://github.com/jhbadger/FrenchRevCal-ruby>

=head2 Books

Quid 2006, M and D Frémy, publ. Robert Laffont, page 341.

Agenda Républicain 197 (1988/89), publ. Syros Alternatives

Any French schoolbook about the French Revolution

The French Revolution, Thomas Carlyle, Oxford University Press

Calendrical Calculations (Third Edition) by Nachum Dershowitz and
Edward M. Reingold, Cambridge University Press, see
L<http://www.calendarists.com>
or L<https://www.cambridge.org/us/academic/subjects/computer-science/computing-general-interest/calendrical-calculations-ultimate-edition-4th-edition?format=PB&isbn=9781107683167>.

=head2 Internet

L<https://github.com/houseabsolute/DateTime.pm/wiki>

L<http://www.faqs.org/faqs/calendars/faq/part3/>

L<http://datetime.mongueurs.net/>

L<https://www.allhotelscalifornia.com/kokogiakcom/frc/default.asp>

L<https://en.wikipedia.org/wiki/French_Republican_Calendar>

L<https://fr.wikipedia.org/wiki/Calendrier_républicain>

L<https://archive.org/details/decretdelaconven00fran_40>

"Décret  du  4 frimaire,  an  II  (24  novembre  1793) sur  l'ère,  le
commencement et l'organisation de l'année et sur les noms des jours et
des mois"

L<https://archive.org/details/decretdelaconven00fran_41>

Same text, with a slightly different typography.

L<https://purl.stanford.edu/dx068ky1531>

"Archives parlementaires  de 1789 à  1860: recueil complet  des débats
législatifs & politiques  des Chambres françaises", J.  Madival and E.
Laurent, et. al.,  eds, Librairie administrative de  P. Dupont, Paris,
1912.

Starting with  page 6,  this document  includes the  same text  as the
previous links, with  a much improved typography.  Especially, all the
"long s"  letters have been replaced  by short s. Also  interesting is
the text  following the  decree, page 21  and following:  "Annuaire ou
calendrier pour la seconde année de la République française, annexe du
décret  du  4  frimaire,  an  II (24  novembre  1793)  sur  l'ère,  le
commencement et l'organisation de l'année et sur les noms des jours et
des mois". In the remarks above, it is refered as [Annexe].

L<https://gallica.bnf.fr/ark:/12148/bpt6k48746z>

[Fabre] "Rapport fait à la Convention nationale dans la séance du 3 du
second mois de la seconde année  de la République française, au nom de
la   Commission    chargée   de   la   confection    du   calendrier",
Philippe-François-Nazaire  Fabre  d'Églantine,  Imprimerie  nationale,
Paris, 1793

L<https://gallica.bnf.fr/ark:/12148/bpt6k49016b>

[Annuaire] "Annuaire  du cultivateur,  pour la  troisième année  de la
République  : présenté  le  30 pluviôse  de l'an  II  à la  Convention
nationale, qui en  a décrété l'impression et l'envoi,  pour servir aux
écoles  de la  République",  Gilbert Romme,  Imprimerie nationale  des
lois, Paris, 1794-1795

L<https://gallica.bnf.fr/ark:/12148/bpt6k43978x>

"Calendrier militaire,  ou tableau  sommaire des  victoires remportées
par les  Armées de  la République française,  depuis sa  fondation (22
septembre 1792),  jusqu'au 9  floréal an  7, époque  de la  rupture du
Congrès de Rastadt et de la reprise des hostilités" Moutardier, Paris,
An  VIII de  la République  française.  The source  of the  C<on_date>
method.

=head1 AUTHOR

Jean Forget <JFORGET at cpan dot org>

=head1 THANKS

Many  thanks to  all those  who were  involved in  Perl 6,  Rakudo and
Rakudo-Star.

Many thanks  to Andrew,  Laurent and C<brian>  for writing  books that
helped me learn Perl 6.

And some additional thanks to Laurent for  his help, even if I did not
apply all his advices.

=head1 COPYRIGHT AND LICENSE

Copyright 2019 Jean Forget, all rights reserved

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod
