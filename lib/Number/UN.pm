package Number::UN;
# ABSTRACT: details about UN numbers

use strict;
use warnings;

use JSON 'decode_json';
use Path::Class 'file';

use Exporter 'import';
our @EXPORT_OK = qw(get_un);

=head1 NAME

Number::UN - UN Numbers

=head1 SYNOPSIS

  use Number::UN 'get_un';

  my %un = get_un(1993);
  print $un{description}; # Combustible liquids, n.o.s.

=head1 LICENSE

The source code is distributed under the Perl5/Artistic License (http://dev.perl.org/licenses/artistic.html), copyright John Tantalo (2012).

The data materia is distributed under the Creative Commons Attribution-ShareAlike License (http://en.wikipedia.org/wiki/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License). This material was collected from List of UN numbers (http://en.wikipedia.org/wiki/List_of_UN_numbers), 16 Feb 2012.

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
