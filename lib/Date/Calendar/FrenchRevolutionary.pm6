use v6.c;

use Date::Calendar::Strftime;
use Date::Calendar::FrenchRevolutionary::Common;
use Date::Calendar::FrenchRevolutionary::Astronomical;
use Date::Calendar::FrenchRevolutionary::Arithmetic;

class    Date::Calendar::FrenchRevolutionary:ver<0.0.4>:auth<cpan:JFORGET>
    does Date::Calendar::FrenchRevolutionary::Common
    does Date::Calendar::Strftime {

  method BUILD(Int:D :$year, Int:D :$month, Int:D :$day, Str :$locale = 'fr') {
    $._chek-build-args($year, $month, $day, $locale, &vnd1);
    $._build-from-args($year, $month, $day, $locale);
  }
  # -24161 is MJD for 1792-09-22, which is the FR epoch
  method new-from-daycount(Int $count where  { $_ ≥ -24161 }) {
    my ($y, $m, $d) = $.elems-from-daycount($count, &vnd1);
    $.new(year => $y, month => $m, day => $d);
  }

  method vnd1 {
    vnd1($.year + 1791);
  }

  our sub vnd1(Int:D $year-gr --> Int) {
    # do not bother with the precise date in Vendémiaire / September of the switch from astronomical to arithmetic
    # these calendars differ in 1803 and 1840, but they coincidate during all the years between
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
my Date                                $Bonaparte's-coup-gr;
my Date::Calendar::FrenchRevolutionary $Bonaparte's-coup-fr;
$Bonaparte's-coup-gr .= new(1799, 11, 9);
$Bonaparte's-coup-fr .= new-from-date($Bonaparte's-coup-gr);
say $Bonaparte's-coup-fr;
# ---> "0008-02-18" for 18 Brumaire VIII
say "{.day-name} {.day} {.month-name} {.year} {.feast-long}" with  $Bonaparte's-coup-fr;
# ---> "Octidi 18 Brumaire 8 jour de la dentelaire"
say $Bonaparte's-coup-fr.strftime("%Y-%m-%d");
# ---> "0008-02-18" for 18 Brumaire VIII

=end code

Converting from a  French Revolutionary date to a Gregorian date

=begin code :lang<perl6>

use Date::Calendar::FrenchRevolutionary;
my Date::Calendar::FrenchRevolutionary $Robespierre's-downfall-fr;
my Date                                $Robespierre's-downfall-gr;
$Robespierre's-downfall-fr .= new(year => 2, month => 11, day => 9);
$Robespierre's-downfall-gr =  $Robespierre's-downfall-fr.to-date;
say $Robespierre's-downfall-gr;

=end code

=head1 DESCRIPTION

Date::Calendar::FrenchRevolutionary is  a class representing  dates in
the  French  Revolutionary  calendar.  It  allows  you  to  convert  a
Gregorian date into a French Revolutionary date or the other way.

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
C<Date::Calendar::>R<xxx> class with a C<daycount> method.

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

  feast       safran           saffron
  feast-long  jour du safran   day of saffron
  feast-caps  Jour du Safran   Day of Saffron

=head3 daycount

Convert the date to Modified Julian Day Number (a day-only scheme
based on 17 November 1858).

=head3 strftime

Work in progress.

This method is  very similar to the homonymous functions  you can find
in several  languages (C, shell, etc).  It also takes some  ideas from
C<printf>-similar functions. For example

=begin code :lang<perl6>

$df.strftime("%04d blah blah blah %-25B")

=end code

will give  the day number  padded on  the left with  2 or 3  zeroes to
produce a 4-digit substring, plus the substring C<" blah blah blah ">,
plus the month name, padded on the right with enough spaces to produce
a 25-char substring.  Thus, the whole string will be at least 42 chars
long. By  the way, you  can drop the  "at least" mention,  because the
longest month name  is 15-char long, so the padding  will always occur
and will always include at least 10 spaces.

The list of C<strftime> specifiers is given below.

=head2 Other Methods

=head3 to-date

Clones  the   date  into   a  core  class   C<Date>  object   or  some
C<Date::Calendar::>I<xxx> compatible calendar  class. The target class
name is given  as a positional parameter. This  parameter is optional,
the default value is C<"Date"> for the Gregorian calendar.

To convert a date from a  calendar to another, you have two conversion
styles,  a "push"  conversion and  a "pull"  conversion. For  example,
while converting from the astronomical  date "1 Vendémiaire IV" to the
arithmetic variant, you can code:

=begin code :lang<perl6>

use Date::Calendar::FrenchRevolutionary::Astronomical;
use Date::Calendar::FrenchRevolutionary::Arithmetic;

my  Date::Calendar::FrenchRevolutionary::Astronomical $d-orig;
my  Date::Calendar::FrenchRevolutionary::Arithmetic   $d-dest-push;
my  Date::Calendar::FrenchRevolutionary::Arithmetic   $d-dest-pull;

$d-orig .= new(year  => 4
             , month => 1
             , day   => 1);
$d-dest-push  = $d-orig.to-date("Date::Calendar::FrenchRevolutionary::Arithmetic");
$d-dest-pull .= new-from-date($d-orig);

=end code

When converting I<from> Gregorian, use the pull style. When converting
I<to> Gregorian, use the push style. When converting from any calendar
other than Gregorian  to any other calendar other  than Gregorian, use
the style you prefer.

=head2 C<strftime> specifiers

A C<strftime> specifier consists of:

=item A percent sign,

=item An  optional minus sign, to  indicate on which side  the padding
occurs. If the minus sign is present, the value is aligned to the left
and the padding spaces are added to the right. If it is not there, the
value is aligned to the right and the padding chars (spaces or zeroes)
are added to the left.

=item  An  optional  zero  digit,  to  choose  the  padding  char  for
right-aligned values.  If the  zero char is  present, padding  is done
with zeroes. Else, it is done wih spaces.

=item An  optional length, which  specifies the minimum length  of the
result substring.

=item  An optional  C<"E">  or  C<"O"> modifier.  On  some older  UNIX
system,  these  were used  to  give  the I<extended>  or  I<localized>
version  of  the date  attribute.  Here,  they rather  give  alternate
variants of the date attribute.

=item A mandatory type code.

The allowed type codes are:

=defn C<%a>

The abbreviated day of decade name.

=defn C<%A>

The full day of decade name.

=defn C<%b>

The abbreviated month name, or 'S-C' for additional days (abbreviation
of Sans-culottide, another name for these days).

=defn C<%B>

The full month name.

=defn C<%c>

The date-time, using the default format, as defined by the current locale.

=defn C<%d>

The day of the month as a decimal number (range 01 to 30).

=defn C<%e>

Like C<%d>, the  day of the month  as a decimal number,  but a leading
zero is replaced by a space.

=defn C<%f>

The month as a decimal number (1  to 13). Unlike C<%m>, a leading zero
is replaced by a space.

=defn C<%F>

Equivalent to %Y-%m-%d (the ISO 8601 date format)

=defn C<%G>

The year as a decimal number. Strictly similar to C<%L> and C<%Y>.

=defn C<%j>

The day of the year as a decimal number (range 001 to 366).

=defn C<%Ej>

The feast for the  day, in long format ("jour de  la pomme de terre").
Also available as C<%*>.

=defn C<%EJ>

The feast for  the day, in capitalised long format  ("Jour de la Pomme
de terre").

=defn C<%Oj>

The feast for the day, in short format ("pomme de terre").

=defn C<%L>

The year as a decimal number. Strictly similar to C<%G> and C<%Y>.

=defn C<%m>

The month as a two-digit decimal  number (range 01 to 13), including a
leading zero if necessary.

=defn C<%n>

A newline character.

=defn C<%t>

A tab character.

=defn C<%Y>

The year as a decimal number. Strictly similar to C<%G> and C<%L>.

=defn C<%Ey>

The year as a lowercase Roman number.

=defn C<%EY>

The year as a uppercase Roman  number, which is the traditional way to
write years when using the French Revolutionary calendar.

=defn C<%*>

The feast for the  day, in long format ("jour de  la pomme de terre").
Also available as C<%Ej>.

=defn C<%%>

A literal `%' character.

=head1 PROBLEMS AND KNOWN BUGS

About  the  astronomical  variant:  the conversion  values  have  been
computed  with an  algorithm  implemented  in Common  Lisp  on a  span
covering six millenia. This is a problem, because the algorithm is not
valid over this whole period. But I  have no idea when the common Lisp
program becomes inaccurate and generates  errors. As a pure guesswork,
I will suppose it will be rather accurate during five centuries or so.

=head2 TODO

Improve the error processing and the error messages.

Examine all methods to mark some as private.

The F<Date::Calendar::FrenchRevolutionary::Names> module should not be
a class, but a simple procedural package.

=head1 SEE ALSO

=head2 Raku Software

L<Date::Calendar::Strftime>
or L<https://github.com/jforget/raku-Date-Calendar-Strftime>

L<Date::Calendar::Hebrew>
or L<https://github.com/jforget/raku-Date-Calendar-Hebrew>

L<Date::Calendar::CopticEthiopic>
or L<https://github.com/jforget/raku-Date-Calendar-CopticEthiopic>

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
An  VIII de  la République  française.

=head1 AUTHOR

Jean Forget <JFORGET at cpan dot org>

=head1 THANKS

Many  thanks to  all those  who were  involved in  Perl 6,  Rakudo and
Rakudo-Star.

Many thanks to Andrew, Laurent,  C<brian> and Moritz for writing books
that helped me learn Perl 6.

And some additional thanks to Laurent for  his help, even if I did not
apply all his advices.

=head1 SUPPORT

You can  send me  a mail using  the address above.  Please be  sure to
include a subject  sufficiently clear and sufficiently  specific to be
green-flagged by my spam filter.

Or  you can  send a  pull request  to the  Github repository  for this
module.

=head1 COPYRIGHT AND LICENSE

Copyright © 2019, 2020 Jean Forget, all rights reserved

This library is  free software; you can redistribute  it and/or modify
it under the Artistic License 2.0.

=end pod
