use strict; use warnings; use feature 'say';
use Data::Dumper;
use ETL::Yertl 'stdin';
use ETL::Yertl::Transform;
my $called = 0;
my @attributes = qw(name address age salary);
my $xform = stdin()
    | transform( 
        sub { 
	       if (not $called) { say join( ',', @attributes ); }
	       $called++;
               my $d = { name => $_->{name}, age => $_->{age}, salary => $_->{salary},
	                 address => '1313 Mocking Bird Lane' };
               say join( ',', map { $d->{$_} } @attributes );
               return $_;
	} 
    );
$xform->run;
