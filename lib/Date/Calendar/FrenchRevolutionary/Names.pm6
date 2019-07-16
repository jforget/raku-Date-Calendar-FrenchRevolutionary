use v6.c;
class Date::Calendar::FrenchRevolutionary::Names:ver<0.0.2> {

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

}

=begin pod

=head1 NAME

Date::Calendar::FrenchRevolutionary::Names - French and English names for months, days, etc in the French Revolutionary calendar.

=head1 SYNOPSIS

=begin code :lang<perl6>

use Date::Calendar::FrenchRevolutionary;

=end code

=head1 DESCRIPTION

Date::Calendar::FrenchRevolutionary::Names  is  a companion  class  to
Date::Calendar::FrenchRevolutionary,  giving  the French  and  English
names for months and days.

=head1 AUTHOR

Jean Forget <JFORGET at cpan dot org>

=head1 COPYRIGHT AND LICENSE

Copyright 2019 Jean Forget, all rights reserved

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod
