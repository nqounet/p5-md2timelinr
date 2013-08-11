package MojoTimelinr::Web::Index;
use utf8;
use Mojo::Base 'Mojolicious::Controller';

use Path::Class qw(file dir);
use Text::Markdown::Discount qw( markdown );
use Mojo::DOM;
use Encode;

sub start {
  my ($self) = @_;
  my $dir = $self->assets_dir;

  my $file = $self->param('filename');
  unless ($file) {
    my @assets;
    for my $child ($dir->children) {
      my $basename = $child->basename || '';
      next unless $basename =~ /\.md\z/;
      push @assets, $child;
    }
    $self->stash(subject => 'Assets List');
    $self->stash(assets => \@assets);
    return $self->render(template => 'index/list');
  }
  $file = file($dir, $file);
  return $self->render_not_found unless -f $file;
  my $content = decode_utf8($file->slurp);
  my @slide;
  my $count = 0;
  for my $section ($content =~ /(^#\s+.*?)(?:(?=^#\s+)|\z)/msg) {
    my $md = markdown($section);
    my $subject = Mojo::DOM->new($md)->at('h1')->text;
    push @slide, {
      id => ++$count,
      subject => $subject,
      content => $md,
    };
  }
  $self->stash(stash_slide => \@slide);
  return $self->render(template => 'index/single');
}
1;
__END__
