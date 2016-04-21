#!/usr/bin/perl

use strict;
use warnings;
use threads;
use threads::shared;
use Spreadsheet::WriteExcel;
use Time::HiRes qw( time );

require 'sort.pl';
require 'xls.pl';


my $LIST_SIZE = 100;
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
my @start	 = (); 
my @duration = (0, 0, 0, 0);


foreach my $key (keys(%sorting)) 
{
	print "Sorting Method: $key\n";
    print "$key before: @list\n";

	$start[$row-2] = time();
   # @after    = $sorting{$key}->(\@list);
    ($thr[($row++)-2]) = threads->create($sorting{$key}, \@list);
}

my $num = 0;
foreach my $key (keys(%sorting)) 
{
	@after          = $thr[$num]->join();
	$duration[$num] = (time() - $start[$num])*1000;

   	print "$key after: @after\n";
   	print "$key duration: $duration[$num] ms\n";
   	$num++;
}

$row = 2;
foreach my $dur (@duration)
{
	while(threads->get_stack_size() != 0)
	{
		if ($thr[$row-2]->is_running())
		{
			sleep(2);
		}
		else
		{
			$worksheet->write('B'.$row++, $dur, $format);
		}
	}
}