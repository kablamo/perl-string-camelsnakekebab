package String::CamelSnakeKebab;
use strict;
use warnings;

use Sub::Exporter -setup => { exports => [qw/
    lower_camel_case
    upper_camel_case
    lower_snake_case
    upper_snake_case
    constant_case
    kebab_case
    http_header_case
/]};

our $VERSION = "0.01";

our %UPPER_CASE_HTTP_HEADERS = map { $_ => 1 } 
    qw/ CSP ATT WAP IP HTTP CPU DNT SSL UA TE WWW XSS MD5 /;

sub http_header_caps {
    my ($string) = @_;
    return uc $string if $UPPER_CASE_HTTP_HEADERS{uc $string};
    return ucfirst $string;
}

# A pattern that matches all known word separators
our $WORD_SEPARATOR_PATTERN = qr/
    (?:
        \s+                        |
        _                          |
        -                          |
        (?<=[A-Z])(?=[A-Z][a-z])   |
        (?<=[^A-Z_-])(?=[A-Z])     |
        (?<=[A-Za-z])(?=[^A-Za-z])
    )
/x;

sub convert_case {
    my ($first_coderef, $rest_coderef, $separator, $string) = @_;

    my ($first, @rest) = split $WORD_SEPARATOR_PATTERN, $string;

    my @words = $first_coderef->($first);
    push @words, $rest_coderef->($_) for @rest;

    return join $separator, @words;
}

# Need to do this because I can't make lc a code reference via \&CORE::lc
# unless the user has perl v5.16
sub lc      { lc      shift }
sub uc      { uc      shift }
sub ucfirst { ucfirst shift }

our %CONVERSION_RULES = ( 
    'lower_camel_case' => [ \&lc,               \&ucfirst,          ""  ],
    'upper_camel_case' => [ \&ucfirst,          \&ucfirst,          ""  ],
    'lower_snake_case' => [ \&lc,               \&lc,               "_" ],
    'upper_snake_case' => [ \&ucfirst,          \&ucfirst,          "_" ],
    'constant_case'    => [ \&uc,               \&uc,               "_" ],
    'kebab_case'       => [ \&lc,               \&lc,               "-" ],
    'http_header_case' => [ \&http_header_caps, \&http_header_caps, "-" ],
);

{
    # Foreach rule, dynamically install a sub in this package
    no strict 'refs';
    for my $rule ( keys %CONVERSION_RULES ) {
        my $args = $CONVERSION_RULES{$rule};
        *{$rule} = sub { convert_case(@$args, @_) };
    }
}

=head1 NAME

String::CamelSnakeKebab - word case conversion

=head1 SYNPOSIS

    use String::CamelSnakeKebab qw/:all/;

    lower_camel_case 'flux-capacitor'
    # => 'fluxCapacitor

    upper_camel_case 'flux-capacitor'
    # => 'FluxCapacitor

    lower_snake_case 'ASnakeSlithersSlyly'
    # => 'a_snake_slithers_slyly'

    upper_snake_case 'ASnakeSlithersSlyly'
    # => 'A_Snake_Slithers_Slyly'

    constant_case "I am constant"
    # => "I_AM_CONSTANT"

    kebab_case 'Peppers_Meat_Pineapple'
    # => 'peppers-meat-pineapple'

    http_header_case "x-ssl-cipher"
    # => "X-SSL-Cipher"


=head1 DESCRIPTION

Camel-Snake-Kebab is a Clojure library for word case conversions.  This library
is ported from the original Clojure.

=head1 METHODS

=head2 lower_camel_case()

=head2 upper_camel_case()

=head2 lower_snake_case()

=head2 upper_snake_case()

=head2 constant_case()

=head2 kebab_case()

=head2 http_header_case()


=head1 SEE ALSO

The original Camel Snake Kebab clojure library: https://github.com/qerub/camel-snake-kebab

=head1 AUTHOR

Eric Johnson (kablamo)

=cut

1;
