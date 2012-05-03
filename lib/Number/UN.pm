package Number::UN;
# ABSTRACT: details about UN numbers

use strict;
use warnings;

use JSON 'decode_json';
use Path::Class 'file';

use Exporter 'import';
our @EXPORT_OK = qw(get_un);

our $VERSION = '0.01';

=head1 NAME

Number::UN - UN Numbers

=head1 SYNOPSIS

  use Number::UN 'get_un';

  my %un = get_un(1993);
  print $un{description}; # Combustible liquids, n.o.s.

=cut

sub get_un {
  my $fn = sprintf "%s/%04d.json", data_dir(), shift;
  return unless -e $fn;
  open my $fh, '<', $fn;
  my $text = <$fh>;
  my $hashref = decode_json $text or return;
  return %$hashref;
}

sub data_dir {
  file(__FILE__)->parent()->subdir('UN-data');  
}

1;
