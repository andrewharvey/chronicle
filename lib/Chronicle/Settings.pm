use strict;
use warnings;


package Chronicle::Settings;


=begin doc

Constructor for this class.

This constructor takes a single argument, which is a hash of keys.

=end doc

=cut


sub new
{
    my ( $proto, %supplied ) = (@_);
    my $class = ref($proto) || $proto;

    my $self = {};

    #
    #  Allow user supplied values to override our defaults
    #
    foreach my $key ( keys %supplied )
    {
        $self->{ lc $key } = $supplied{ $key };
    }

    bless( $self, $class );

    return $self;
}



=begin doc

Get a value from our settings.

=end doc

=cut

sub get
{
    my ( $self, $key ) = (@_);
    return ( $self->{ $key } || undef );
}



=begin doc

Set a value in our global state.

=end doc

=cut

sub set
{
    my ( $self, $key, $value ) = (@_);

    $self->{ $key } = $value;
}



=begin doc

Load configuration values from a "key = value" file.

=end doc

=cut

sub load
{
    my ( $self, $file ) = (@_);

    if ( -e $file )
    {

        my $line = "";

        open my $handle, "<:utf8", $file or die "Cannot read file '$file' - $!";
        while ( defined( $line = <$handle> ) )
        {
            chomp $line;

            #
            #  Allow lines to be continued.
            #
            if ( $line =~ s/\\$// )
            {
                $line .= <FILE>;
                redo unless eof(FILE);
            }

            # Skip lines beginning with comments
            next if ( $line =~ /^([ \t]*)\#/ );

            # Skip blank lines
            next if ( length($line) < 1 );

            # Strip trailing comments.
            if ( $line =~ /(.*)\#(.*)/ )
            {
                $line = $1;
            }

            # Find variable settings
            if ( $line =~ /([^=]+)=([^\n]+)/ )
            {
                my $key = $1;
                my $val = $2;

                # Strip leading and trailing whitespace.
                $key =~ s/^\s+//;
                $key =~ s/\s+$//;
                $val =~ s/^\s+//;
                $val =~ s/\s+$//;

                # command expansion?
                if ( $val =~ /(.*)`([^`]+)`(.*)/ )
                {

                    # store
                    my $pre  = $1;
                    my $cmd  = $2;
                    my $post = $3;

                    # get output
                    my $output = `$cmd`;
                    chomp($output);

                    # build up replacement.
                    $val = $pre . $output . $post;
                }

                # Store value.
                $self->set( $key, $val );
            }
        }

        close($handle);
    }
}




1;
