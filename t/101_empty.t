#!/usr/bin/perl

use strict;
use warnings;
use utf8;
use Test::More tests => 3;

use App::Music::ChordPro::Config;
use App::Music::ChordPro::Songbook;

our $config = App::Music::ChordPro::Config::configurator;
# Prevent a dummy {body} for chord grids.
$config->{diagrams}->{show} = 0;

my $s = App::Music::ChordPro::Songbook->new;

my $data = <<EOD;
EOD

eval { $s->parsefile(\$data); 1 } or diag("$@");

ok( scalar( @{ $s->{songs} } ) == 1, "One song" );
isa_ok( $s->{songs}->[0], 'App::Music::ChordPro::Song', "It's a song" );

my $song = {
	    'settings' => {},
	    'structure' => 'linear'
	   };

is_deeply( { %{ $s->{songs}->[0] } }, $song, "Song contents" );
