#! /usr/bin/perl

while(<>) {
	if(!/^ATOM/) {
		print $_;
		next;
	}
	my $line = $_;

	substr ($line, 74) = "";
	substr ($line, 61, 4) = "";
	substr ($line, 20, 3) = " ";
	print "$line\n";
}