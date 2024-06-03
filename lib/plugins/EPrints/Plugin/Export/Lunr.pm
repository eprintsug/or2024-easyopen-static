=head1 NAME

EPrints::Plugin::Export::Lunr

=cut

package EPrints::Plugin::Export::Lunr;

use Data::Dumper;
use JSON::PP;

@ISA = ( "EPrints::Plugin::Export" );
use EPrints::Plugin::Export;

use strict;

sub new
{
    my( $class, %opts ) = @_;

    my $self = $class->SUPER::new( %opts );

    $self->{name} = "Lunr";
    $self->{accept} = [ 'dataobj/eprint', 'list/eprint' ];
    $self->{visible} = "all";
    $self->{mimetype} = 'application/json; charset=utf-8';
    $self->{suffix} = ".js";

    return $self;
}

sub output_list
{
    my( $self, %opts ) = @_;

    print {$opts{fh}} "[";

    $opts{list}->map( sub {
        my( $session, $dataset, $dataobj ) = @_;
        
        print {$opts{fh}} $self->output_dataobj( $dataobj );
    } );
    print {$opts{fh}} "]";
}

sub output_dataobj
{
    my( $self, $dataobj, %opts ) = @_;
    my $session = $self->{session};

    my $ds = $dataobj->dataset;

    my %lunr_hash = (
        id => $dataobj->id
    );

    foreach my $sf ( @{$session->config( "search", "simple")->{search_fields}->[0]->{meta_fields}} )
    {
        my $metafield = $ds->field( $sf );
        my( $codes, $grepcodes, $ignored )  = $metafield->get_index_codes( $session, $dataobj->value( $sf ) );
        print STDERR Dumper( $codes );
        print STDERR "$codes\n";
        $lunr_hash{$sf} = join( " ", @{$codes} );
    }

    my $json = encode_json( \%lunr_hash );
    print STDERR Dumper( \%lunr_hash );
    return $json;
}
