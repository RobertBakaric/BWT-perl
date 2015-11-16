use Test::More;
use lib '../lib';
use BWT::Simple;

plan tests => 2;

my $output1 = 'LPfCsiKseehrnttoltttashrahtsgctrooaiiseeeoatxictssm';
my $output2 = 'thisisatesttotestthecorrectnessofLCPKasaialgorithmx';


my @suftab = qw(34 36 33 35 39 41 37 6 20 25 19 24 28 14 8 32 43 18 1 48 40 4 2 46 42 49 27 31 44 21 12 23 45 22 38 5 3 30 29 15 9 13 7 17 0 47 26 11 16 10 50);

my $bwt1S = BWT::Simple->new();

my @array = split("",$output2);

my $bwtencode = $bwt1S->BWT_encode(suftab => \@suftab, string => \@array);
my $bwtdecode = $bwt1S->BWT_decode(bwt => $bwtencode, terminator => 'x');

ok( $bwtencode eq $output1, "Encode");
ok( $bwtdecode eq $output2, "Decode");

done_testing;
