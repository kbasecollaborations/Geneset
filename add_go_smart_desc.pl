#!/usr/bin/perl
use strict;
use warnings;

open (my $fh,$ARGV[0]) or die "could not read description file\n";
my %deschash;
while (my $input = <$fh>)
{
   chomp($input);
   my @rec=();
   @rec = split("\t",$input);
   $deschash{$rec[0]}=$rec[1];
}
close($fh);

open (my $fgh,$ARGV[1]) or die "could not open genelist file\n";
while (my $ginput = <$fgh>)
{
   chomp($ginput);
   my @grec = ();
   @grec = split("\t",$ginput);
   if (defined $grec[2]) 
   {
      print("$grec[0]\t$grec[1]\t$grec[2]\t".$deschash{$grec[2]}."\n");
      #print("$grec[0]\t$grec[1]\t\t\n");
   } 
   else 
   {
      print("$grec[0]\t$grec[1]\t\t\n");
      #print("$grec[0]\t$grec[1]\t$grec[2]\t".$deschash{$grec[2]}."\n");
   }
}
close($fgh);

