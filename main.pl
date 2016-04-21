#!/usr/bin/perl

use strict;
use warnings;
use threads;
use threads::shared;
use Spreadsheet::WriteExcel;
use Time::HiRes qw( time );

require 'sort.pl';
require 'xls.pl';


my $LIST_SIZE = 10;
my @list      = ();
my @after     = ();

my %sorting = (Bubble => \&bubble_sort,
               Insert => \&insertion_sort,
               Merge  => \&merge_sort,
               Quick  => \&quick_sort);


my @thr = ();

for (my $i = 0; $i < $LIST_SIZE; $i++)
{
	push @list, int(rand(100));
}


my ($workbook, $worksheet) = setup_xls(\%sorting);
my $format = $workbook->add_format();
$format->set_num_format('0.000');

my $row		 = 2;
my $start	 = 0; 
my $duration = 0;


foreach my $key (keys(%sorting)) 
{
	print "Sorting Method: $key\n";
    print "before: @list\n";

	$start    = time();
    #@after    = $sorting{$key}->(\@list);
    ($thr[$row-2]) = threads->create($sorting{$key}, \@list);

    @after = $thr[$row-2]->join();
	$duration = time() - $start;

   	print "after: @after\n\n";
   	$worksheet->write('B'.$row++, $duration*1000000, $format);
}