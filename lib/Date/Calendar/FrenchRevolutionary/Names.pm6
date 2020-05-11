use v6.c;

unit module Date::Calendar::FrenchRevolutionary::Names:ver<0.0.6>;

  my %month-names = 'fr' => <Vendémiaire   Brumaire  Frimaire
                             Nivôse        Pluviôse  Ventôse
                             Germinal      Floréal   Prairial
                             Messidor      Thermidor Fructidor Sans-culottide>
                  , 'en' => Q :ww/Vintagearious Fogarious Frostarious
                                  Snowous       Rainous   Windous
                                  Buddal        Floweral  Meadowal
                                  Reapidor      Heatidor  Fruitidor 'additional day'/
  ;

  my %month-abbr   = 'fr' => <Vnd Bru Fri Niv Plu Vnt Ger Flo Pra Mes The Fru S-C>
                   , 'en' => <Vin Fog Fro Sno Rai Win Bud Flo Mea Rea Hea Fru S-C>
  ;

  # Décadi (day 10) is in position zero, because of the difference between the mathematical modulus
  # (which gives a 0..n-1 result) and the calendrical modulus (which gives a 1..n result)
  my %day-names  = 'fr' => <Décadi Primidi Duodi    Tridi   Quartidi Quintidi Sextidi Septidi  Octidi  Nonidi  >
                 , 'en' => <Tenday Firsday Seconday Thirday Fourday  Fifday   Sixday  Sevenday Eightday Nineday>;
                 ;
  my %day-abbr   = 'fr' => <Déc Pri Duo Tri Qua Qui Sex Sep Oct Non>
                 , 'en' => <Ten Fir Two Thi Fou Fif Six Sev Eig Nin>
                 ;

  my %feast = 'fr' => (
                   # Vendémiaire
                   Q :ww/
                      0raisin           0safran           1châtaigne        1colchique        0cheval
                      1balsamine        1carotte          2amaranthe        0panais           1cuve
                     '1pomme de terre'  2immortelle       0potiron          0réséda           2âne
                      1belle-de-nuit    1citrouille       0sarrasin         0tournesol        0pressoir
                      0chanvre          1pêche            0navet            2amarillis        0bœuf
                      2aubergine        0piment           1tomate           2orge             0tonneau
                   /,
                   # Brumaire
                   <
                      1pomme            0céleri           1poire            1betterave        2oie
                      2héliotrope       1figue            1scorsonère       2alisier          1charrue
                      0salsifis         1macre            0topinambour      2endive           0dindon
                      0chervis          0cresson          1dentelaire       1grenade          1herse
                      1bacchante        2azerole          1garance          2orange           0faisan
                      1pistache         0macjonc          0coing            0cormier          0rouleau
                   >,
                   # Frimaire
                   <
                      1raiponce         0turneps          1chicorée         1nèfle            0cochon
                      1mâche            0chou-fleur       0miel             0genièvre         1pioche
                      1cire             0raifort          0cèdre            0sapin            0chevreuil
                      2ajonc            0cyprès           0lierre           1sabine           0hoyau
                      2érable-sucre     1bruyère          0roseau           2oseille          0grillon
                      0pignon           0liège            1truffe           2olive            1pelle
                   >,
                   # Nivôse
                   Q :ww/
                      1tourbe           1houille          0bitume           0soufre           0chien
                      1lave            '1terre végétale'  0fumier           0salpêtre         0fléau
                      0granit           2argile           2ardoise          0grès             0lapin
                      0silex            1marne           '1pierre à chaux'  0marbre           0van
                     '1pierre à plâtre' 0sel              0fer              0cuivre           0chat
                      2étain            0plomb            0zinc             0mercure          0crible
                   /,
                   # Pluviôse
                   <
                      1lauréole         1mousse           0fragon           0perce-neige      0taureau
                      0laurier-thym     2amadouvier       0mézéréon         0peuplier         1coignée
                      2ellébore         0brocoli          0laurier          2avelinier        1vache
                      0buis             0lichen           2if               1pulmonaire       1serpette
                      0thlaspi          0thymelé          0chiendent        1traînasse        0lièvre
                      1guède            0noisetier        0cyclamen         1chélidoine       0traîneau
                   >,
                   # Ventôse
                   <
                      0tussilage        0cornouiller      0violier          0troène           0bouc
                      2asaret           2alaterne         1violette         0marceau          1bêche
                      0narcisse         2orme             1fumeterre        0vélar            1chèvre
                      3épinards         0doronic          0mouron           0cerfeuil         0cordeau
                      1mandragore       0persil           0cochléaria       1pâquerette       0thon
                      0pissenlit        1sylvie           0capillaire       0frêne            0plantoir
                   >,
                   # Germinal
                   <
                      1primevère        0platane          2asperge          1tulipe           1poule
                      1blette           0bouleau          1jonquille        2aulne            0couvoir
                      1pervenche        0charme           1morille          0hêtre            2abeille
                      1laitue           0mélèze           1ciguë            0radis            1ruche
                      0gainier          1romaine          0marronnier       1roquette         0pigeon
                      0lilas            2anémone          1pensée           1myrtille         0greffoir
                   >,
                   # Floréal
                   Q :ww/
                      1rose             0chêne            1fougère          2aubépine         0rossignol
                      2ancolie          0muguet           0champignon       1hyacinthe        0râteau
                      1rhubarbe         0sainfoin        "0bâton-d'or"      0chamérisier     '0ver à soie'
                      1consoude         1pimprenelle     "1corbeille-d'or"  2arroche          0sarcloir
                      0staticé          1fritillaire      1bourrache        1valériane        1carpe
                      0fusain           1civette          1buglosse         0sénevé           1houlette
                   /,
                   # Prairial
                   <
                      1luzerne          2hémérocale       0trèfle           2angélique        0canard
                      1mélisse          0fromental        0martagon         0serpolet         1faulx
                      1fraise           1bétoine          0pois             2acacia           1caille
                      2œillet           0sureau           0pavot            0tilleul          1fourche
                      0barbeau          1camomille        0chèvre-feuille   0caille-lait      1tanche
                      0jasmin           1verveine         0thym             1pivoine          0chariot
                   >,
                   # Messidor
                   <
                      0seigle           2avoine           2oignon           1véronique        0mulet
                      0romarin          0concombre        2échalotte        2absinthe         1faucille
                      1coriandre        2artichaut        1giroflée         1lavande          0chamois
                      0tabac            1groseille        1gesse            1cerise           0parc
                      1menthe           0cumin            3haricots         2orcanète         1pintade
                      1sauge            2ail              1vesce            0blé              1chalémie
                   >,
                   # Thermidor
                   <
                      2épeautre         0bouillon-blanc   0melon            2ivraie           0bélier
                      1prêle            2armoise          0carthame         1mûre             2arrosoir
                      0panis            0salicor          2abricot          0basilic          1brebis
                      1guimauve         0lin              2amande           1gentiane         2écluse
                      1carline          0caprier          1lentille         2aunée            1loutre
                      1myrte            0colza            0lupin            0coton            0moulin
                   >,
                   # Fructidor
                   Q :ww/
                      1prune            0millet           0lycoperde        2escourgeon       0saumon
                      1tubéreuse        0sucrion          2apocyn           1réglisse         2échelle
                      1pastèque         0fenouil          2épine-vinette    1noix             1truite
                      0citron           1cardère          0nerprun          0tagette          1hotte
                      2églantier        1noisette         0houblon          0sorgho           2écrevisse
                      1bigarade        "1verge-d'or"      0maïs             0marron           0panier
                   /,
                   # Jours complémentaires
                   <
                      1vertu            0génie            0travail          2opinion          3récompenses
                      1révolution
                   >
      )
     , 'en' => (
                   # Vendémiaire
                   Q :ww/
                     grape                saffron          "?sweet chestnut"      ?colchic        horse
                     balsam               carrot            amaranth              parsnip         vat
                     potato               everlasting       ?squash               mignonette      donkey
                    "four o'clock flower" pumpkin           buckwheat             sunflower       wine-press
                     hemp                 peach             turnip                amaryllis       ox
                     eggplant            "chili pepper"     tomato                barley          barrel
                   /,
                   # Brumaire
                   Q :ww/
                     apple                celery            pear                  beetroot        goose
                     heliotrope           fig              "black salsify"        ?whitebeam      plow
                     salsify             "water chestnut"  "jerusalem artichoke"  endive          turkey
                     skirret              cress             ?plumbago             pomegranate     harrow
                     ?bacchante           azarole           madder                orange          pheasant
                     pistachio           "tuberous pea"     quince               "service tree"   roller
                   /,
                   # Frimaire
                   Q :ww/
                     rampion              turnip            chicory               medlar          pig
                    "corn salad"          cauliflower       honey                 juniper         pickaxe
                     wax                  horseradish      "cedar tree"          "fir tree"      "roe deer"
                     gorse               "cypress tree"     ivy                  "savin juniper"  grub-hoe
                    "maple tree"          heather           reed                  sorrel          cricket
                    "pine nut"            cork              truffle               olive           shovel
                   /,
                   # Nivôse
                   Q :ww/
                     peat                 coal                      bitumen               sulphur         dog
                     lava                 topsoil                   manure                saltpeter       flail
                     granite              clay                      slate                 sandstone       rabbit
                     flint                marl                      limestone             marble         "winnowing basket"
                     gypsum               salt                      iron                  copper          cat
                     tin                  lead                      zinc                  mercury         sieve
                   /,
                   # Pluviôse
                   Q :ww/
                    "spurge laurel"       moss                     "butcher's broom"      snowdrop                bull
                     laurustinus         "tinder polypore"          mezereon             "poplar tree"            axe
                     hellebore            broccoli                  laurel               "common hazel"           cow
                    "box tree"            lichen                   "yew tree"             lungwort                billhook
                     penny-cress          daphne                   "couch grass"         "common knotgrass"       hare
                     woad                "hazel tree"               cyclamen              celandine               sleigh
                   /,
                   # Ventôse
                   Q :ww/
                     coltsfoot            dogwood                  "?hoary stock"         privet          billygoat
                    "wild ginger"        "mediterranean buckthorn"  violet               "goat willow"    spade
                     narcissus           "elm tree"                 fumitory             "hedge mustard"  goat
                     spinach             "leopard's bane"           pimpernel             chervil         line
                     mandrake             parsley                   scurvy-grass          daisy          "tuna fish"
                     dandelion            windflower               "maidenhair fern"     "ash tree"       dibble
                   /,
                   # Germinal
                   Q :ww/
                     primula             "plane tree"               asparagus       tulip           hen
                     chard               "birch tree"               daffodil        alder           hatchery
                     periwinkle           hornbeam                  morel          "beech tree"     bee
                     lettuce              larch                     hemlock         radish          hive
                     ?redbud             "roman lettuce"           "chestnut tree"  rocket          pigeon
                     lilac                anemone                   pansy           blueberry       dibber
                   /,
                   # Floréal
                   Q :ww/
                     rose                "oak tree"               fern            hawthorn        nightingale
                     columbine           "lily of the valley"     mushroom        hyacinth        rake
                     rhubarb              sainfoin                wallflower      ?chamerops      silkworm
                     comfrey              burnet                 "basket of gold" orache          hoe
                     ?statice             fritillary              borage          valerian        carp
                     spindletree          chive                   bugloss        "wild mustard"  "shepherd staff"
                   /,
                   # Prairial
                   Q :ww/
                     alfalfa              day-lily        clover          angelica        duck
                    "lemon balm"         "oat grass"      martagon       "wild thyme"     scythe
                     strawberry           betony          pea             acacia          quail
                     carnation           "elder tree"     poppy           lime            pitchfork
                     barbel               camomile        honeysuckle     bedstraw        tench
                     jasmine              vervain         thyme           peony           carriage
                   /,
                   # Messidor
                   Q :ww/
                     rye                  oats            onion           speedwell       mule
                     rosemary             cucumber        shallot         wormwood        sickle
                     coriander            artichoke       clove           lavender        chamois
                     tobacco              currant         vetchling       cherry          park
                     mint                 cumin           bean            alkanet        "guinea hen"
                     sage                 garlic          tare            corn            shawm
                   /,
                   # Thermidor
                   Q :ww/
                     spelt                mullein         melon           ryegrass        ram
                     horsetail            mugwort         safflower       blackberry     "watering can"
                     ?parsnip             glasswort       apricot         basil           ewe
                     marshmallow          flax            almond          gentian         waterlock
                    "carline thistle"     caper           lentil          horseheal       otter
                     myrtle              "oil-seed rape"  lupin           cotton          mill
                   /,
                   # Fructidor
                   Q :ww/
                     plum                 millet          lycoperdon      barley          salmon
                     tuberose             bere            dogbane         liquorice       stepladder
                     watermelon           fennel          barberry        walnut          trout
                     lemon                teasel          buckthorn       marigold       "harvesting basket"
                    "wild rose"           hazelnut        hops            sorghum         crayfish
                    "bitter orange"       goldenrod       corn            chestnut        basket
                   /,

                   # Jours complémentaires
                   <
                     virtue               engineering    labour          opinion          rewards
                     revolution
                   >
      );
  my %prefix = 'fr' => ('jour du ', 'jour de la ', "jour de l'", 'jour des ')
             , 'en' => ('day of ');

  our sub allowed-locale(Str:D $locale) {
    %month-names{$locale}:exists;
  }

  our sub month-name(Str:D $locale, Int:D $month --> Str) {
    %month-names{$locale}[$month - 1];
  }
  our sub month-abbr(Str:D $locale, Int:D $month --> Str) {
    %month-abbr{$locale}[$month - 1];
  }

  our sub day-name(Str:D $locale, Int:D $day --> Str) {
    %day-names{$locale}[$day % 10];
  }
  our sub day-abbr(Str:D $locale, Int:D $day --> Str) {
    %day-abbr{$locale}[$day % 10];
  }

  our sub feast(Str:D $locale, Int:D $month, Int:D $day --> Str) {
    my Str $raw-feast = %feast{$locale}[$month - 1][$day - 1];
    if $locale eq 'fr' {
      return $raw-feast.substr(1);
    }
    elsif $locale eq 'en' {
      if $raw-feast.substr(0,1) eq '?' {
        return $raw-feast.substr(1);
      }
      else {
        return $raw-feast;
      }
    }
  }

  our sub feast-long(Str:D $locale, Int:D $month, Int:D $day --> Str) {
    my Str $raw-feast = %feast{$locale}[$month - 1][$day - 1];
    if $locale eq 'fr' {
      return %prefix{$locale}[+ $raw-feast.substr(0,1)] ~  $raw-feast.substr(1);
    }
    elsif $locale eq 'en' {
      my Str $prefix = %prefix{$locale}[0];
      if $raw-feast.substr(0,1) eq '?' {
        return $prefix ~ $raw-feast.substr(1);
      }
      else {
        return $prefix ~ $raw-feast;
      }
    }
  }

  our sub feast-caps(Str:D $locale, Int:D $month, Int:D $day --> Str) {
    my Str $raw-feast = %feast{$locale}[$month - 1][$day - 1];
    if $locale eq 'fr' {
      return %prefix{$locale}[+ $raw-feast.substr(0,1)].tc ~  $raw-feast.substr(1).tc;
    }
    elsif $locale eq 'en' {
      my Str $prefix = %prefix{$locale}[0].tc;
      if $raw-feast.substr(0,1) eq '?' {
        return $prefix ~ $raw-feast.substr(1).tc;
      }
      else {
        return $prefix ~ $raw-feast.tc;
      }
    }
  }


=begin pod

=head1 NAME

Date::Calendar::FrenchRevolutionary::Names - French and English names for months, days, etc in the French Revolutionary calendar.

=head1 SYNOPSIS

=begin code :lang<perl6>

use Date::Calendar::FrenchRevolutionary;

=end code

=head1 DESCRIPTION

Date::Calendar::FrenchRevolutionary::Names  is a  companion module  to
Date::Calendar::FrenchRevolutionary,  giving  the French  and  English
names for months and days.

See the full documentation in the main module,
C<Date::Calendar::FrenchRevolutionary>.

=head1 AUTHOR

Jean Forget <JFORGET at cpan dot org>

=head1 COPYRIGHT AND LICENSE

Copyright © 2019, 2020 Jean Forget, all rights reserved

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod
