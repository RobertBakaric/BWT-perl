#  Simple.pm
#  
#  Copyright 2015 Robert Bakaric <rbakaric@irb.hr>
#  
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#  
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#  
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
#  MA 02110-1301, USA.
#  
#  


package BWT::Simple;

use vars qw($VERSION);

$VERSION = '0.01';

use strict;
use Carp;


=head1 NAME

BWT::Simple - Simple BWT computation 

=head1 SYNOPSIS

    use BWT::Simple;
    use SA::SuffixArray;

    my $bwt1S = BWT::Simple-BWT->new();
    my $sa = SA::SuffixArray->new();
    
    # -----        Compute suffix array        ----- #
    my @suftab = $sa->Sort_Suffixes(array => \@array);

    # -----             BWT encode             ----- #
    my $bwtencode = $bwt1S->BWT_encode(suftab => \@suftab, string => \@array);

    # -----             BWT decode             ----- #
    my $bwtdecode = $bwt1S->BWT_decode(bwt => $bwtencode, terminator => $terminator); 


=head1 DESCRIPTION

The BWT is used in many lossless data compression schemes, one of
which is the Julian Seward's bzip2 program. The BWT of a string (S)
is usually computed by sorting all suffixes of S according to
lexicographic order after which a sequence of characters at positions 
preceding the sorted suffixes, is recorder. That sequence is known as 
BW transform of the underlying string S.   


=head2 new

    my $bwt1S = BWT::Simple->new();

    
Creates a new BWT object.

    my $sa = SA::SuffixArray->new();
    
Creates a new suffix array object.    
    

=head2 _sort_suffixes

    my @suftab = $sa->Sort_Suffixes(array => \@array);

Where \@array is an array reference of string characters.

Function returns the lexicographically sorted array of indexes 
corresponding to starting positions of string suffixes. Function 
is a simple quicksort based sorting lagorithm with O(n log n) 
worst case runtime behaviour.

=head2 BWT_encode
    
    my $bwtencode = $bwt1S->BWT_encode(suftab => \@suftab, string => \@array);

    Function requires a sorted suffix array (suftab) and a string (string)
    both as array references. As a result it returns the computed BWT array
    
=head2 BWT_decode

    my $bwtdecode = $bwt1S->BWT_decode(bwt => $bwtencode, terminator => $terminator);

    Once encoded, BWT can be decoded back using BWT_decode function. The 
    function requires BWT encod string and a string terminating character.


=head1 AUTHOR

Robert Bakaric <rbakaric@irb.hr>

=head1 LICENSE

  
#  Copyright 2015 Robert Bakaric <rbakaric@irb.hr>
#  
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#  
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#  
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
#  MA 02110-1301, USA.
#  
#  

=head1 ACKNOWLEDGEMENT


      1. Adjeroh, D., Bell, T. and Mukherjee, A. 2008. The Burrows-Wheeler Transform: Data Compression, Suffix Arrays, and Pattern Matching.    
      Springer US.
 
=cut






#################################################
#               CONSTRUCTOR
#################################################
#################################################
sub new {
#################################################

my ($class)=@_;

my $self = {};

bless ($self,$class);

}


#################################################
#               FUNCTIONS
#################################################
#################################################
sub BWT_encode {  
#################################################

my ($self,%arg) = @_;

my @bwt =();

for (0..$#{$arg{suftab}}){
   $bwt[$_]=$arg{string}->[$arg{suftab}->[$_]-1]
}

return join("",@bwt);
}

#################################################
sub BWT_decode {  
#################################################

my ($self,%arg) = @_;

my %count =();
my %occ   =();
my %sum = ();
my @output =();
my @string = split("",$arg{bwt});

my ($start, $tot) =(0,0);

for(my $i=0;$i<@string;$i++){
    $occ{$i} = $count{$string[$i]};
    $count{$string[$i]}++;
    $start = $i if($string[$i] eq $arg{terminator})
}

for(my $i=0;$i<256;$i++){
    $sum{chr($i)} = $tot if $count{chr($i)} > 0;
    $tot += $count{chr($i)};
}

for(my $j=(@string - 1);$j>-1;$j--){
    $output[$j] = $string[$start];
    $start = $occ{$start} + $sum{$string[$start]};
}

return join("",@output);
}

