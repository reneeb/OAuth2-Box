#!/usr/bin/perl

use strict;
use warnings;

use Test::More;
use Test::Exception;

use_ok 'OAuth2::Box';

throws_ok { OAuth2::Box->new }
    qr/Missing .* client_id, client_secret, redirect_uri/,
    'new obect without params dies';

throws_ok { OAuth2::Box->new( client_id => 123 ) }
    qr/Missing .* client_secret, redirect_uri/,
    'new obect with client_id only dies';
throws_ok {
    OAuth2::Box->new(
        client_id => 123,
        client_secret => 'abcdef123',
    );
    }
    qr/Missing .* redirect_uri/,
    'new obect with client_id and client_secret only dies';

my $ob = OAuth2::Box->new(
    client_id     => 123,
    client_secret => 'abcdef123',
    redirect_uri  => 'http://localhost/',
);

isa_ok $ob, 'OAuth2::Box', 'new obect created';

can_ok $ob, qw/authorization_uri authorize refresh_token/;

is $ob->url, 'https://www.box.com/api/oauth2/authorize', 'check authorization url';
throws_ok { $ob->url('test' ) }
    qr/Usage: OAuth2::Box::url\(self\)/,
    'url is "ro"';

is $ob->token_url, 'https://www.box.com/api/oauth2/token', 'check token url';
throws_ok { $ob->token_url('test' ) }
    qr/Usage: OAuth2::Box::token_url\(self\)/,
    'token_url is "ro"';

is $ob->client_id, 123, 'check client_id';
throws_ok { $ob->client_id('test' ) }
    qr/Usage: OAuth2::Box::client_id\(self\)/,
    'client_id is "ro"';

is $ob->client_secret, 'abcdef123', 'check client_secret';
throws_ok { $ob->client_secret('test' ) }
    qr/Usage: OAuth2::Box::client_secret\(self\)/,
    'client_secret is "ro"';

is $ob->redirect_uri, 'http://localhost/', 'check redirect_uri';
throws_ok { $ob->redirect_uri('test' ) }
    qr/Usage: OAuth2::Box::redirect_uri\(self\)/,
    'redirect_uri is "ro"';

done_testing();
