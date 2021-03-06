#
# Catalyst::Action::Serialize::YAML.pm
# Created by: Adam Jacob, Marchex, <adam@hjksolutions.com>
# Created on: 10/12/2006 03:00:32 PM PDT
#
# $Id$

package Catalyst::Action::Serialize::YAML;

use strict;
use warnings;

use base 'Catalyst::Action';
use YAML::Syck;

sub execute {
    my $self = shift;
    my ( $controller, $c ) = @_;

    my $stash_key = (
            $controller->{'serialize'} ?
                $controller->{'serialize'}->{'stash_key'} :
                $controller->{'stash_key'} 
        ) || 'rest';
    my $output;
    eval {
        $output = $self->serialize($c->stash->{$stash_key});
    };
    if ($@) {
        return $@;
    }
    $c->response->output( $output );
    return 1;
}

sub serialize {
    my $self = shift;
    my $data = shift;
    Dump($data);
}

1;
