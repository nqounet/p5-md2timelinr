package MojoTimelinr::Web;
use utf8;
use Mojo::Base 'Mojolicious';

use Path::Class qw(file dir);

has home_dir => sub {
  app->home->detect;
};

# This method will run once at server start
sub startup {
  my ($self) = @_;

  $self->helper(
    assets_dir => sub {
      return dir(shift->app->home->detect, 'assets');
    }
  );

  # Router
  my $r = $self->routes;

  # Normal route to controller
  $r->get('/')->to('index#start');
  $r->get('/#filename')->to('index#start');
}

1;
