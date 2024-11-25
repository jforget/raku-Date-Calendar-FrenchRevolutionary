# -*- encoding: utf-8; indent-tabs-mode: nil -*-

Notes du concepteur
===================

Préliminaire
------------

Il  est  préférable de  faire  référence  à  des exemples  plutôt  que
d'utiliser  des données  génériques. Pour  ce faire,  j'utiliserai les
dates suivantes (le 14 juillet 2019) :

```
  Dimanche 14 juillet 2019
  Sunday 14 July 2019
  Yom Rishon 11 Tammuz 5779
  11 Dhu al-Qada 1440
  Sextidi 26 Messidor 227
  Tkyriakē 7 Epip 1735
  Segno 7 Ḥamle 2011
  13.0.6.11.16, 8 Cib, 4 Xul
```

Buts
----

Les modules de calendrier doivent tendre vers ces buts contradictoires :

* Un  utilisateur peut  décider  de charger  autant  de modules  qu'il
souhaite. Il peut  tous les utiliser ou n'utiliser  aucun module outre
le module central `Date`.

* Limiter  autant que  possible  la duplication  de  code. Plutôt  DRY
(_Don't  Repeat  Yourself_,  Ne  vous répétez  pas)  que  WET  (_Write
Everything Twice_, Tout écrire deux fois).

* Ne pas toucher aux modules standards, y compris `Date`.

Première idée : des rôles partout
---------------------------------

Ma première idée était d'utiliser de manière intensive la nouveauté de
Raku en programmation  objet, les rôles. Seul  le calendrier grégorien
serait implémenté en tant que  classe, les autres calendriers seraient
des rôles accolés à la classe `Date`. Par exemple :

```
  my Date $quatorze-juillet does Date::Calendar::Hebrew
                            does Date::Calendar::Hijri
                            does Date::Calendar::FrenchRevolutionary
                            does Date::Calendar::Maya
            .= new(year => 2019, month => 7, day => 14);
```

Le premier problème est le conflit de nom entre les méthodes des
divers rôles. Si nous codons :

```
  say $quatorze-juillet.month-name
```

obtiendrons-nous `Tammuz`, `Dhu al-Qada`  ou `Messidor` ? D'accord, il
suffit de lire  la page 226 et  les suivantes de _Learning  Perl 6_ et
l'on apprend que l'on peut écrire :

```
  say $quatorze-juillet.month-name( Date::Calendar::FrenchRevolutionary );
  # → Messidor
  say $quatorze-juillet.month-name( Date::Calendar::Hebrew );
  # → Tammuz
```

Mais c'est laborieux.

Le second problème est que le concept  de date n'est pas le même d'une
civilisation  à  l'autre. Le  calendrier  grégorien  et le  calendrier
républicain  utilisent des  dates de  minuit  à minuit,  alors que  le
calendrier  hébraïque, le  calendrier  islamique  et plusieurs  autres
utilisent  des dates  du  coucher  du soleil  au  coucher suivant.  Le
_Julian Day Number_ (à ne pas  confondre avec le calendrier julien) se
base sur des dates de midi à  midi. Et il n'est pas exclu que d'autres
calendriers définissent les dates comme  s'étendant du lever du soleil
au lever suivant du soleil. On  peut donc assimiler le 14 juillet 2019
au 26  Messidor 227, mais pas  au 11 Tammuz 5579.  Habituellement, les
programmes de conversion s'en tirent en écrivant dans la documentation
utilisateur que  la conversion 14  juillet 2019  → 11 Tammuz  5779 est
valide  avant le  coucher  du  soleil. Mais  il  pourrait  y avoir  un
programmeur  un peu  plus  aventureux qui  coderait  deux routines  de
conversion ou qui  ajouterait un paramètre « moment de  la journée » à
sa routine de conversion pour obtenir soit :

```
  14 juillet 2019 → 11 Tammuz 5779
```

soit :

```
  14 juillet 2019 → 12 Tammuz 5779
```

En implémentant  le calendrier hébraïque  en tant que rôle  affecté au
calendrier   grégorien,  cette   possibilité  n'existerait   plus.  En
implémentant le  calendrier hébraïque en  tant que classe  séparée, la
possibilité reste ouverte.  Il reste des problèmes à  résoudre dans ce
cas, mais au moins nous ne sommes pas bloqués.

Pendant  que  j'écrivais le  module  de  calendrier républicain,  j'ai
trouvé  un argument  supplémentaire. L'utilisation  d'années négatives
(ou av J.C.) est justifiée pour  le calendrier julien et le calendrier
grégorien  (même en  considérant que  le calendrier  grégorien a  pris
effet  le 15  octobre  1582), ce  n'est  pas le  cas  pour les  autres
calendriers. Ainsi, le calendrier républicain a pour origine des temps
le  22 septembre  1792 et  il n'y  a alors  aucune raison  d'autoriser
l'objet 21 septembre 1792 à utiliser les méthodes du rôle « calendrier
républicain ».

La solution est donc : un calendrier = une classe.

Examen du module standard `Date`
--------------------------------

Je n'avais pas l'intention de traiter les heures (décimales ou 24×60×60)
donc je n'ai pas  regardé `DateTime`, seulement `Date`.

### Échelle de temps en jours

La première  différence entre le  module `Date`  de Raku et  le module
`DateTime` de Perl 5 est que Raku utilise le MJD (_Modified Julian Day
Number_) au lieu d'utiliser le _Rata Die_. Cela me va très bien.

### Immutabilité

Une deuxième différence avec le module `DateTime` de Perl 5, c'est que
les  dates ne  sont pas  modifiables.  Et pourquoi  pas ?  Cela ne  me
dérange pas. Donc les dates dans `Date::Calendar::`_xxx_ ne seront pas
modifiables.  Voir cependant  ci-dessous le  cas d'un  calendrier avec
plusieurs langues.

### Affichage en langage naturel

Une autre différence avec  Perl 5, c'est qu'il n'y a  rien de prévu en
standard pour  afficher du  langage naturel, essentiellement  les noms
des  jours  et  les  noms   des  mois.  Peut-être  a-t-on  estimé  que
l'utilisation  principale  du  module `Date`  serait  la  constitution
d'horaires ou la planification de tâches,  ce qui ne nécessite que les
valeurs numériques des jours et des mois, pas les noms en clair.

Et  si vous  avez quand  même besoin  des noms  en clair,  vous pouvez
installer et utiliser `Date::Names` disponible sur zef.

Calendrier simple
-----------------

Comme  exemple  de  calendrier   simple,  je  prendrai  le  calendrier
hébraïque. La  simplicité concerne  l'architecture du module,  pas les
algorithmes de conversion. Il n'y a pas de variante pour le calendrier
hébraïque, donc de ce point de vue c'est un calendrier simple.

### Calendrier avec une seule langue

À mon  avis, si quelqu'un  utilise un  module de calendrier  autre que
grégorien, c'est pour  afficher la date convertie, pas  pour faire des
calculs de  délai ou planifier  des tâches.  Les noms en  clair seront
dans un module séparé, mais ce module séparé fera partie intégrante de
la  distribution.  Ainsi,   la  distribution  `Date::Calendar::Hebrew`
incluera à  la fois  le module  `Date::Calendar::Hebrew` et  le module
`Date::Calendar::Hebrew::Names`.

En résumé, nous avons dans ce cas :

```
  classe   Date::Calendar::Hebrew
  routines Date::Calendar::Hebrew::Names
```

###  Calendrier avec plusieurs langues

Si les noms sont disponibles dans plusieurs langages pour un même
calendrier, je peux dans certains cas tout mettre dans un même module
`Date::Calendar::`_xxx_`::Names`, mécanisme et données, ou bien je
peux scinder cela en mettant le mécanisme dans
`Date::Calendar::`_xxx_`::Names` et les données dans
`Date::Calendar::`_xxx_`::Names::en`,
`Date::Calendar::`_xxx_`::Names::fr`,
`Date::Calendar::`_xxx_`::Names::it` et ainsi de suite. Tout dépendra
de la taille.

Pour le calendrier hébraïque, avec l'hébreu, le yiddish et l'araméen, cela donnerait :

```
  classe   Date::Calendar::Hebrew
  routines Date::Calendar::Hebrew::Names
  routines Date::Calendar::Hebrew::Names::he
  routines Date::Calendar::Hebrew::Names::yi
  routines Date::Calendar::Hebrew::Names::arc
```

(Désolé, l'araméen n'a pas de code  ISO 639 à deux caractères, j'ai dû
me rabattre sur le code à trois caractères.)

Un  autre  point est  que  dans  le  cas  où plusieurs  langages  sont
disponibles, l'objet `Date::Calendar::`_xxx_ aura un attribut `locale`
et l'utilisateur pourra alors faire  varier cet attribut pour afficher
une même  date dans  plusieurs langues. Même  si les  attributs année,
mois et jour sont invariants,  l'attribut `locale` sera modifiable. Et
l'objet ne sera  plus totalement « immutable ». En  prenant un exemple
tiré du  calendrier républicain,  changer «  Sextidi 26  Messidor 227,
jour de la sauge » en « Sixday  26 Reapidor 227, day of sage » est une
modification  cosmétique  et  superficielle  de  l'instance  de  date,
changer « Sextidi 26 Messidor 227 , jour de la sauge » en « Septidi 27
Messidor  227,  jour de  l'ail  »  est  une modification  profonde  de
l'instance touchant à son essence même.

### Autre calendrier multilingue, le calendrier julien

L'architecture  du calendrier  julien  est simple.  Un premier  module
classe `Date::Calendar::Julian` plus un module pour donner les noms de
mois  et de  jours. Évidemment,  pour  ce deuxième  module, j'ai  pris
`Date::Names` de T. Browder plutôt que  de tout réécrire. Le seul hic,
par rapport à ce que j'ai  écrit ci-dessus, c'est que `Date::Names` a,
en partie, une interface orientée  objet. Pour les abréviations, c'est
une bête procédure, mais pour les noms de jour et les noms de mois, il
faut instancier un objet de la classe `Date::Names`.

J'aurais pu créer  une méthode `month-name` et  une méthode `day-name`
qui, chacune,  instancient à la  volée un objet `Date::Names`  et qui,
une fois le nom de jour ou de mois obtenu, l'oublient et le laissent à
la merci  du ramasse-miettes  (_garbage collector_). Comme  en général
l'utilisateur demandera à  la fois le nom  du jour et le  nom du mois,
cette  solution   n'est  pas  fameuse,  l'objet   `Date::Names`  étant
instancié deux fois au lieu d'une.

J'aurais  pu   instancier  l'objet   `Date::Names`  chaque   fois  que
l'attribut `locale` est  modifié. J'ai deux arguments  contre, mais il
faut reconnaître que ces arguments sont médiocres. Tout d'abord, je ne
sais   pas  comment   déclencher   un   traitement  particulier   (ici
l'instanciation  d'un   `Date::Names`)  chaque  fois   qu'un  attribut
particulier (ici  l'attribut `locale`)  est modifié. Ensuite,  dans le
cas où  l'utilisateur de mon  module s'amuserait à  modifier plusieurs
fois de suite l'attribut `locale`, cela ferait autant d'instanciations
de `Date::Names`, toutes  inutiles sauf la dernière.  Mais pourquoi un
programmeur s'amuserait-il à modifier plusieurs  fois de suite le même
attribut ?

La solution  que j'ai  retenue consiste  en quelque  sorte à  faire de
l'instanciation paresseuse.  Chaque fois  que l'attribut  `locale` est
mis  à   jour,  l'objet  `Date::Calendar::Julian`  ne   fait  rien  de
particulier. Chaque fois que le programme  demande à l'objet un nom de
mois ou  de jour, l'objet `Date::Calendar::Julian`  vérifie si l'objet
`Date::Names` a  déjà été instancié  et s'il  a été instancié  avec la
bonne    valeur   de    `locale`.    Dans    la   négative,    l'objet
`Date::Calendar::Julian` instancie  la classe `Date::Names`  et stocke
cette  instance en  cache  dans  un attribut  privé  de l'instance  de
`Date::Calendar::Julian`. Il  stocke également  la valeur  actuelle de
`locale` dans un autre attribut privé, `instantiated-locale`. Exemple

```
  code               $.locale  $!inst-loc  $!date-names
  $.locale = 'en'    en        vide        vide
  $.locale = 'fr'    fr        vide        vide
  $.locale = 'de'    de        vide        vide
  say $.month-name   de        vide → de   Date::Names::de.new
  say $.day-name     de        de          Date::Names::de
  $.locale = 'it'    it        de          Date::Names::de
  $.locale = 'en'    en        de          Date::Names::de
  say $.day-name     en        de → en     Date::Names::en.new
  say $.month-name   en        en          Date::Names::en
```

Ce système d'instanciation paresseuse est  bien dans le style de Raku,
donc  je n'ai  pas cherché  à approfondir  la solution  précédente qui
aurait consisté  à intercepter les  mises à  jour de `$.locale`  et en
profiter pour instancier `Date::Names`.

Calendriers avec variantes
--------------------------

### Calendrier révolutionnaire

Pour le calendrier  révolutionnaire, il y a deux  façons de déterminer
le  passage d'une  année à  la suivante.  Ou bien  le premier  jour de
l'année correspond à l'équinoxe d'automne, ou bien on calcule la durée
de chaque  année, 365  ou 366  jours, avec  un algorithme  similaire à
celui  du calendrier  grégorien. Historiquement,  nous avons  commencé
avec la  règle astronomique et  une réforme  prévoyait de passer  à la
règle arithmétique en l'an XX.

Nous avons donc trois variantes.

* la variante  astronomique, basée uniquement sur  la détermination de
l'équinoxe d'automne, même après l'an XX,

* la  variante  arithmétique, qui  s'étend  sur  toute la  période  de
validité, y compris avant l'an XX,

* et  la variante  historique, qui  prend en  compte le  changement de
règle en l'an XX.

Comment cela se traduit-il en Raku ?

Une première  idée consiste à  prévoir trois fonctions  différentes de
conversion  vers   le  calendrier   républicain  et   trois  fonctions
différentes de conversion à partir du calendrier républicain.

Cela ne  tient pas la route.  Que se passe-t-il si  le calendrier d'en
face est  le calendrier maya,  qui a lui  aussi 3 variantes  ? Faut-il
définir 9 fonctions de conversion ?

Une  deuxième  possibilité consiste  à  ne  faire qu'une  fonction  de
conversion dans chaque sens, laquelle  admet un paramètre précisant la
variante. Ou, pour prévoir le cas de la conversion républicain → maya,
un  paramètre  donnant la  variante  du  calendrier  de départ  et  un
deuxième  paramètre  pour la  variante  du  calendrier d'arrivée.  Ces
paramètres  sont  facultatifs et  les  calendriers  sans variante  les
ignorent.

Cela  ne tient  pas  la route  non plus.  Imaginons  que l'on  veuille
convertir le 22 septembre 1795  vers le calendrier républicain avec la
variante   astronomique,  puis   en   sens  inverse   avec  la   règle
arithmétique. La  première étape donne  le « sextidi  6 sans-culottide
III » (pour  une année à 366  jours) et la deuxième  étape plante, car
avec la variante arithmétique, l'an III a 365 jours et le sixième jour
complémentaire est invalide.

Une troisième possibilité  consiste à ajouter un nouvel  attribut à la
date pour mémoriser  la variante utilisée à la création.  De la sorte,
l'aller-retour mentionné ci-dessus ne pourra pas se faire. Si une date
est créée en tant que date du calendrier astronomique, au moment de la
conversion  républicain  → grégorien  (ou  autre),  elle utilisera  la
méthode astronomique.  Le seul  problème est que  cela ajoute  du code
dans le module, pour tester à chaque conversion la méthode à utiliser.
Pas très  gênant pour l'utilisateur  du module, juste un  peu gonflant
pour le créateur et le mainteneur du module (moi).

Une quatrième  possibilité consiste  à mémoriser  la variante  non pas
dans un  attribut, mais  dans les  méta-informations de  l'objet. Plus
clairement,  créer  trois  classes   spécifiques  pour  le  calendrier
républicain, une classe par variante. Ainsi, ce n'est plus le créateur
/ mainteneur du  module qui doit tester la variante  à utiliser, c'est
le mécanisme  de dispatch inclus dans  l'interpréteur Raku. Toutefois,
il y a beaucoup de code similaire entre ces trois classes. Pour éviter
la duplication de ce code, il sera  écrit dans un rôle utilisé par les
trois classes. On a donc ainsi :

* Trois classes

  *  Date::Calendar::FrenchRevolutionary
  *  Date::Calendar::FrenchRevolutionary::Astronomical
  *  Date::Calendar::FrenchRevolutionary::Arithmetic

* Un rôle

  *  Date::Calendar::FrenchRevolutionary::Common

* Un module procédural

  *  Date::Calendar::FrenchRevolutionary::Names

C'est la possibilité que j'ai adoptée.

Notons que j'ai attribué le nom court à la variante principale, ce qui
sera vraisemblablement la plus utilisée.

Il existe  une cinquième  possibilité, fusionnant  la troisième  et la
quatrième. Chacune des trois  classes contient une méthode `algorithm`
donnant  un  résultat   constant,  `"historic"`,  `"astronomical"`  ou
`"arithmetic"`  selon le  cas. Si  j'en trouve  l'utilité, j'adopterai
cette cinquième possibilité.

### Calendrier copte et calendrier éthiopien

Le calendrier copte  et le calendrier éthiopien  sont deux calendriers
très simples, avec la même structure :

* 12 mois de trente jours
* suivis de 5 ou 6 jours complémentaires, dits « épagomènes ».

Les années bissextiles  sont les années précédant  une année divisible
par 4, c'est-à-dire de la forme 4  × n + 3, qu'il s'agisse d'années au
voisinage d'un changement de siècle ou non.

Il y a deux différences entre ces deux calendriers :

* de façon évidente, les noms des jours et des mois,

* et la  correspondance avec  les autres calendriers,  c'est-â-dire la
date (grégorienne par exemple) de la date copte 0001-01-01 et celle de
la date éthiopienne 0001-01-01.

Les  nombreuses  similitudes entre  les  deux  calendriers incitent  à
partager le code entre les deux modules.  Nous aurons ainsi :

* Deux classes

  *  Date::Calendar::Coptic
  *  Date::Calendar::Ethiopic

* Un rôle

  *  Date::Calendar::CopticEthiopic (à la réflexion, pas besoin d'ajouter « ::Common »)

* Deux modules procéduraux

  *  Date::Calendar::Coptic::Names
  *  Date::Calendar::Ethiopic::Names

Le seul point qui pose problème,  c'est le nom de la distribution.  Je
pense que le  meilleur nom, ou plutôt le moins  mauvais, serait un nom
qui ne  passe sous silence  ni le  calendrier copte, ni  le calendrier
éthiopien, c'est-à-dire `Date::Calendar::CopticEthiopic`.

### Calendrier maya et calendrier aztèque

Le  cas  du  calendrier  maya  est  semblable  au  cas  du  calendrier
républicain,  en  ce  qu'il  existe  plusieurs  façons  de  faire  les
conversions avec  le calendrier grégorien. Il  est également semblable
au cas du calendrier copte  parce qu'il partage de nombreux mécanismes
avec  le  calendrier  aztèque,  comme  le  calendrier  copte  avec  le
calendrier éthiopien.

Les  coupeurs de  cheveux  en  quatre diront  qu'il  n'y  a pas  _un_
calendrier maya, mais _trois_ :

* le compte  long, constitué de  cycles emboîtés de longueur  20 (avec
une exception)  et habituellement  affiché avec une  notation pointée,
par exemple 13.0.6.11.16,

* le  calendrier clérical,  ou Tzolkin,  qui  combine un  cycle de  13
nombres avec un cycle de 20 noms, par exemple 8 Cib,

* le calendrier profane, ou Haab, constitué  de 18 mois (nommés) de 20
jours (numérotés) plus 5 jours complémentaires, par exemple 4 Xul.

En  fait,  les programmes  de  conversion  traitent  le «  système  de
calendriers  mayas »  (avec un  « s  » à  « calendrier  »), mais  pour
alléger et fluidifier les phrases, nous nous permettons d'évoquer _le_
calendrier maya.

C'est la même chose, en plus simple, avec le calendrier aztèque. C'est
un   système  de   deux   calendriers,  le   calendrier  clérical   ou
_tonalpohualli_, semblable  au Tzolkin,  et le calendrier  profane, ou
_xiupohualli_,  semblable   au  Haab.  Les  Aztèques   n'avaient  rien
d'analogue au compte long des Mayas.

Pour  la  conversion  du  calendrier  grégorien  (ou  autre)  vers  le
calendrier aztèque, il  existe plusieurs avis différents  : la méthode
d'Alfonso  Caso, avec  ou sans  l'ajustement de  H.B. Nicholson  et la
méthode  de   Francisco  Cortes.   Voici  un   aperçu  de   ces  trois
correspondances.


```
  Grégorien        Caso               Caso          Francisco
               sans Nicholson     avec Nicholson      Cortes
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

Rappel sur les calendriers républicain, copte et éthiopien : on change
d'année  juste après  les  jours  complémentaires (sans-culottides  ou
épagomènes). Le mois  qui suit est le premier mois  de l'année, auquel
on attribue le numéro 1. Le mois qui précède ces jours complémentaires
est le dernier mois de l'année et prend le numéro 12.

Dans  le cas  du  calendrier  aztèque, quel  est  le  premier mois  de
l'année, Izcalli ou Atlcahualo ? Et  le dernier mois de l'année est-il
Tititl ou Izcalli  ? J'ai décidé de faire l'impasse  sur la méthode de
Caso avec l'ajustement  de Nicholson, ce qui  permettra d'attribuer le
numéro 1 à  Izcalli et le numéro 18 à  Tititl. Remarquons que Reingold
et Dershowitz  font eux aussi  l'impasse sur  la méthode de  Caso avec
l'ajustement de Nicholson.  Il font aussi l'impasse sur  la méthode de
Cortes, mais là je ne les suis plus.

Quelles sont les règles de correspondances entre le calendrier maya et
les  autres  calendriers ?  Reingold  et  Dershowitz mentionnent  deux
règles  : la  règle  de Goodman-Martinez-Thompson,  qu'ils ont  choisi
d'implémenter et  la règle de  Spinden, qu'ils n'implémentent  pas. Le
module `Date::Maya` d'Abigail donne trois règles sans les nommer, mais
il est  possible de reconnaître la  règle de Goodman-Martinez-Thompson
et    celle    de    Spinden.    La    FAQ    de    Claus    Tøndering
([https://www.tondering.dk/claus/cal/maya.php])  mentionne  les  mêmes
règles,  également   sans  les  nommer.   Et  le  site  de   la  FAMSI
([http://research.famsi.org/date_mayaLC.php])   propose  huit   règles
différentes. Par  défaut, c'est la  règle _GMT_,  qui n'a rien  à voir
avec  le _Greenwich  Mean Time_  (temps moyen  de Greenwich)  mais qui
s'interprête en « Goodman-Martinez-Thompson ».

Dans un premier temps, j'implémenterai  les trois règles proposées par
Abigail  et Claus  Tøndering.  Ultérieurement, pourquoi  pas, il  sera
possible d'ajouter les autres règles de la FAMSI. Nous aurons ainsi

* Cinq classes

  *  Date::Calendar::Maya implémentant la règle de Goodman-Martinez-Thompson

  *  Date::Calendar::Maya::Spinden implémentant la règle de Spinden

  *  Date::Calendar::Maya::Astronomical implémentant la règle du même nom de la FAMSI

  *  Date::Calendar::Aztec implémentant la règle d'Alfonso Caso

  *  Date::Calendar::Aztec::Cortes implémentant la règle de Francisco Cortès

* Trois rôles

  * Date::Calendar::MayaAztec (à la réflexion,  pas besoin d'ajouter «
::Common  »),  implémentant le  calendrier  profane  et le  calendrier
clérical

  * Date::Calendar::Maya::Common  implémentant   le  compte   long  et
attribuant les  synonymes _Haab_ et _Tzolkin_  aux calendriers profane
et clérical

  * Date::Calendar::Aztec::Common     attribuant     les     synonymes
_xiupohualli_ et _tonalpohualli_ aux calendriers profane et clérical

* Deux modules procéduraux

  *  Date::Calendar::Maya::Names
  *  Date::Calendar::Aztec::Names

### À Propos des Calendriers Cycliques

Alors que  la plupart  des calendriers  disposent d'un  numéro d'année
allant  de 1  jusqu'à l'infini,  certains calendriers  sont cycliques.
C'est le  cas avec le  compte long  maya, qui a  un cycle de  7885 ans
environ (20 baktuns). C'est le  cas également avec le _calendar round_
maya et le _calendar round_ aztèque,  qui ont un cycle de 18980 jours,
soit presque 52 ans. C'est  peut-être le cas pour d'autres calendriers
que je  n'ai pas encore  étudiés. Vous pouvez sans  problème convertir
des dates  _vers_ ces calendriers,  mais vous ne pouvez  pas convertir
des dates _à partir de_ ces calendriers.

Pour le compte long maya, le problème est plus théorique que pratique.
Le fonctionnement  cyclique signifie que  la date "0.0.0.0.0"  peut se
traduire par  -3113-08-11 (11 août 3114  av JC) ou par  4772-10-13 (13
octobre 4772). Mais habituellement, nous  nous intéressons à des dates
dans un intervalle nettement plus réduit. Donc le module de calendrier
maya utilise  un algorithme de  conversion se limitant  à l'intervalle
-3113 .. 4772 et quasiment personne  ne s'en plaindra. Si vous essayez
un aller-retour  Grégorien → Maya  → Grégorien, vous pourrez  avoir 10
août 3114 av JC → 19.19.19.17.19 → 12 octobre 4772 ou alors 13 octobre
4772 → 0.0.0.0.0 →  11 août 3114 av JC. Mais pour  les dates entre ces
dates extrêmes, l'aller-retour fonctionnera.

Pour le _calendar round_, tant aztèque que maya, la durée du cycle est
légèrement inférieure à  52 ans, donc les  utilisateurs seront touchés
par le problème.  Dans la version 0.0.1, la réponse  pour le _calendar
round_ maya était  « Pourquoi utiliser le _calendar  round_, alors que
le compte  long fonctionne ?  » et  pour le _calendar  round_ aztèque,
c'était « D'accord, vous pourrez  construire une date avec les valeurs
du _calendar  round_, mais vous ne  pourrez pas la convertir  en autre
chose. ».

Avant d'examiner la version 0.0.2  du module Maya-Aztèque, faisons une
parenthèse pour  examiner le MJD  (_Modified Julian Day  number_) dans
les autres modules de calendrier.  À l'origine, c'était implémenté par
une _méthode_ `daycount`  qui recalcule le MJD à  chaque invocation en
fonction de l'année, du mois et du  jour. Puis je me suis rendu compte
qu'il  était plus  judicieux d'implémenter  le MJD  par un  _attribut_
`daycount` stocké dans  l'instance de date. Pas besoin  de le calculer
si la date est créée par  conversion d'une date d'un autre calendrier,
et le  calcul se fera une  fois et une seule  si la date est  créée en
fournissant l'année, le mois et le jour. C'est ainsi que cela se passe
dans  tous  les  autres  modules de  calendrier,  sauf  le  calendrier
républicain  pour lequel  j'ai oublié  de  le faire  et le  calendrier
grégorien  parce  que je  repose  sur  l'implémentation de  la  classe
standard `Date`.

J'ai donc décidé d'ajouter un  attribut `daycount` aux dates aztèques,
ce qui permet  de convertir _à partir_ du  calendrier aztèque. Comment
cet  attribut est-il  alimenté ?  Pour une  date créée  par conversion
d'une  date d'un  autre calendrier,  c'est simplissime,  il suffit  de
recopier la  valeur de `daycount`  provenant de la date  origine. Pour
une date  créée à partir des  valeurs du _calendar round_,  c'est plus
délicat, car il  n'y a que 18980 combinaisons possibles  de valeurs du
_calendar round_  et le calcul est  censé fournir un nombre  infini de
valeurs.  Je me  suis  inspiré d'une  idée que  j'ai  trouvée dans  le
fichier  `calendar.l`  de Reingold  et  Dershowitz  et peut-être  dans
d'autres sources (je ne me souviens  plus très bien). La fonction lisp
(ou le constructeur Raku) reçoit  l'une des 18980 combinaisons valides
du _calendar  round_, plus une date  de référence et calcule  alors la
valeur correspondant au  _calendar round_ et située _en  même temps ou
avant_  la date  de  référence.  J'ai utilisé  le  même principe  pour
construire une date aztèque, sauf  que le paramètre `on-or-before` (en
même temps  ou avant) ne me  paraît pas très naturel,  donc j'ai admis
des  variantes  comme  `on-or-after`  (en  même  temps  ou  après)  ou
`nearest`  (au  plus  proche).  Et  grâce au  partage  de  code,  j'ai
implémenté  un constructeur  similaire pour  créer des  dates mayas  à
partir des valeurs du _calendar round_.

Après Coup
==========

Finalement, l'architecture  que j'ai imaginée  il y a quelques  mois a
l'air de  tenir la route.  Ce n'est  pas forcément la  meilleure, mais
elle convient. J'ai un léger doute sur la séparation entre les modules
annexes  `Date::Calendar::`_xxx_`::Names`  et les  modules  principaux
`Date::Calendar::`_xxx_.

Mais j'ai eu  des surprises, des points auxquels je  n'avais pas pensé
ou pour lesquels j'avais envisagé une autre solution, moins élégante.

Le premier point est la méthode  `strftime`. Au début, je pensais être
obligé  de la  dupliquer  d'un  module à  l'autre,  bafouant ainsi  le
principe _DRY_. Et puis un jour, j'ai réalisé que je pouvais très bien
écrire un  role indépendant,  installable séparément et  appelable par
les  différents calendriers.  Il  suffisait  juste d'adopter  quelques
conventions, notamment  sur les noms  de méthodes et sur  la structure
d'une table de dispatch.

L'autre  point que  je n'avais  pas prévu,  c'est que  parmi tous  les
modules que  j'écrirais, il y  aurait le calendrier grégorien.  Dès le
début, les  conversions vers  la classe  `Date` ou  à partir  de cette
classe  étaient  prévues. En  revanche,  lorsque  j'ai écrit  le  rôle
`Date::Calendar::Strftime`,   dans    ma   première   idée,    il   ne
s'appliquerait pas  à la  classe `Date`.  Puis après  quelques essais,
j'ai  constaté  qu'avec   quelques  instructions  supplémentaires,  un
programmeur pouvait coller ce rôle à la classe `Date` et bénéficier au
moins de l'affichage des données numériques, même si ce n'était pas le
cas pour les données alphabétiques (noms des jours et des mois).

Si l'on  veut un support  complet de  `strftime` dans `Date`,  il faut
écrire un  peu plus  de code, notamment  les méthodes  `month-name` et
`day-name`  et  gérer un  nouvel  attribut  `locale` pour  changer  si
nécessaire de langage.  Donc, au lieu de laisser  à chaque programmeur
le soin d'écrire  ces nouvelles méthodes, j'ai réalisé  que je pouvais
le faire à leur place, en créant _mon_ module de calendrier grégorien.
Pour créer  ce module, bien sûr,  je respecte le principe  _DRY_ et je
déclare que ma classe  `Date::Calendar::Gregorian` hérite de la classe
standard `Date`.  Je n'avais  plus qu'à  ajouter un  attribut `locale`
ainsi que quelques méthodes pour les conversions de date et pour avoir
les noms des mois  et de jours. Et réécrire les  méthodes `new` pour y
inclure le  nouvel attribut  `locale`. Éh bien  non, ce  dernier point
n'était même pas nécessaire. Heureusement,  j'ai écrit les tests avant
d'adapter le module. J'ai écrit les tests,  je les ai exécutés et à ma
grande  stupeur, il  n'y  a  eu aucune  erreur  là  où j'en  attendais
beaucoup.  Ainsi,  l'appel  d'une  méthode  `new`  avec  le  paramètre
`locale`  permet d'alimenter  l'attribut  homonyme  sans avoir  besoin
d'écrire quoi que ce soit dans la classe mère `Date` ou dans la classe
fille `Date::Calendar::Gregorian`.

Licence
=======

Texte  diffusé  sous  la  licence CC-BY-SA  :  Creative  Commons  avec
attribution, partage dans les mêmes conditions.
