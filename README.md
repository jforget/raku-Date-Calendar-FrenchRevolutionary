NAME
====

Date::Calendar::FrenchRevolutionary - Conversions from / to the French Revolutionary calendar

SYNOPSIS
========

Converting  a Gregorian  date  (e.g. 9th  November  1799) into  French
Revolutionary (18 Brumaire VIII).

```perl6
use Date::Calendar::FrenchRevolutionary;
my Date                                $Bonaparte's-coup-gr;
my Date::Calendar::FrenchRevolutionary $Bonaparte's-coup-fr;

$Bonaparte's-coup-gr .= new(1799, 11, 9);
$Bonaparte's-coup-fr .= new-from-date($Bonaparte's-coup-gr);
say $Bonaparte's-coup-fr.strftime("%A %e %B %Y");
```

Converting  a French  Revolutionary date  (e.g. 9th  Thermidor II)  to
Gregorian (which gives 27th July 1794).

```perl6
use Date::Calendar::FrenchRevolutionary;
my Date::Calendar::FrenchRevolutionary $Robespierre's-downfall-fr;
my Date                                $Robespierre's-downfall-gr;

$Robespierre's-downfall-fr .= new(year    =>  2
                                , month   => 11
                                , day     =>  9);
$Robespierre's-downfall-gr =  $Robespierre's-downfall-fr.to-date;
say $Robespierre's-downfall-gr;
```

INSTALLATION
============

```shell
zef install Date::Calendar::FrenchRevolutionary
```

or

```shell
git clone https://github.com/jforget/raku-Date-Calendar-FrenchRevolutionary.git
cd raku-Date-Calendar-FrenchRevolutionary
zef install .
```

DESCRIPTION
===========

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
months have exactly 3 décades, no more, no less.

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

AUTHOR
======

Jean Forget <JFORGET@cpan.org>

COPYRIGHT AND LICENSE
=====================

Copyright © 2019, 2020 Jean Forget, all rights reserved

This library is  free software; you can redistribute  it and/or modify
it under the Artistic License 2.0.

