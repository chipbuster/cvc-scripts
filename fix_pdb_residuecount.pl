#! /usr/bin/perl
# Fixes the residue count on the PDB file so it's always monotonic increasing
# (this prevents a bug from happening with the f2d files). Also fixes the residues
# so it will only print if there is more than one atom.

use strict;

my $resi_count = 0;
my $count = 0;
my $prev_res = -1;
my $prev_insertion = " ";
my $residue_output = "";

my $def_chain = "A";

while(<>) {
	if (!/^(ATOM|HETATM)/) {
    # Don't print it, just add it to the end of the residue output
		$residue_output .= $_;
		next;
	}
	my $line = $_;
  my $chain = substr($line, 21, 1);
	my $resi = substr($line, 22, 4);
	my $insertion = substr($line, 26, 1);
	# If there's something in the insertion column, remove it
  # and keep going
  # Insertion column enforces similar numbering among different species.
  # We don't care about numbering here.
	if ($insertion ne " ") {
    substr( $line, 26, 1) = " ";
    #$resi .= $insertion;
  }

  if ($chain eq " ") {
    substr($line, 21, 1) = $def_chain;
  } else {
    $def_chain = $chain;
  }

	if ($resi ne $prev_res || $insertion ne $prev_insertion) {
		# Don't print out residues that only have one atom
    # (this causes pdb2pqr and stuff to fail... "not enough heavy atoms")
		if ($resi_count > 1) {
			print $residue_output;
		}
		$residue_output = "";
		$resi_count = 0;
		$count++;
		$prev_res = $resi;
    $prev_insertion = $insertion;
	}
	substr( $line, 22, 4 ) = sprintf("%4d", $count);
	$residue_output .= $line;
	$resi_count++;
}
if ($resi_count > 1) {
	print $residue_output;
}
