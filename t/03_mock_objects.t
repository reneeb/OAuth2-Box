#!/usr/bin/perl

use strict;
use warnings;

use Test::More;
use OAuth2::Box;
use t::Module::HTTPTiny;

my $ht = HTTP::Tiny->new;
isa_ok $ht, 'HTTP::Tiny';
can_ok $ht, 'test';

is $ht->test, 'test';

my $ob = OAuth2::Box->new(
    client_id     => 123,
    client_secret => 'abcdef123',
    redirect_uri  => 'http://localhost',
    agent         => $ht,
);

isa_ok $ob, 'OAuth2::Box';
can_ok $ob->agent, 'test';
is $ob->agent->test, 'test';

done_testing();
