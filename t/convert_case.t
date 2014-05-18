use Test::Most;
use DDP { deparse => 1 };
use String::CamelSnakeKebab qw/
    upper_camel_case
    constant_case
    http_header_case
/;

my %tests = (
      'FluxCapacitor' => sub { upper_camel_case 'flux-capacitor' },
      'I_AM_CONSTANT' => sub { constant_case    'I am constant'  },
      'X-SSL-Cipher'  => sub { http_header_case 'x-ssl-cipher'   },
);

while ( my ($expected_answer, $test_this) = each %tests ) {

    cmp_deeply 
        $test_this->(),
        $expected_answer, 
        "got <$expected_answer> from " . p($test_this);

}

done_testing;
