package Number::UN;

use strict;
use warnings;

use JSON::Syck;
use Path::Class 'file';

use Exporter 'import';
our @EXPORT_OK = qw(get_un);

=head1 NAME

Number::UN

=head1 SYNOPSIS

  use Number::UN 'get_un';

  my %un = get_un(1993);
  print $un{description}; # Combustible liquids, n.o.s.

=cut

sub get_un {
  my $data_filename = sprintf "%s/%04d.json", data_dir(), shift;
  return unless -e $data_filename;
  my $data = JSON::Syck::LoadFile($data_filename) or return;
  return %$data;
}

sub data_dir {
  file(__FILE__)->parent()->subdir('UN-data');  
}

1;
