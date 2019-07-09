use v6.c;
use Date::Calendar::FrenchRevolutionary::Names;
role Date::Calendar::FrenchRevolutionary::Common:ver<0.0.1>:auth<cpan:JFORGET> {

  has Int $.year;
  has Int $.month;
  has Int $.day;
  has Str $.locale is rw = 'fr';

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
