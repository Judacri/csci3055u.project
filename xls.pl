#!/usr/bin/perl

use strict;
use warnings;
use Spreadsheet::WriteExcel;


my @labels = ("Sorting Method", "Time(ms)");

sub setup_xls
{
	my $has     = shift;
    my %sorting = %$has;

    my $workbook  = Spreadsheet::WriteExcel->new('perl.xls');
	my $worksheet = $workbook->add_worksheet();
    my $format    = $workbook->add_format(bold => 1, color => 'red');
    $format->set_text_wrap();
   
    my $col = 'A';
    foreach my $lab (@labels)
    {
		$worksheet->write($col.'1', $lab, $format);
		$worksheet->set_column($col++.'1', 100);
	}

	my $row = 2;
	foreach my $sorts (keys(%sorting))
    {
		$worksheet->write('A'.$row++, $sorts);
	}

	return ($workbook, $worksheet);
}