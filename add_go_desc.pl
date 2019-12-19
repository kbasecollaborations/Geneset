#!/usr/bin/perl

open (fh,"go_id_desc.txt") or die "could not read description file\n";
%deschash;
while ($input = <fh>)
{
   chomp($input);
   @rec = split("\t",$input);
   $deschash{$rec[0]}=$rec[1];
}
close(fh);

open (fgh,$ARGV[0]) or die "could not open genelist file\n";
while ($ginput = <fgh>)
{
   chomp($ginput);
   @grec = split("\t",$ginput);
   print("$grec[0]\t$grec[1]\t$grec[2]\t".$deschash{$grec[2]}."\n");
}
close(fgh);

