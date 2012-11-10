package MojoTimelinr::Web::Index;
use Mojo::Base 'Mojolicious::Controller';

sub start {
  my ($self) = @_;
  $self->render;
}
1;
__END__
