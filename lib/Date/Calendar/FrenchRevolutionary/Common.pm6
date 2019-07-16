use v6.c;
use Date::Calendar::FrenchRevolutionary::Names;
role Date::Calendar::FrenchRevolutionary::Common:ver<0.0.2>:auth<cpan:JFORGET> {

  has Int $.year  where { $_ ≥ 1 };
  has Int $.month where { 1 ≤ $_ ≤ 13 };
  has Int $.day   where { 1 ≤ $_ ≤ 30 };
  has Str $.locale is rw = 'fr';

  method new-from-date($date) {
    $.new-from-daycount($date.daycount);
  }
  method elems-from-daycount(Int $count, $vnd1-f) {
    my Int $gr_year = floor($count/ 365) + 1860	;
    my Int $vnd1_count = $count + 1;
    while $vnd1_count > $count {
      -- $gr_year;
      my Int  $fr_year = $gr_year - 1791;
      my Date $vnd1 .= new($gr_year, 9, $vnd1-f($gr_year));
      #my Date $vnd1 .= new($gr_year, 9, $.vnd1);
      $vnd1_count = $vnd1.daycount;
    }
    my $year  = $gr_year - 1791;
    my $month = 1 + floor(($count - $vnd1_count) / 30);
    my $day   = 31 + $count - $vnd1_count - 30 × $month;
    return $year, $month, $day;
  }
  method daycount {
    Date.new(year => $.year + 1791, month => 9, day => $.vnd1()).daycount
    + 30 × ($.month - 1)
    + $.day
    - 1;
  }

  method to-date() {
    my Date $d .= new-from-daycount($.daycount);
    return $d;
  }

  method gist {
    sprintf("%04d-%02d-%02d", $.year, $.month, $.day);
  }

  method month-name {
    Date::Calendar::FrenchRevolutionary::Names::month-name($.locale, $.month);
  }

  method month-abbr {
    Date::Calendar::FrenchRevolutionary::Names::month-abbr($.locale, $.month);
  }

  method day-name {
    Date::Calendar::FrenchRevolutionary::Names::day-name($.locale, $.day);
  }

  method day-abbr {
    Date::Calendar::FrenchRevolutionary::Names::day-abbr($.locale, $.day);
  }

}

=begin pod

=head1 NAME

Date::Calendar::FrenchRevolutionary::Common - Common code for the three variants of Date::Calendar::FrenchRevolutionary

=head1 SYNOPSIS

=begin code :lang<perl6>

use Date::Calendar::FrenchRevolutionary;

=end code

=head1 DESCRIPTION

Date::Calendar::FrenchRevolutionary is a module defining a role
which is shared by the three variants of the Date::Calendar::FrenchRevolutionary
class.

=head1 AUTHOR

Jean Forget <JFORGET at cpan dot org>

=head1 COPYRIGHT AND LICENSE

Copyright 2019 Jean Forget, all rights reserved

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod
