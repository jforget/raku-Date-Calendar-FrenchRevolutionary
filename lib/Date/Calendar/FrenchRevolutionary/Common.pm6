use v6.c;
use Date::Calendar::FrenchRevolutionary::Names;
role Date::Calendar::FrenchRevolutionary::Common:ver<0.0.3>:auth<cpan:JFORGET> {

  has Int $.year  where { $_ ≥ 1 };
  has Int $.month where { 1 ≤ $_ ≤ 13 };
  has Int $.day   where { 1 ≤ $_ ≤ 30 };
  has Str $.locale is rw = 'fr';

  method _chek-build-args(Int $year, Int $month, Int $day, Str $locale, &vnd1-f) {

    unless 1 ≤ $month ≤ 13 {
      X::OutOfRange.new(:what<Month>, :got($month), :range<1..13>).throw;
    }

    if $month ≤ 12 {
      unless 1 ≤ $day ≤ 30 {
        X::OutOfRange.new(:what<Day>, :got($day), :range<1..30>).throw;
      }
    }

    else {
      # Checking the additional days (sans-culottides), within either the 1..5 range or the 1..6 range.
      my Int  $vnd1-before = vnd1-f($year + 1791);
      my Int  $vnd1-after  = vnd1-f($year + 1792);
      my Bool $is-leap     = False;

      # How does it work? We compute the September number of two successive "1 Vendémiaire"
      # dates. Then we compare the values and we check if the comparison is compatible with a
      # leap French Revolutionary year and with a leap Gregorian year.
      #
      # Examples
      #
      # French Rev year             3              4                5
      # Gregorian year before    1794           1795             1796
      # Gregorian year after     1795           1796             1797
      # $vnd1-before               22             23               22
      # $vnd1-after                23             22               22
      #
      # Check                 $v1-b < $v1-a  $v1-b > $v1-a   $v1-b == $v1-a
      # Duration between $v1-b and $v1-a
      # if normal greg year       366            364              365
      # if leap   greg year       367            365              366
      # if normal frv  year       365            365              365
      # if leap   frv  year       366            366              366
      #                             |              |                |
      # Conclusion                  |              |                `-- the Gregorian and French Revolutionary
      #                             |              |                    are both normal or they are both leap
      #                             |              `------------------- the Gregorian year is leap and the French
      #                             |                                   Revolutionary year is normal
      #                             `---------------------------------- the Gregorian year is normal and the French
      #                                                                 Revolutionary year is leap
      #
      # Remark: the Gregorian year checked for leapness / normality is the Gregorian year "after",
      # because the French Revolutionary includes the February month from the Greg year "after" but
      # not from the Greg year "before".

      if $vnd1-before < $vnd1-after {
        $is-leap = True;
      }
      elsif $vnd1-before == $vnd1-after {
        $is-leap = Date.new($year + 1792, 1, 1).is-leap-year;
      }

      if $is-leap {
        unless 1 ≤ $day ≤ 6 {
          X::OutOfRange.new(:what<Day>, :got($day), :range<1..6>).throw;
        }
      }
      else {
        unless 1 ≤ $day ≤ 5 {
          X::OutOfRange.new(:what<Day>, :got($day), :range<1..5>).throw;
        }
      }
    }
    if $locale ne 'fr' && $locale ne 'en' {
      X::Invalid::Value.new(:method<BUILD>, :name<locale>, :value($locale)).throw;
    }
  }

  method _build-from-args(Int $year, Int $month, Int $day, Str $locale) {
    $!year   = $year;
    $!month  = $month;
    $!day    = $day;
    $!locale = $locale;
  }

  method new-from-date($date) {
    $.new-from-daycount($date.daycount);
  }
  method elems-from-daycount(Int $count, $vnd1-f) {
    my Int $gr_year = floor($count/ 365) + 1860;
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

  method to-date($class = 'Date') {
    # See "Learning Perl 6" page 177
    my $d = ::($class).new-from-daycount($.daycount);
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

  method feast {
    Date::Calendar::FrenchRevolutionary::Names::feast($.locale, $.month, $.day);
  }

  method feast-long {
    Date::Calendar::FrenchRevolutionary::Names::feast-long($.locale, $.month, $.day);
  }

  method feast-caps {
    Date::Calendar::FrenchRevolutionary::Names::feast-caps($.locale, $.month, $.day);
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
which is shared by the three variants of the
Date::Calendar::FrenchRevolutionary class.

=head1 AUTHOR

Jean Forget <JFORGET at cpan dot org>

=head1 COPYRIGHT AND LICENSE

Copyright 2019 Jean Forget, all rights reserved

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod
