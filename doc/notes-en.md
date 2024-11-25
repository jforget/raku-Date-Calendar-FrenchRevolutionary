# -*- encoding: utf-8; indent-tabs-mode: nil -*-

Designer's Notes
================

Preliminary
-----------

It is better to work with  actual examples rather than generic values.
So in the text below, I will  use the following dates (Bastille day in
2019):

| Calendar                   |  Date                       |
|----------------------------|-----------------------------|
| English-speaking Gregorian |  Sunday 14 July 2019        |
| French-speaking Gregorian  |  Dimanche 14 juillet 2019   |
| Hebrew                     |  Yom Rishon 11 Tammuz 5779  |
| Hijri                      |  11 Dhu al-Qada 1440        |
| French Revolutionary       |  Sextidi 26 Messidor 227    |
| Coptic                     |  Tkyriakē 7 Epip 1735       |
| Ethiopic                   |  Segno 7 Ḥamle 2011         |
| Maya                       |  13.0.6.11.16, 8 Cib, 4 Xul |

Purposes
--------

The various calendar module should obey the following contradictory
purposes:

* A user can  use as many or as  few calendar as he wants.  He can use
none or all of them. Only the core module `Date` would be required.

* Limit code duplication. Prefer DRY (Don't Repeat Yourself) over WET
(Write Everything Twice).

* No alteration to the core modules, including `Date`.

First Idea: Roles Everywhere
----------------------------

My first idea was to make intensive  use of the novelty in Raku Object
Oriented   Programming,  roles.   Only  the   Gregorian  calendar   is
implemented  as a  class `Date`,  all  others are  roles to  `Date`.
Example:

```
  my Date $bastille-day does Date::Calendar::Hebrew
                        does Date::Calendar::Hijri
                        does Date::Calendar::FrenchRevolutionary
                        does Date::Calendar::Maya
            .= new(year => 2019, month => 7, day => 14);
```

The first problem is the conflict between the methods of the various roles.
If we use

```
  say $bastille-day.month-name
```

should we get `Tammuz`, `Dhu al-Qada` or `Messidor`?
Granted, after reading pages 226 and following of _Learning Perl 6_,
you can write;

```
  say $bastille-day.month-name( Date::Calendar::FrenchRevolutionary );
  # → Messidor
  say $bastille-day.month-name( Date::Calendar::Hebrew );
  # → Tammuz
```

but it is cumbersome.

The second problem is that the concept  of date is not the same across
different  civilizations.  The   Gregorian  and  French  Revolutionary
calendars use  midnight-to-midnight dates, while the  Hijri and Hebrew
calendars  (and others)  use  sunset-to-sunset dates.  The Julian  Day
Number calendar  (not to  be confused with  the Julian  calendar) uses
noon-to-noon dates. And  it is possible that some  other calendars use
sunrise-to-sunrise dates. So, while you can  equate 14 July 2019 to 26
Messidor 227,  you cannot equate it  to 11 Tammuz 5779.  Usually, date
conversion  programs  take   the  lazy  path  and   mention  in  their
documentation that the correspondance 14 July 2019 → 11 Tammuz 5779 is
valid only until sunset, but we can imagine a hubristic programmer who
would use two conversion routines  or add a `time-of-day` parameter to
the conversion routine to get either

```
  14 July 2019 → 11 Tammuz 5779
```

or

```
  14 July 2019 → 12 Tammuz 5779
```

With the Hebrew  calendar as a role, that would  not be possible, with
the Hebrew  calendar as  a class,  that would  be possible.  There are
still a few problems, but at least we are not painted out in a corner.

I found another  reason when writing the  French Revolutionary module.
While there are reasons to allow  negative years (or BC years) for the
Julian  and  Gregorian  calendars  (even  when  considering  that  the
Gregorian calendar took effect on 15 October 1582), there is no reason
to take into  account dates before the epochs of  the other calendars.
For example, the French Revolutionary calendar's epoch is 22 September
1792, so the 21 September 1792 object should not be allowed to use the
FrenchRevolutionary role's methods.

So the solution is: one calendar = one class.

Taking a look at `Date`
-----------------------

I did not bother to deal with times, so I will look at the `Date` core
module instead of `DateTime`.

### Day-Only Counting

The first  difference with Perl  5's `DateTime` is that  Raku's `Date`
uses the MJD or Modified Julian Day Number instead of _Rata Die_. Fine
with me.

### Immutability

A  second  difference with  Perl  5's  `DateTime`  is that  dates  are
immutable.  Why not?  It  does not  bother me.  Therefore  dates in  a
`Date::Calendar::`_Whatever_  module will  be immutable  too (but  see
below for multilingual distributions).

### Localization

Another difference with Perl 5 is that there is no provision for
localized string values: month names and the like. Maybe it was
thought that the main purpose of this module would be to manage
schedules, timetables and the like, for which we need the numerical
values of the days and months but not their localized string values.

For those interested in localized values, there is the zef module
`Date::Names`.

Simple Calendars
----------------

As a simple calendar example, I will consider the Hebrew Calendar.
In this discussion, simplicity is about the module architecture,
not the conversion algorithms. So, with this point of view, the
Hebrew calendar, with no variants, is a simple calendar.

### Calendar with one Locale

In my opinion, calendar modules will be used to display dates, not to
build schedules with them. I will keep the names in a separate module,
but this module will be within the distribution. For example, the
`Date::Calendar::Hebrew` distribution will include both the
`Date::Calendar::Hebrew` module and the
`Date::Calendar::Hebrew::Names` module.

So we will have:

```
  class    Date::Calendar::Hebrew
  routines Date::Calendar::Hebrew::Names
```

### Calendar with Several Locales

If there  are different  languages and  different localizations  for a
given calendar, I may put the mechanisms  and all the data in the same
`Date::Calendar::`_Whatever_`::Names`  module,  or I  may  separate
them with  the mechanisms  in `Date::Calendar::`_Whatever_`::Names`
and    the   data    in   `Date::Calendar::`_Whatever_`::Names::en`
`Date::Calendar::`_Whatever_`::Names::fr`,
`Date::Calendar::`_Whatever_`::Names::it`   and  others.   It  will
depend on the size.

Supposing we have the choice of Hebrew, Yiddish and Aramaic for Hebrew
dates, we would have either:

```
  class    Date::Calendar::Hebrew
  routines Date::Calendar::Hebrew::Names
```

or:

```
  class    Date::Calendar::Hebrew
  routines Date::Calendar::Hebrew::Names
  routines Date::Calendar::Hebrew::Names::he
  routines Date::Calendar::Hebrew::Names::yi
  routines Date::Calendar::Hebrew::Names::arc
```

(Sorry, there is no 2-char ISO 639 code for Aramaic, so I have to fall
back to the 3-char code.)

Another     point    with     multi-localization    is     that    the
`Date::Calendar::`_Whatever_ objects will have a `locale` attribute
and  this  attribute will  be  read-write.  The  year, month  and  day
attributes will still be readonly,  but the locale will be read-write.
So the object  is not fully immutable. Using  the French Revolutionary
calendar as an example, changing "Sextidi  26 Messidor 227, jour de la
sauge" into "Sixday 26 Reapidor 227,  day of sage" is just a skin-deep
cosmetic modification,  while changing "Sextidi 26  Messidor 227, jour
de la sauge" into  "Septidi 27 Messidor 227, jour de  l'ail" is a deep
modification of the date's inner self.

### Another Multilingual Calendar, The Julian Calendar

The structure for  the Julian calendar is very simple.  A first module
for the `Date::Calendar::Julian` class and a second one for the month
names and  the day names.  Of course, for  this second module,  I have
chosen an  already existing  one, Tom Browder's  `Date::Names` rather
than rewriting everything. The only  glitch, when compared with what I
wrote above, is that `Date::Names` has, partially, an object-oriented
interface. For  abbreviations, it is  a procedural interface,  but for
the  month  names  and  the  day   names  we  need  to  instantiate  a
`Date::Names` object.

I could have  created a `month-name` method and  a `day-name` method
which would have created on-the-fly  an instance of `Date::Names` and
which would discard it just  after, letting the garbage collector reap
it. But usually, the module user asks  both the month name and the day
name,  so  this  solution  is  not  optimal,  because  there  are  two
instantiated `Date::Names` objects where one would be enough.

I  could  have instantiated  a  `Date::Names`  object each  time  the
`locale` attribute is  updated. I have not done this  for two reasons
of dubious value. Firstly, I do not know how to trigger some code when
an object attribute  is updated. Secondly, if the  module user updates
the `locale`  attribute several times in  a row without asking  for a
month name or  a day name, several `Date::Names`  instances will have
been created and all of them except  the last one are useless. But why
would a programmer do this?

So  I  have decided  to  do  lazy  instantiation. When  the  `locale`
attribute  is  updated,   the  `Date::Calendar::Julian`  object  does
nothing special. Each time the program asks  for a month name or a day
name, the  `Date::Calendar::Julian` object  first checks  whether the
`Date::Names` class was instantiated  and whether it was instantiated
with  the   proper  value.   If  no,   the  object   instantiates  the
`Date::Names` class and caches the new object instance into a private
attribute `$!date-names`. It also stores the current value of `locale`
into   another    private   attribute,    `$!instantiated-locale`   or
`$!inst-loc`. Example

```
  code               $.locale  $!inst-loc  $!date-names
  $.locale = 'en'    en        empty       empty
  $.locale = 'fr'    fr        empty       empty
  $.locale = 'de'    de        empty       empty
  say $.month-name   de        empty → de  Date::Names::de.new
  say $.day-name     de        de          Date::Names::de
  $.locale = 'it'    it        de          Date::Names::de
  $.locale = 'en'    en        de          Date::Names::de
  say $.day-name     en        de → en     Date::Names::en.new
  say $.month-name   en        en          Date::Names::en
```

Since this  lazy instantiation method is  well in the Raku's  style, I
have not tried  to come back to the previous  solution of intercepting
updates of `$.locale` and instantiating `Date::Names`.

Calendars with variants
-----------------------

### French Revolutionary Calendar

There are two ways of computing the change of a year to the
next in the  French Revolutionary Calendar: either the first day
of the year is the autumn equinox, or the length of each year is 365
or 366 and computed with an algorithm similar to the Gregorian
algorithm. Historically, the  French Revolutionary Calendar began
with the astronomical rule and a reform to adopt the arithmetic rule
was scheduled for year XX (Gregorian year 1811).

So we can define three variants.

* the astronomical variant, where the first day is always on
the autumn equinox, even after year XX,

* the arithmetic variant, where the year length is computed
with Gregorian-like moduloes, event before year XX,

* and the historical variant, which takes into account
the year XX reform and the change of rule.

How does this translate in Raku?

A first idea is to define three different functions or methods to
translate an other date into French Revolutionary Calendar
and also three  different functions or methods to
translate an French Revolutionary date into another calendar.

This is a bad idea. What happens  if the other calendar has also three
variants,  like  the Maya  calendar?  Should  we define  9  functions/
methods for each direction?

A  second  idea is  defining  only  one  function  or method  in  each
direction, using a parameter giving which  variant to use. In the case
of  the French  Revolutionary →  Maya  conversion, we  would have  two
parameters,  the  `from_variant`   parameter  and  the  `to_variant`
parameter.  These parameters  would be  optional  and, in  the cas  of
variantless calendars, ignored.

This does not  work either. Suppose we want to  translate 22 September
1795 to French  Revolutionary using the astronomical  variant and then
back to Gregorian  using the arithmetic variant. The  first step would
result in "sextidi 6 sans-culottide  III" (sixth additional day, which
means  that this  is a  leap  year), and  the second  step would  fail
because according to  the arithmetic rule, year III is  a normal year,
with only 5 additional days.

A third possibility is adding a  `variant` attribute to the  French Revolutionary Calendar
class to keep track of the variant used when creating the date object.
In this cas, the "here and back again" conversion will no longer be able
to use two different variants. It will just add some code in the module
to dispatch between variants of the "French Revolutionary Calendar to
other" conversion functions. Not a problem to the module user, just some
more code to write for the module author / maintainer (me).

A fourth  possibility consists  in storing this  information not  in a
attribute,  but directly  in the  object's  metadata, I  mean, in  the
class. In other words, I define three different classes for the French
Revolutionary Calendar, one  per variant. With that, the  burden is no
longer  on  the  module  writer  / maintainer,  but  on  the  dispatch
mechanism  coded in  the Perl  6 interpreter.  Yet, the  three classes
would contain much duplicated code.  To prevent code duplication, this
code will  be written  in a role  used by the  three classes.  Thus we
have:

* Three classes

  *  Date::Calendar::FrenchRevolutionary (for the historical variant)
  *  Date::Calendar::FrenchRevolutionary::Astronomical
  *  Date::Calendar::FrenchRevolutionary::Arithmetic

* One role

  *  Date::Calendar::FrenchRevolutionary::Common

* One procedural module

  *  Date::Calendar::FrenchRevolutionary::Names

This is the possibility I have adopted.

Note that the shortest name is given to the main variant, which will
certainly be the most often used variant.

Actually, there is even a fifth possibility, which merges possibilities 3 and
4. Each one of the three classes has a `algorithm` method which returns
a constant result, which will be  `"historic"`, `"astronomical"`
or `"arithmetic"` depending on the class. If I think it can be useful,
I will switch to this possibility.

### Coptic and Ethiopic Calendars

The Coptic and Ethiopic calendars are very simple calendars, sharing a
common structure:

* 12 months of 30 days each
* followed by 5 or 6 additional days, called _epagomenal days_.

Leap years are years preceding a multiple of 4, or equal to 4 × n + 3,
no matter if they are near the end of a century or not.

There are two differences between these calendars:

* Obviously, months and days have different names.

* The conversion  with other calendars is not the  same. In other
words, the Gregorian date for Coptic 0001-01-01 is not the same as the
Gregorian date for Ethiopic 0001-01-01.

But there  are still  many common points,  which suggest  code sharing
between the two modules. So we will have:

* Two classes

  *  Date::Calendar::Coptic
  *  Date::Calendar::Ethiopic

* One role

  *  Date::Calendar::CopticEthiopic (no need to add `"::Common"`)

* Two procedural modules

  *  Date::Calendar::Coptic::Names
  *  Date::Calendar::Ethiopic::Names

The only remaining point is the  name of the distribution. There is no
reason  to call  it after  the Coptic  calendar while  belittleing the
Ethiopic calendar.  And vice-versa. So  the distribution name  will be
`Date::Calendar::CopticEthiopic`.

### Maya Calendar and Aztec Calendar

The case of  the Maya Calendar is similar to  the French Revolutionary
calendar, because there  are several ways to convert  dates between it
and the Gregorian calendar. It is also similar to the Coptic calendar,
because it shares  many mechanisms with the Aztec  calendar, just like
the Coptic calendar shares many mechanisms with the Ethiopic calendar.

Pedants  will  argue that  there  is  not  _one_ Maya  calendar,  but
_three_:

* the  long count, using  embedded cycles  of length 20  (with one
exception)  and   usually  displayed   in  a  dotted   notation,  e.g.
13.0.6.11.16

* the clerical calendar, or Tzolkin,  which combines a cycle of 13
numbers with a cycle of 20 names, e.g. 8 Cib

* the  common calendar,  or Haab, consisting  of 18  named months,
each with 20 numbered days, plus 5 additional days. E.g. 4 Xul

So the various date converters  deal with the "Maya calendars system",
with an  "s" to  "calendars", but to  streamline the  explanations, we
will talk about the Maya calendar (with no "s").

It  is the  same, only  simpler, with  the Aztec  calendar. This  is a
two-calendar system,  with a  clerical calendar,  or _tonalpohualli_,
similar to Tzolkin, and a  common calendar, or _xiupohualli_, similar
to Haab. Aztecs had nothing ressembling the Mayas' long count.

For the conversion from Gregorian (or other) to Aztec, there are three
opinions  from  the specialists:  the  Alfonso  Caso method,  with  or
without  H.B. Nicholson's  adjustment, or  Francisco Cortes's  method.
Here is a table showing how these methods work and differ.

```
  Gregorian        Caso               Caso          Francisco
             without Nicholson    with Nicholson      Cortes
  2019-09-26   17 Tititl          17 Tititl         20 Tititl
  2019-09-27   18 Tititl          18 Tititl          1 Nemontemi
  2019-09-28   19 Tititl          19 Tititl          2 Nemontemi
  2019-09-29   20 Tititl          20 Tititl          3 Nemontemi
  2019-09-30    1 Nemontemi        1 Izcalli         4 Nemontemi
  2019-10-01    2 Nemontemi        2 Izcalli         5 Nemontemi
  2019-10-02    3 Nemontemi        3 Izcalli         1 Izcalli
  2019-10-03    4 Nemontemi        4 Izcalli         2 Izcalli
  2019-10-04    5 Nemontemi        5 Izcalli         3 Izcalli
  2019-10-05    1 Izcalli          6 Izcalli         4 Izcalli
  ...
  2019-10-19   15 Izcalli         20 Izcalli        18 Izcalli
  2019-10-20   16 Izcalli          1 Nemontemi      19 Izcalli
  2019-10-21   17 Izcalli          2 Nemontemi      20 Izcalli
  2019-10-22   18 Izcalli          3 Nemontemi       1 Atlcahualo
  2019-10-23   19 Izcalli          4 Nemontemi       2 Atlcahualo
  2019-10-24   20 Izcalli          5 Nemontemi       3 Atlcahualo
  2019-10-25    1 Atlcahualo       1 Atlcahualo      4 Atlcahualo
```

A small reminder  about the French Revolutionary,  Coptic and Ethiopic
calendars:  the year  is  incremented after  the  last additional  day
(sans-culottide and epagomenal). So the month following the additional
days is  the first month of  the year and  is given the number  1. The
month just before these additional days  is the last month of the year
and receive the number 12.

Now,  in the  Aztec calendar,  which is  the first  month of  the year
Izcalli or Atlcahualo? And the last month, is it Tititl or Izcalli? So
I have decided to ignore  the "Caso with Nicholson adjustment" method,
Izcalli will always be month number  1 and Tititl will always be month
number 18. By  the way, Reingold and Dershowitz too  ignore the method
with  Nicholson's adjustment.  They  also ignore  Cortes' method,  but
there I differ from them.

How do  we correlate  the Maya  calendar to  the others?  Reingold and
Dershowitz  describe  two  rules, the  Goodman-Martinez-Thompson  rule
(which  they  implement) and  the  Spinden  rule  (which they  do  not
implement). Abigail's  module `Date::Maya` gives three  unnamed rules,
but we  recognize the  Goodman-Martinez-Thompson rule and  the Spinden
rule. We  find the same three  unnamed rules in Claus  Tøndering's FAQ
([https://www.tondering.dk/claus/cal/maya.php]).  The   FAMSI  website
([http://research.famsi.org/date_mayaLC.php]) suggest  eight different
rules. The default rule is the GMT  rule, which has nothing to do with
the     Greenwich      Mean     Time,     but      which     represent
Goodman-Martinez-Thompson.

At first,  I will implement the  three rules suggested by  Abigail and
Claus Tøndering  for the Maya calendar,  plus two rules for  the Aztec
calendar. Later, it  will still be possible to add  the five remaining
rules mentionned by the FAMSI. So we will have

* Five classes

  *  Date::Calendar::Maya implementing the Goodman-Martinez-Thompson rule

  *  Date::Calendar::Maya::Spinden implementing the Spinden rule

  *  Date::Calendar::Maya::Astronomical implementing the rule with the same name

  *  Date::Calendar::Aztec implementing the Alfonso Caso rule

  *  Date::Calendar::Aztec::Cortes implementing the Francisco Cortes rule

* Three roles

  *  Date::Calendar::MayaAztec (no need to add "::Common"), implementing the civil and clerical calendars

  *  Date::Calendar::Maya::Common implementing the long count and giving the aliases _Haab_ and _Tzolkin_ to the civil and clerical calendars

  *  Date::Calendar::Aztec::Common giving the aliases _xiupohualli_ and _tonalpohualli_  to the civil and clerical calendars

* Two procedural modules

  *  Date::Calendar::Maya::Names
  *  Date::Calendar::Aztec::Names

About Cyclic Calendars
----------------------

While most calendars have a year number ranging from 1 to the infinite
some calendars  have a cyclic  value. This is  the case with  the Maya
long count, with a cycle of about 7885 years (20 baktuns). This is the
case also with the Maya and the Aztec calendar rounds, with a cycle of
18980 days (about 52 years). This may be the case with other calendars
I have  not yet considered. So  we can convert _to_  these calendars,
but not _from_ them.

For the Maya long count, with its 7885-year cycle, the problem is more
theoretical than practical. The cycling means that day "0.0.0.0.0" can
be translated as -3113-08-11 (11 August  3114 BC) or as 4772-10-13 (or
13th October  4772 AD). But  usually, we use  dates in a  much shorter
interval.  So the  Maya module  may use  a conversion  algorithm which
gives dates in the -3113 .. 4772  range and nobody (or nearly so) will
complain. If  you try a round  trip Gregorian → Maya  → Gregorian, you
will have 10 August 3114 BC → 19.19.19.17.19 → 12 October 4772, or you
will have  13 October 4772  → 0.0.0.0.0 → 11  August 3114 BC.  But for
dates between these extrema, the round trip will work.

For the Maya and Aztec calendar rounds, the cycle length is a bit less
than 52 years, so people will  be affected by this problem. In version
0.0.1, the answer  for Maya dates was "why build  a date with calendar
round values,  when you can build  it with long count?"  and for Aztec
dates, it was "you can build an Aztec date with calendar round values,
but you will not be able to convert it to anything else".

Before examining  version 0.0.2 of  the Maya  Aztec module, here  is a
sidenote  about the  MJD (Modified  Julian  Day number)  in the  other
calendar modules.  Initially, my  intention was  to implement  the MJD
with a `daycount` _method_, which would compute the MJD each time it
was called. Then I realised it was more efficient to implement the MJD
as a  `daycount` _attribute_, stored  inside the object. No  need to
compute it if the date is created by conversion from another calendar,
and it needs  to be computed only  once if the date is  built from the
year, month and day values. This is  the way the MJD is implemented in
every calendar  module, except the  the Gregorian calendar (I  rely on
the  implementation  in  the  core   class  `Date`).  For  the  French
Revolutionary  calendar, the  `daycount` attribute  was added  only in
October 2024.

So I decided  to include a `daycount` attribute in  Aztec dates, which
allows conversions _from_  Aztec. How is this attribute  filled? For a
conversion to  Aztec, no  problem, just copy  the `daycount`  from the
source  date. For  building with  calendar  round values,  how do  you
compute an  inifinite number of  results when  you have at  most 18980
different  input combinations?  I have  taken a  idea I  have seen  in
Reingold and Dershowitz's  `calendar.l` and maybe elsewhere  (I do not
remember). The Lisp function (or the Raku constructor) receives one of
the 18980 combinations of calendar round values, plus a reference date
from another calendar  and it computes the date  matching the calendar
round values, _on or before_ the  reference date. I have used the same
idea for building  an Aztec date, except that "on  or before" does not
seem a natural  choice for me, so  I allow the user  to choose another
relation,  such  as  "on  or   after"  or  "nearest".  And  thanks  to
code-sharing, I implemented a similar  method to build Maya dates from
calendar round values.

About additional days
---------------------

When  I studied  the  Aztec calendar,  especially  the H.B.  Nicholson
adjustment, I compared with the way the additional days are dealt with
in the Coptic,  Ethiopic and French Revolutionary  calendars, to state
that the additional  days are always inserted at the  end of the year.
Actually, this is  false. The Baha'i calendar has 19  mois of 19 days,
plus  4  additional days  (Ayyám-i-Há)  during  a  normal year,  or  5
additional days during a leap  year. These additional days are located
between the next-to-last month (Mulk) and the last month (‘Alá’).

There is  a good  reason for  this peculiar  setup. In  the arithmetic
variant of the Baha'i calendar, the beginning of a year is computed so
it will happen  on the 21st March of the  Gregorian calendar, which is
more or less the spring equinox.  The rules for leap years ensure that
this coincidence  happens every year.  So here is the  equivalence for
the last days of February and for significant days in March:

| Normal Gregorian | Normal Baha'i | Leap Gregorian | Leap Baha'i  |
|------------------|---------------|----------------|--------------|
| 25 February      | 19 Mulk       | 25 February    | 19 Mulk      |
| 26 February      | 1 Ayyám-i-Há  | 26 February    | 1 Ayyám-i-Há |
| 27 February      | 3 Ayyám-i-Há  | 27 February    | 3 Ayyám-i-Há |
| 28 February      | 3 Ayyám-i-Há  | 28 February    | 3 Ayyám-i-Há |
|                  |               | 29 February    | 4 Ayyám-i-Há |
| 1 March          | 4 Ayyám-i-Há  | 1 March        | 5 Ayyám-i-Há |
| 2 March          | 1 ‘Alá’       | 2 March        | 1 ‘Alá’      |
| ...              | ...           | ...            | ...          |
| 20 March         | 19 ‘Alá’      | 20 March       | 19 ‘Alá’     |
| 21 March         | 1 Bahá (N+1)  | 21 March       | 1 Bahá (N+1) |

As you can see  in the table above, this smart  setup gives a constant
equivalence  between any  Gregorian day  and the  corresponding Baha'i
day. The only exceptions are 1st  March and 4 Ayyám-i-Há, which may be
associated with 5 Ayyám-i-Há and 29th February respectively.

With the use  of an astronomical rule based on  the real equinox date,
this beautifully quasi-constant equivalence is no longer assured.

Overhaul in November-December 2024
----------------------------------

Above,  I have  mentioned a  "hubristic  programmer" who  would add  a
`time-of-day`  parameter to  the  conversion  functions. Actually,  in
November  2024,  I   added  a  `daypart`  attribute   in  the  classes
`Date::Calendar::`_xxxx_.  Not only  we distinguish  the 14th  of July
2019 from the 15th of Juy 2019, but we also distinguish the "14th July
2019 before sunrise" from the "14th July 2019 during the daylight" and
from  the  "14th  July  after  sunset".  The  `daypart`  attribute  is
immutable, like the `daycount` attribute.

Thus, "14th July 2019 before sunrise" would convert to "11 Tammuz 5579
before sunrise"  and "14th  July 2019 daylight"  would convert  to "11
Tammuz  5579 daylight",  while  "14th July  2019  after sunset"  would
convert to "**12** Tammuz 5579 after sunset".

The three possible values for `daypart` are symbolised by the following three characters:

* `☾` or U+263E for the night time from midnight to sunrise, or `before-sunrise`,

* `☼` or U+263C for the daylight period, aptily called with `daylight`,

* `☽` or U+263D for the night time from sunset to midnight, called with `after-sunset`.

The  default  value  for   the  `daypart`  parameter  (or  attribute),
especially when a `Date::Calendar::`_xxx_ module with version 0.1.n is
interacting with a `Date::Calendar::`_yyy_  module with version 0.0.p,
is `daylight`. With this default  value, the conversions give the same
results as they did before the 2024 overhaul.

This  overhaul is  compatible with  calendars  in which  the days  are
defined as midnight-to-midnight, with the  calendars in which the days
are defined  as sunset-to-sunset  and with  the possible  calendars in
which  days are  sunrise-to-sunrise (Reingold  and Dershowitz  suppose
that the Haab  calendar is sunrise-to-sunrise). On the  other hand, if
the days  are defined as  noon-to-noon, they cannot be  processed with
this new architecture.  This applies only to the  _Julian Day Number_.
From my point of view, this calendar  is not interesting and I have no
plan to include it in my series of calendar modules. In addition, this
would  require two  different symbols  for `daylight-before-noon`  and
`daylight-after-noon`, instead of just `☼` (or U+263C).

Why the choice `☾` for the morning and `☽` for the evening? Because on
one hand  `☽` (U+263D)  is named  `FIRST QUARTER  MOON` and  the first
quarter is visible in the evening,  and on the other hand `☾` (U+263E)
is named  `LAST QUARTER MOON` and  the last quarter is  visible in the
morning.

In Hindsight
============

After having  implemented the calendars  mentioned above, I  find that
the architecture I have designed is a correct one. Not necessarily the
best one,  but good enough.  I am still  not sure about  splitting the
`Calendar::`_xxx_`::Names`  modules  from  the  corresponding  main
class `Calendar::`_xxx_, but it works.

But there  are things  I had  not foreseen, or  for which  my original
intention would have led to a bad design.

The first point is the `strftime` method. At first, I thought I would
have to write different, yet  similar, methods for each calendar, thus
trampling the  DRY principle. Then  I realised  that I could  write an
independent  role  with  just  this  method,  released  and  installed
separately from  the calendar classes,  and the various  classes would
just invoke  this role. All  I needed was to  define some kind  of API
with  common  names for  the  calendar  class  methods and  a  precise
structure for a dispatch table.

The other point I discovered while writing my modules is that it would
be a good idea to write a  Gregorian calendar module, even if there is
already  the  core class  `Date`.  Since  the  beginning, I  had  the
intention  to make  my  conversions methods  compatible with  `Date`,
hence the "push  style" and the "pull style". On  the other hand, even
after     defining    `strftime`     as    an     independant    role
`Date::Calendar::Strftime`,  I did  not  bother  to make  `strftime`
compatible with  `Date`. I  still made some  checks and  I discovered
that  by  writing a  few  additional  lines,  a programmer  could  use
`strftime` with standard dates and get at least the numerical values.
The alphabetic values (month names and day names) were still lacking.

If we want a complete support of `strftime` in `Date`, we must write
some  additional code,  especially a  `month-name` and  a `day-name`
methods, plus the management of  a new `locale` attribute. Instead of
requesting  every user  of  my  `Date::Calendar::Strftime` module  to
write  this additional  code, I  realised that  I could  write it  and
release it as  a new class `Date::Calendar::Gregorian`.  Of course, I
would follow  the DRY  principle and  my class  would inherit  all the
stuff of `Date`. I had only to add conversion methods, and getters to
give the month names and the day  names. Oh, and also tweak the `new`
methods  to allow  a `locale`  parameter which  would initialize  the
homonymous attribute. Well,  no, it was not  necessary. Fortunately, I
wrote the  tests before changing  the module.  I wrote the  tests, ran
them, and  I was  astonished (and  glad) to  see absolutely  no errors
where I expected a whole truckload of them. So calling a `new` method
from  the class  `Date`  with  a `locale`  parameter  would have  no
problems  at  all with  storing  this  parameter into  the  homonymous
atribute, without having to change a  line in the parent `Date` class
nor in the child `Date::Calendar::Gregorian` class.

License
=======

This  text is  licensed  under  the terms  of  Creative Commons,  with
attribution and share-alike (CC-BY-SA).
