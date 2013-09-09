#!/usr/bin/perl

use strict;
use warnings;

use Test::More;
use OAuth2::Box;

use Data::Dumper;
BEGIN { delete $INC{"HTTP/Tiny.pm"} }

use t::Module::HTTPTiny;
use Test::Exception;

my $ht = HTTP::Tiny->new;

print $ht->last_response;

my $ob = OAuth2::Box->new(
    client_id     => 123,
    client_secret => 'abcdef123',
    redirect_uri  => 'http://localhost',
    agent         => $ht,
);

throws_ok { $ob->authorize }
    qr/Assertion \(need code\)/,
    'authorize without code should die';

my ($token, $data) = $ob->authorize( code => 819358 );

is $token, 'yes', 'check access_token';

my $check = {
    success       => 1,
    access_token  => 'yes',
    refresh_token => 123,
    expires       => 1352,
};

is_deeply $data, $check, 'check response';

my $last_response = $ob->agent->last_response;
diag $last_response;

done_testing();
