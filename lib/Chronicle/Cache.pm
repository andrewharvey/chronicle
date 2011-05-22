use strict;
use warnings;


package Chronicle::Cache;


=begin doc

Constructor for this class.

This constructor takes a single argument, which is a hash of keys.  The
only important key is "disable" which will cause this class to avoid loading
any cache back-end modules.

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

    #
    #  Attempt to load the caching modules, unless we shouldn't.
    #
    if ( !$self->{ 'disable' } )
    {
        $self->loadCaches();
    }

    return $self;
}



=begin doc

Attempt to load the available caching modules.

=end doc

=cut

sub enable
{
    my ($self) = (@_);

    #
    #  No longer marked as explicitly disabled.
    #
    $self->{ 'disable' } = 0;

    #
    #  Attempt to load.
    #
    $self->_loadMemcached() || $self->_loadRedis();
}



=begin doc

Disable any cache we might be using.

It is safe to call this even if we failed to load a cache back-end.

=end doc

=cut

sub disable
{
    my ($self) = (@_);

    #
    #  Store as disabled.
    #
    $self->{ 'disable' } = 1;

    #
    #  Unset the handle
    #
    $self->{ 'handle' } = undef;

}



=begin doc

Is the cache enabled?

=end doc

=cut

sub enabled
{
    my ($self) = (@_);

    if ( $self->{ 'handle' } )
    {
        return 1;
    }
    return 0;
}



=begin doc

Return the name of the module for our live back-end cache, or undef if
no caches were found and enabled.

=end doc

=cut

sub type
{
    my ($self) = (@_);

    #
    #  Explicitly marked as disabled?
    #
    return "disabled" if ( $self->{ 'disable' } );

    #
    #  OK are we enabled?
    #
    if ( $self->enabled() )
    {

        #
        #  If so return the name of the module we loaded.
        #
        if ( $self->{ 'memcache' } )
        {
            return ("Cache::Memcached");
        }
        if ( $self->{ 'redis' } )
        {
            return ("Redis");
        }
    }
    else
    {
        return undef;
    }
}



=begin doc

Attempt to load the redis client.

=end doc

=cut

sub _loadRedis
{
    my ($self) = (@_);

    #
    #  Do we have redis?
    #
    my $redis = "use Redis";

    ## no critic (Eval)
    eval($redis);
    ## use critic

    if ( !$@ )
    {
        $self->{ 'redis' }  = Redis->new();
        $self->{ 'handle' } = $self->{ 'redis' };
        return 1;
    }

    return 0;
}


=begin doc

Attempt to load the memcached server client.

=end doc

=cut

sub _loadMemcached
{
    my ($self) = (@_);

    #
    #  Do we have memcached?
    #
    my $cache = "use Cache::Memcached";

    ## no critic (Eval)
    eval($cache);
    ## use critic

    if ( !$@ )
    {
        $self->{ 'memcache' } =
          Cache::Memcached->new( { 'servers' => ["localhost:11211"] } );

        $self->{ 'handle' } = $self->{ 'memcache' };
        return 1;
    }

    return 0;
}



=begin doc

Attempt to retrieve a value from one of our back-end cache modules.

=end doc

=cut

sub get
{
    my ( $self, $key ) = (@_);

    if ( ( !$self->{ 'disable' } ) && $self->{ 'handle' } )
    {
        return ( $self->{ 'handle' }->get($key) );
    }

    return undef;
}


=begin doc

Set a value in one of our back-end cache modules.

=end doc

=cut

sub set
{
    my ( $self, $key, $value ) = (@_);

    if ( ( !$self->{ 'disable' } ) && $self->{ 'handle' } )
    {
        return ( $self->{ 'handle' }->set( $key, $value ) );
    }

    return undef;
}



1;
