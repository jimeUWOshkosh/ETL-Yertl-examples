use strict; use warnings; use feature 'say';
use Data::Dumper;
use ETL::Yertl;
use ETL::Yertl::Transform;

my $xform = stdin()
    | transform( 
        sub { 
            $_->{salary} *= 1.05;
            return $_;
	} 
    ) >> stdout;
$xform->run;
