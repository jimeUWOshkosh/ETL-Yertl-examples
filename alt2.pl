use strict; use warnings; use feature 'say';
use Data::Dumper;
use ETL::Yertl;
use ETL::Yertl::Transform;

# JSON is not YAML in Yertl world
# program errors out
my $xform = file( '<', 'employees.json' )
    | transform( 
        sub { 
            $_->{salary} *= 1.05;
            return $_;
	} 
    ) >> stdout;
$xform->run;
