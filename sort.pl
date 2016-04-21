#!/usr/bin/perl

use strict;
use warnings;


sub bubble_sort
{
    my $arr       = shift;
    my @list      = @$arr;
    my $listSize  = @list;
    my $notSorted = 0;

    for (my $i = 0; $i < ($listSize - 1); $i++)
    {
        if ($list[$i] > $list[$i+1])
        {
            ($list[$i], $list[$i+1], $notSorted) = ($list[$i+1], $list[$i], 1);
        }

        if ($i == ($listSize - 2))
        {
            if ($notSorted)
            {
                $i         = -1;
                $notSorted = 0;
            }
        }
    }

    return (@list);
}


sub insertion_sort
{
    my $arr      = shift;
    my @list     = @$arr;
    my $listSize = @list;

    for (my $i = 1; $i < $listSize; $i++)
    {
        my $value = $list[$i];
        my $j     = $i;

        while ($j > 0 && $list[$j-1] > $value)
        {
            $list[$j] = $list[$j-1];
            $j--;
        }

        $list[$j] = $value;
    }

    return @list;
}


sub merge_sort
{
    my $arr      = shift;
    my @list     = @$arr;
    my $listSize = @list;

    if ($listSize > 1)
    {
        my $mid = $listSize / 2;

        my @left  = @list[0 .. $mid-1];
        my @right = @list[$mid .. $listSize-1];

        @left  = merge_sort(\@left);
        @right = merge_sort(\@right);

        my $lSize = @left;
        my $rSize = @right;
        my @nList;
        my $k     = 0;

        while ($lSize > 0 && $rSize > 0)
        {
            if ($left[0] <= $right[0])
            {
                $nList[$k++] = $left[0];
                @left        = @left[1 .. $lSize-1];

                $lSize--;
            }
            else
            {
                $nList[$k++] = $right[0];
                @right       = @right[1 .. $rSize-1];

                $rSize--;
            }
        }

        if ($lSize > 0)
        {
            @list = (@nList, @left);
        }

        if ($rSize > 0)
        {
            @list = (@nList, @right);
        }
    }

    return @list;
}


sub quick_sort
{
    my $arr      = shift;
    my @list     = @$arr;
    my $listSize = @list;

    if ($listSize > 1)
    {
        my (@less, @equal, @greater);
        
        my $p    = ($listSize / 2) - 1;
        my $piv  = $list[$p];

        for (my $i = 0; $i < $listSize; $i++)
        {
            if ($list[$i] < $piv)
            {
                push(@less, $list[$i]);
            }
            elsif ($list[$i] == $piv)
            {
                push(@equal, $list[$i]);
            }
            else
            {
                push(@greater, $list[$i]);
            }
        }

        @list = (quick_sort(\@less), @equal, quick_sort(\@greater));
    }

    return @list;
}


1;
