NAME
====

Date::Calendar::FrenchRevolutionary - Conversions from / to the French Revolutionary calendar

SYNOPSIS
========

```perl6
use Date::Calendar::FrenchRevolutionary;
my Date                                $Bonaparte's-coup-gr .= new(1799, 11, 9);
my Date::Calendar::FrenchRevolutionary $Bonaparte's-coup-fr .= new-from-date($Bonaparte's-coup-gr);
say $Bonaparte's-coup-fr;
my Date::Calendar::FrenchRevolutionary $Robespierre's-downfall-fr .= new(year    =>  2
                                                                       , month   => 11
                                                                       , day     =>  9);
my Date                                $Robespierre's-downfall-gr =  $Robespierre's-downfall-fr.to-date;
say $Robespierre's-downfall-gr;
```

DESCRIPTION
===========

Date::Calendar::FrenchRevolutionary is ...

AUTHOR
======

Jean Forget <JFORGET@cpan.org>

COPYRIGHT AND LICENSE
=====================

Copyright 2019 Jean Forget, all rights reserved

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

