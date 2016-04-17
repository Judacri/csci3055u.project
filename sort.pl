#!/usr/bin/perl

use strict;
use warnings;

sub compare_switch
{
    my $list     = shift;
    my $a        = shift;
    my $b        = shift;
    my $switched = 0;
    print "$a           $b\n";
print "@$list[$a] \> @$list[$b]\n";
my @ret = (@$list[$a], @$list[$b]. $switched);
    if (@$list[$a] > @$list[$b])
    {
        $switched  = 1;
        @ret = (@$list[$b], @$list[$a]. $switched);
        print "switched";
    }

    return \@ret;
}

sub bubble_sort
{
    my $arr       = shift;
    my @list      = @$arr;
    my $listSize  = @list;
    my $notSorted = 0;

    print "array @list with size $listSize\n";

}
1;
