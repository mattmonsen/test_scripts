package Mojolicious::Plugin::DbixConnector;

=head

Mojolicious::Plugin::DbixConnector - Created by vti original module can be found here:
https://github.com/vti/mojox-common/blob/master/lib/Mojolicious/Plugin/DbixConnector.pm

=cut

use strict;
use warnings;

use base 'Mojolicious::Plugin';

use DBIx::Connector;

sub register {
    my ($self, $app, $conf) = @_;

    # Application attr
    my $app_attr = $conf->{app_attr} || 'conn';

    my @params;
    if ($conf->{dsn}) {
        @params = (
            $conf->{dsn},
            $conf->{username} || '',
            $conf->{password} || '',
            $conf->{attr}     || {}
        );
    }
    elsif (ref($conf->{params}) eq 'ARRAY') {
        @params = @{$conf->{params}};
    }
    else {
        @params = ($conf->{params});
    }

    # Register application's shortcut
    ref($app)->attr($app_attr => sub { DBIx::Connector->new(@params) })
      unless $app->can($app_attr);
}

1;
