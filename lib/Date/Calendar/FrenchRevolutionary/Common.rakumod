use v6.d;
use Date::Calendar::FrenchRevolutionary::Names;
unit role Date::Calendar::FrenchRevolutionary::Common:ver<0.1.0>:auth<zef:jforget>:api<1>;

has Int $.year  where { $_ ≥ 1 };
has Int $.month where { 1 ≤ $_ ≤ 13 };
has Int $.day   where { 1 ≤ $_ ≤ 30 };
has Int $.daycount;
has Str $.locale is rw where { Date::Calendar::FrenchRevolutionary::Names::allowed-locale($_) } = 'fr';

method !check-build-args(Int $year, Int $month, Int $day, Str $locale, &vnd1-f) {

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
  unless Date::Calendar::FrenchRevolutionary::Names::allowed-locale($locale) {
    X::Invalid::Value.new(:method<BUILD>, :name<locale>, :value($locale)).throw;
  }
}

method !build-from-args(Int $year, Int $month, Int $day, Str $locale) {
  $!year     = $year;
  $!month    = $month;
  $!day      = $day;
  $!locale   = $locale;
  $!daycount = $.daycount-from-elems;
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
    $vnd1_count = $vnd1.daycount;
  }
  my $year  = $gr_year - 1791;
  my $month = 1 + floor(($count - $vnd1_count) / 30);
  my $day   = 31 + $count - $vnd1_count - 30 × $month;
  return $year, $month, $day;
}
method daycount-from-elems {
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

method day-of-year {
  $.day + 30 × ($.month - 1);
}

method décade-number {
  ($.day / 10).ceiling + 3 × ($.month - 1);
}

method day-of-décade {
  $.day % 10 || 10;
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
method year-roman {
  my $res = '';
  my $n = $.year;
  if 1 ≤ $n ≤ 3999 {
    for (                                       (2000, 'MM'), (1000, 'M'),
          (900, 'CM'), (500, 'D'), (400, 'CD'), ( 200, 'CC'), ( 100, 'C'),
          ( 90, 'XC'), ( 50, 'L'), ( 40, 'XL'), (  20, 'XX'), (  10, 'X'),
          (  9, 'IX'), (  5, 'V'), (  4, 'IV'), (   2, 'II'), (   1, 'I'),
          ) -> $node {
      my (Int $val,  $str) = $node;
      if $n ≥ $val {
        $n   -= $val;
        $res ~= $str;
      }
    }
  }
  else {
    $res = "$n";
  }
  $res;
}
method specific-format { %( Oj => { $.feast },
                           '*' => { $.feast },
                            Ej => { $.feast-long },
                            EJ => { $.feast-caps },
                            Ey => { $.year-roman.lc },
                            EY => { $.year-roman },
                             u => { $.day-of-décade },
                             V => { $.décade-number },
                           ) }

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

See the full documentation in the main module,
C<Date::Calendar::FrenchRevolutionary>.

=head1 AUTHOR

Jean Forget <J2N-FORGET at orange dot fr>

=head1 COPYRIGHT AND LICENSE

Copyright (c) 2019, 2020, 2024 Jean Forget, all rights reserved

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod
