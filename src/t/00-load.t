#!perl -T
use 5.014;
use strict;
use warnings FATAL => 'all';
use Test::More;

plan tests => 1;

BEGIN {
    use_ok( 'BWT::Simple' ) || print "Bail out!\n";

}

diag( "\nTesting BWT::Simple v$BWT::Simple::VERSION, Perl $], $^X" );

