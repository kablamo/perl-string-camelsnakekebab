use Test::Most;
use String::CamelSnakeKebab;

my $separator = $String::CamelSnakeKebab::WORD_SEPARATOR_PATTERN;

my %tests = (
    "foo bar"    => [qw/foo bar/],
    "foo\n\tbar" => [qw/foo bar/],
    "foo-bar"    => [qw/foo bar/],
    "fooBar"     => [qw/foo Bar/],
    "FooBar"     => [qw/Foo Bar/],
    "foo_bar"    => [qw/foo bar/],
    "FOO_BAR"    => [qw/FOO BAR/],
);

cmp_deeply [ split $separator, $_ ] => $tests{$_}, 
    sprintf "%8s -> %s %s", $_, @{ $tests{$_} }
        for keys %tests;

done_testing;
