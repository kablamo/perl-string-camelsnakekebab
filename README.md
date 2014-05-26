# NAME

String::CamelSnakeKebab - word case conversion

# SYNPOSIS

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



# DESCRIPTION

Camel-Snake-Kebab is a Clojure library for word case conversions.  This library
is ported from the original Clojure.

# METHODS

## lower\_camel\_case()

## upper\_camel\_case()

## lower\_snake\_case()

## upper\_snake\_case()

## constant\_case()

## kebab\_case()

## http\_header\_case()



# SEE ALSO

The original Camel Snake Kebab clojure library: https://github.com/qerub/camel-snake-kebab

# AUTHOR

Eric Johnson (kablamo)
