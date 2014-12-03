package MvcTest::Controller::location;
use Moose;

BEGIN { extends 'Catalyst::Controller'; }

sub index :Path :Args(){
	my ( $self, $c ) = @_;
	
	$c->stash->{active} = StringHelper::getControllerName $c->controller();
	$c->forward('View::HTML');

}

sub locations :Path("locations") :Args(){
	my ( $self, $c ) = @_;

	$c->stash->{locations} = (
		[
			{ "location_id" => 1, "location_name" => "River" },
			{ "location_id" => 2, "location_name" => "Teatro Opera" }
		]
	);

	$c->forward('View::JSON');

	#if ( $mode == "json" ){
	#	$c->forward('View::JSON');
	#}else{
	#	$c->forward('View::HTML');
	#}
}

sub sectors :Path("sectors") :Args(){
	my ( $self, $c, $location_id ) = @_;

	my @sectors = {
		1=>{
			1=>{ "location_id" => 1, "sector_id" => 1, "name" => "Platea Baja" },
			2=>{ "location_id" => 1, "sector_id" => 2, "name" => "Platea Media" },
			3=>{ "location_id" => 1, "sector_id" => 3, "name" => "Platea San Martin" },
			4=>{ "location_id" => 1, "sector_id" => 4, "name" => "Platea Belgrano" }
		},
		2=>{
			1=>{ "location_id" => 2, "sector_id" => 5, "name" => "Platea VIP" },
			2=>{ "location_id" => 2, "sector_id" => 6, "name" => "Platea" },
			3=>{ "location_id" => 2, "sector_id" => 7, "name" => "Pullman" },
			4=>{ "location_id" => 2, "sector_id" => 8, "name" => "Superpullman" }
		}
	};

	$c->stash->{location_id} = $location_id;
	#$c->stash->{locations} = $sectors->{location_id};
	#$c->stash->{locations} = $sectors[$location_id];
	#$c->stash->{locations} = \@sectors;
	#$c->stash->{locations} = $sectors[0]->{location_id};
	$c->stash->{locations} = $sectors[0]->{$location_id};
	#$c->stash->{locations} = $sectors[0][location_id];
	$c->forward('View::JSON');
}

sub places :Path("places") :Args(){
	my ( $self, $c, $location_id, $sector_id ) = @_;

	my ($loc_id, $sec_id, $pla_id) = ( 1, 1, 1 );

	my @sectors = {
		$loc_id++=>{
			$sec_id++=>{ 
				$pla_id++ =>{ "row" =>1, "col" => 1, "status" => "available"},
				$pla_id++ =>{ "row" =>1, "col" => 2, "status" => "available"},
				$pla_id++ =>{ "row" =>2, "col" => 1, "status" => "available"},
				$pla_id++ =>{ "row" =>2, "col" => 2, "status" => "reserved"},
			},
			$sec_id++=>{ 
				$pla_id++ =>{ "row" =>1, "col" => 1, "status" => "available"},
				$pla_id++ =>{ "row" =>1, "col" => 2, "status" => "available"},
				$pla_id++ =>{ "row" =>1, "col" => 3, "status" => "available"},
				$pla_id++ =>{ "row" =>1, "col" => 4, "status" => "buyed"},
			},
			$sec_id++=>{ 
				$pla_id++ =>{ "row" =>1, "col" => 1, "status" => "available"},
				$pla_id++ =>{ "row" =>2, "col" => 1, "status" => "buyed"},
				$pla_id++ =>{ "row" =>3, "col" => 1, "status" => "available"},
				$pla_id++ =>{ "row" =>4, "col" => 1, "status" => "buyed"},
			},
			$sec_id++=>{ 
				$pla_id++ =>{ "row" =>1, "col" => 1, "status" => "available"},
				$pla_id++ =>{ "row" =>2, "col" => 1, "status" => "reserved"},
				$pla_id++ =>{ "row" =>3, "col" => 2, "status" => "available"},
				$pla_id++ =>{ "row" =>4, "col" => 2, "status" => "buyed"},
			}
		},
		$loc_id++=>{
			$sec_id++=>{ 
				$pla_id++ =>{ "row" =>1, "col" => 1, "status" => "available"},
				$pla_id++ =>{ "row" =>1, "col" => 2, "status" => "available"},
				$pla_id++ =>{ "row" =>2, "col" => 1, "status" => "available"},
				$pla_id++ =>{ "row" =>2, "col" => 2, "status" => "reserved"},
			},
			$sec_id++=>{ 
				$pla_id++ =>{ "row" =>2, "col" => 1, "status" => "available"},
				$pla_id++ =>{ "row" =>2, "col" => 2, "status" => "available"},
				$pla_id++ =>{ "row" =>2, "col" => 3, "status" => "available"},
				$pla_id++ =>{ "row" =>2, "col" => 4, "status" => "buyed"},
			},
			$sec_id++=>{ 
				$pla_id++ =>{ "row" =>3, "col" => 1, "status" => "available"},
				$pla_id++ =>{ "row" =>3, "col" => 1, "status" => "buyed"},
				$pla_id++ =>{ "row" =>3, "col" => 1, "status" => "available"},
				$pla_id++ =>{ "row" =>3, "col" => 1, "status" => "buyed"},
			},
			$sec_id++=>{ 
				$pla_id++ =>{ "row" =>4, "col" => 1, "status" => "available"},
				$pla_id++ =>{ "row" =>4, "col" => 1, "status" => "reserved"},
				$pla_id++ =>{ "row" =>4, "col" => 2, "status" => "available"},
				$pla_id++ =>{ "row" =>4, "col" => 2, "status" => "buyed"},
			}			
		}
	};

	$c->stash->{location_id} = $location_id;
	#$c->stash->{locations} = $sectors->{location_id};
	#$c->stash->{locations} = $sectors[$location_id];
	$c->stash->{locations} = \@sectors;
	#$c->stash->{locations} = $sectors[0]->{location_id};
	#$c->stash->{locations} = $sectors[0]->{$location_id};
	#$c->stash->{locations} = $sectors[0][location_id];
	$c->forward('View::JSON');
}
	

1;