#!/usr/bin/perl

use strict;
use warnings;

sub compare_switch
{
    my $arr      = shift;
    my $a        = shift;
    my $b        = shift;

    my @list     = @$arr;
    my $switched = 0;
    my @ret      = ($list[$a], $list[$b], $switched);

    if ($list[$a] > $list[$b])
    {
        $switched = 1;
        @ret      = ($list[$b], $list[$a], $switched);
    }

    return @ret;
}

sub bubble_sort
{
    my $arr       = shift;
    my @list      = @$arr;
    my $listSize  = @list;
    my $notSorted = 0;
    my $switched  = 0;

    for (my $i = 0; $i < ($listSize - 1); $i++)
    {
        ($list[$i], $list[$i+1], $switched) = compare_switch(\@list, $i, $i+1);
            
        $notSorted |= $switched;

        if ($notSorted && $i == ($listSize - 2))
        {
            $i         = 0;
            $notSorted = 0;
        }
    }

    print " @list\n";
}

1;
