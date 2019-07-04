package Up::Model::xlsx2csv;
#
#   A modulino that reads in a XLSX file and create a CSV file
#
use strict; use warnings; use feature 'say';
use utf8::all 'GLOBAL';
use Carp 'croak';
our $VERSION = '1.00';
use lib 'lib';
use Getopt::Long;
use File::Basename;


use Spreadsheet::ParseExcel;
use Spreadsheet::ParseXLSX;

# is the file called as a program or a module subroutine???
script() if not caller();


# validate arguments to program and call the main body
sub script {
#   say 'called as script';
   my $filename;
   my $help=0;

   GetOptions ( "file=s" => \$filename,    
                "help"   => \$help)
      or croak("Error in command line arguments");

   if ( ($help) or (not defined $filename) ) {
      print STDOUT <<EOM;

      Usage xlsx2csv.pm [-h] [-f file ]
        -h: this help message
        -f: CSV file to be processed

      example: xlsx2csv.pm -f aaa.csv
EOM
      exit 0;
   }

   if (not (-e $filename)) {
      croak "file: '$filename' , does not exist";
   }


   mymain($filename );
   exit 0;
}


# file used as a module with subroutine 'perform'
sub perform {
#  say 'perform';
   my ($file) = @_;
   mymain($file);
   return 1;
}


sub mymain {
#   say 'mymain';
   my ($fn) = @_;
      my $parser    = Spreadsheet::ParseXLSX->new();
      my $workbook  = $parser->parse( $fn );


      # Enter master headeru
      my($filename, $dirs, $suffix) = fileparse( $fn );

      for my $worksheet ( $workbook->worksheets() ) {
         my ( $row_min, $row_max ) = $worksheet->row_range();
         my ( $col_min, $col_max ) = $worksheet->col_range();

         # Enter header for detail(s)


         # Enter detail(s)
         for my $row ( $row_min .. $row_max ) {
            my @elements;
            for my $col ( $col_min .. $col_max ) {

               my $cell = $worksheet->get_cell( $row, $col );
               next unless $cell;
	       push @elements, $cell->unformatted();
            }
	    print join( "," , @elements ), "\n";
         }
	 last;
      }


   return;
}

1;
__END__

=head1 NAME

xlsx2csv 

A modulino that reads in a XLSX file and create a CSV file


=head1 VERSION

This document describes xlsx2csv version 1.00


=head1 SYNOPSIS

       use Up::Model::xlsx2csv;
       Up::Model::xlsx2csv::perform( file );
   OR
       $ perl lib/Up/Model/xlsx2csv.pm -f file.xlsx

  
=head1 DESCRIPTION

  Read a XLSX file and print data in CSV format.
  Note: Will only process the first worksheet of the
        spreadsheet.

=cut
