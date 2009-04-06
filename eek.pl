#!/usr/bin/perl
#
# eek.pl -- Utility functions for Perl scripts

sub r {
    my ($q, $options) = @_;
    my $r;

    do {
        print "$q ";
        print "(Y/N) " if ($options eq 'yn');
        $r = <STDIN>;
        chomp $r;
    } while ($options && $options !~ /$r/i);
    if ($options eq 'yn') {
        return 1 if $r eq 'y';
        return 0;
    }
    return $r;
}

sub read_hash {
    my $hash_file = shift;
    my %h;
    open(F, $hash_file);
    while (<F>) {
        chomp;
        my ($key, $val) = split(/:/);
        $h{$key} = $val;
    }
    close(F);
    return \%h;
}

sub md {
    my $d = shift;
    $d =~ s/\/$//;
    @dir = split('/', $d);
    $d = shift @dir;
    if ($d && !-d $d) {
        die "Could not create directory $d:\n    $!" unless mkdir $d;
    }
    while (@dir) {
        $d .= '/' . shift @dir;
        if (!-d $d) {
            die "Could not create directory $d:\n    $!" unless mkdir $d;
        }
    }

}

1;

__END__

=head1 NAME

eek.pl -- Utility functions for Perl scripts

=head1 VERSION

Version 0.0.0

=head1 SYNOPSIS

Utility functions for Perl scripts I find myself writing over and over
again.

    require 'eek.pl';

    my $is_happy = &r('Happy?', 'yn);
    if ($is_happy) {
        print "Great!\n";
    }
    else {
        print "Too bad.\n";
    }

=head1 FUNCTIONS

=head2 r( $question, $options )

Prints $question (followed by a space) and waits for user input, which
it returns.

$options is an optional string containing acceptable character
input. If $options is set, then this function will repeat the question
until it receives valid input.

If $options is 'yn', it will automatically append "(Y/N)" after the
question, and it will return 1 or 0 depending on the response.

=head2 read_hash( $hash_file )

Reads a colon delimited file and returns a hash reference.

=head2 md( $dir )

Makes the directory $dir and all the prerequisite parent directories (if
necessary). Dies if unsuccessful.

=head1 AUTHORS

Eugene Eric Kim, E<lt>eekim@blueoxen.comE<gt>

=head1 COPYRIGHT & LICENSE

(C) Copyright 2009 Blue Oxen Associates.  All rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut
