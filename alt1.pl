use strict; use warnings; use feature 'say';
use ETL::Yertl;
use ETL::Yertl::Transform;

my $xform = file( '<', 'employees.yaml' )
    | transform( 
        sub { 
            $_->{salary} *= 1.05;
            return $_;
	} 
    ) >> stdout;
$xform->run;
