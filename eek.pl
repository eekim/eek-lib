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

1;

__END__

=head1 NAME

eek.pl -- Utility functions for Perl scripts

=head1 VERSION

Version 0.0.0

=head1 SYNOPSIS

Utility functions for Perl scripts I find myself writing over and over
again.

    require eek.pl;

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

=head1 AUTHORS

Eugene Eric Kim, E<lt>eekim@blueoxen.comE<gt>

=head1 COPYRIGHT & LICENSE

(C) Copyright 2009 Blue Oxen Associates.  All rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut
