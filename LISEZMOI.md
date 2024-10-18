NOM
===

Date::Calendar::FrenchRevolutionary - Conversions depuis / vers le calendrier républicain

SYNOPSIS
========

Conversion d'une date  grégorienne (p.ex. le 9 novembre  1799) vers le
calendrier républicain (18 Brumaire VIII).

```perl6
use Date::Calendar::FrenchRevolutionary;
my Date                                $coup-d'État-gr;
my Date::Calendar::FrenchRevolutionary $coup-d'État-fr;

$coup-d'État-gr .= new(1799, 11, 9);
$coup-d'État-fr .= new-from-date($coup-d'État-gr);
say $coup-d'État-fr.strftime("%A %e %B %Y");
```

Conversion  d'une date  républicaine (p.ex.  9 Thermidor  II) vers  le
calendrier grégorien (soit le 27 juillet 1794).

```perl6
use Date::Calendar::FrenchRevolutionary;
my Date::Calendar::FrenchRevolutionary $chute-de-Robespierre-fr;
my Date                                $chute-de-Robespierre-gr;

$chute-de-Robespierre-fr .= new(year    =>  2
                                , month   => 11
                                , day     =>  9);
$chute-de-Robespierre-gr =  $chute-de-Robespierre-fr.to-date;
say $chute-de-Robespierre-gr;
```

INSTALLATION
============

```shell
zef install Date::Calendar::FrenchRevolutionary
```

ou bien

```shell
git clone https://github.com/jforget/raku-Date-Calendar-FrenchRevolutionary.git
cd raku-Date-Calendar-FrenchRevolutionary
zef install .
```

DESCRIPTION
===========

Date::Calendar::FrenchRevolutionary  est  une   classe  permettant  de
représenter des dates  dans le calendrier républicain.  La classe vous
permet  de   convertir  une   date  grégorienne  vers   le  calendrier
républicain ou inversement.

Le calendrier républicain a été officiellement utilisé en France du 24
novembre 1793  (4 Frimaire  II) jusqu'au 31  décembre 1805  (10 Nivôse
XIV).  Les  modules  de  cette distribution  étendent  la  période  de
validité du  calendrier républicain jusqu'à l'époque  actuelle et même
quelques  siècles dans  le  futur, au  lieu de  la  limiter à  l'année
grégorienne 1805.

Ce  nouveau  calendrier  était  une  tentative  d'appliquer  la  règle
décimale (sur  laquelle se  base le  système métrique)  au calendrier.
Ainsi, la  semaine a disparu, remplacée  par la décade (10  jours). De
plus, tous les mois ont exactement 3 décades, ni plus, ni moins.

Étant donné que 12 mois de 30  jours ne donnent pas une année complète
(365,24 jours), l'année se termine  avec 5 ou 6 jours complémentaires.
Ces jours sont appelés "sans-culottides", mais on trouve assez souvent
également l'appellation plus simple "jours complémentaires". Ces jours
ne font  partie d'aucun  mois, mais  pour simplifier  la programmation
nous  considérerons qu'ils  constituent  un mois  numéro  13 de  durée
abrégée.

Au  début,  le changement  d'année  était  prévu pour  coïncider  avec
l'équinoxe d'automne. Il y avait pour cela deux raisons. Tout d'abord,
la  République  a  été  proclamée  le 22  septembre  1792,  qui  était
justement l'équinoxe d'automne de  cette année-là. Ensuite, l'équinoxe
est un bon symbole pour l'égalité,  puisqu'à cette date, le jour et la
nuit durent  chacun exactement  12 heures.  L'équinoxe était  ainsi en
accord avec la devise de la République, « Liberté, Égalité, Fraternité
». Mais cette règle s'est révélée peu pratique, c'est pourquoi Gilbert
Romme a proposé une autre  règle basée sur l'arithmétique, similaire à
celle du calendrier grégorien.

La  distribution  fournit deux  autres  classes,  la première  faisant
l'hypothèse que la réforme de Gilbert  Romme n'a jamais eu lieu et que
la  règle de  l'équinoxe est  restée  en vigueur,  la seconde  faisant
l'hypothèse que  la règle arithmétique a  été mise en pratique  dès le
début du calendrier républicain en septembre 1792.


AUTEUR
======

Jean Forget <J2N-FORGET at orange dot fr>

COPYRIGHT ET LICENCE
====================

Copyright © 2019, 2020, 2024 Jean Forget, tous droits réservés.

Ce code constitue du logiciel libre. Vous pouvez le redistribuer et le
modifier  en accord  avec  la  « licence  artistique  2.0 »  (Artistic
License 2.0).

