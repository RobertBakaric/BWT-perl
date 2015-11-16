#!/usr/bin/perl 
#  BWT.pl
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


use strict;
use Getopt::Long;
use SA::SuffixArray;
use BWT::Simple;
use File::Slurp;


my $bwt1S = BWT::Simple->new();
my $sa = SA::SuffixArray->new();


my ($help,$in,$quite,$terminator, $kk);
GetOptions ("i=s" => \$in,  # input 
            "h" => \$help,
            "t=s" => \$terminator
            );
                        
if($help || !$in){
  print "Usage:\n\n";
  print "\t-i\tinput - ASCII file\n";
  print "\t-t\tterminating symbol\n";

  exit(0);
}

# -----              Set Defs              ----- #
$terminator = "\$" unless $terminator;

# -----              Read File             ----- #
my $content = read_file($in) ;

chomp($content);
$content .= $terminator;

my @array = split("",$content);

# -----        Compute suffix array        ----- #
my @suftab = $sa->Sort_Suffixes(array => \@array);


# -----         Compute bwt array          ----- #

my $bwtencode = $bwt1S->BWT_encode(suftab => \@suftab, string => \@array);


# -----         Printing results           ----- #

print "\nThis is my BWT:\n$bwtencode\n";


# -----         Compute string array          ----- #
my $bwtdecode = $bwt1S->BWT_decode(bwt => $bwtencode, terminator => $terminator);


# -----         Printing results           ----- #

print "\nThis is my BTW decode:\n$bwtdecode\n";

  








