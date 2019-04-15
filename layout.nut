class UserConfig {
</ label="--------  Main theme layout  --------", help="Wheel options", order=1 /> uct1="select below";
   </ label="Select spinwheel art", help="The artwork to spin", options="wheel", order=5 /> orbit_art="wheel";
   </ label="Wheel transition time", help="Time in milliseconds for wheel spin.", order=6 /> transition_ms="25";
}

local my_config = fe.get_config();

//
// Attract-Mode Front-End
// Waveshare Game HAT theme
//

// Modules
fe.load_module("fade");
fe.load_module( "animate" );
fe.load_module( "conveyor" );

// Screen size
local flx = fe.layout.width;
local fly = fe.layout.height;
local flw = fe.layout.width;
local flh = fe.layout.height;

// Background image
local background = fe.add_image( "black.png", 0, 0, flw, flh );

// Video snap
local snap = fe.add_artwork( "snap", flx*0.007, fly*0.025, flw*0.69, fly*0.69 );
snap.trigger = Transition.EndNavigation;
//snap.preserve_aspect_ratio = true;

// Game information

//Title text info
local textt = fe.add_text( "[Title]", flx*0.125, fly*0.82, flw*0.6, flh*0.0475  );
textt.set_rgb( 225, 255, 255 );
textt.align = Align.Left;
textt.rotation = 0;
textt.word_wrap = false;

//Emulator text info
local textemu = fe.add_text( "[Emulator]", flx* 0.125, fly*0.87, flw*0.6, flh*0.0475  );
textemu.set_rgb( 225, 255, 255 );
textemu.align = Align.Left;
textemu.rotation = 0;
textemu.word_wrap = false;

//display listsize info
local listsizea = fe.add_text( "Game Count:", flx*0.125, fly*0.92, flw*0.6, flh*0.0475 );
local listsizeb = fe.add_text( "[ListEntry]-[ListSize]", flx*0.32, fly*0.92, flw*0.6, flh*0.0475 );
listsizea.set_rgb( 255, 255, 255 );
listsizeb.set_rgb( 255, 255, 255 );
listsizea.align = Align.Left;
listsizeb.align = Align.Left;
listsizea.rotation = 0;
listsizeb.rotation = 0;
listsizea.word_wrap = false;
listsizeb.word_wrap = false;

// Genre icon
local glogo1 = fe.add_image("glogos/unknown1.png", flx*0.02, fly*0.815, flw*0.1, flh*0.15);
glogo1.trigger = Transition.EndNavigation;

class GenreImage1
{
    mode = 2;       //0 = first match, 1 = last match, 2 = random
    supported = {
        //filename : [ match1, match2 ]
        "action": [ "action","gun", "climbing" ],
        "adventure": [ "adventure" ],
        "arcade": [ "arcade" ],
        "casino": [ "casino" ],
        "computer": [ "computer" ],
        "console": [ "console" ],
        "collection": [ "collection" ],
        "fighter": [ "fighting", "fighter", "beat-'em-up" ],
        "handheld": [ "handheld" ],
        "platformer": [ "platformer", "platform" ],
        "mahjong": [ "mahjong" ],
        "maze": [ "maze" ],
        "paddle": [ "breakout", "paddle" ],
        "puzzle": [ "puzzle" ],
	"pinball": [ "pinball" ],
	"quiz": [ "quiz" ],
	"racing": [ "racing", "driving","motorcycle" ],
        "rpg": [ "rpg", "role playing", "role-playing" ],
	"rhythm": [ "rhythm" ],
        "shooter": [ "shooter", "shmup", "shoot-'em-up" ],
	"simulation": [ "simulation" ],
        "sports": [ "sports", "boxing", "golf", "baseball", "football", "soccer", "tennis", "hockey" ],
        "strategy": [ "strategy"],
        "utility": [ "utility" ]
    }

    ref = null;
    constructor( image )
    {
        ref = image;
        fe.add_transition_callback( this, "transition" );
    }
    
    function transition( ttype, var, ttime )
    {
        if ( ttype == Transition.ToNewSelection || ttype == Transition.ToNewList )
        {
            local cat = " " + fe.game_info(Info.Category, var).tolower();
            local matches = [];
            foreach( key, val in supported )
            {
                foreach( nickname in val )
                {
                    if ( cat.find(nickname, 0) ) matches.push(key);
                }
            }
            if ( matches.len() > 0 )
            {
                switch( mode )
                {
                    case 0:
                        ref.file_name = "glogos/" + matches[0] + "1.png";
                        break;
                    case 1:
                        ref.file_name = "glogos/" + matches[matches.len() - 1] + "1.png";
                        break;
                    case 2:
                        local random_num = floor(((rand() % 1000 ) / 1000.0) * ((matches.len() - 1) - (0 - 1)) + 0);
                        ref.file_name = "glogos/" + matches[random_num] + "1.png";
                        break;
                }
            } else
            {
                ref.file_name = "glogos/unknown1.png";
            }
        }
    }
}
GenreImage1(glogo1);

// Wheel

fe.load_module( "conveyor" );

local wheel_x = [ flx*0.8, flx* 0.8, flx* 0.8, flx* 0.8, flx* 0.8, flx* 0.8, flx* 0.73, flx* 0.8, flx* 0.8, flx* 0.8, flx* 0.8, flx* 0.8, ]; 
local wheel_y = [ -fly*0.22, -fly*0.105, fly*0.0, fly*0.105, fly*0.215, fly*0.325, fly*0.420, fly*0.60, fly*0.700 fly*0.795, fly*0.910, fly*0.99, ];
local wheel_w = [ flw*0.13, flw*0.13, flw*0.13, flw*0.13, flw*0.13, flw*0.13, flw*0.26, flw*0.13, flw*0.13, flw*0.13, flw*0.13, flw*0.13, ];
local wheel_a = [  255,  255,  255,  255,  255,  255, 255,  255,  255,  255,  255,  255, ];
local wheel_h = [  flh*0.102,  flh*0.102,  flh*0.102,  flh*0.102,  flh*0.102,  flh*0.102, flh*0.190,  flh*0.102,  flh*0.102,  flh*0.102,  flh*0.102,  flh*0.102, ];
local wheel_r = [  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ];
local num_arts = 8;

class WheelEntry extends ConveyorSlot
{
	constructor()
	{
		base.constructor( ::fe.add_artwork( my_config["orbit_art"] ) );
                preserve_aspect_ratio = true;
	}

	function on_progress( progress, var )
	{
		local p = progress / 0.1;
		local slot = p.tointeger();
		p -= slot;
		
		slot++;

		if ( slot < 0 ) slot=0;
		if ( slot >=10 ) slot=10;

		m_obj.x = wheel_x[slot] + p * ( wheel_x[slot+1] - wheel_x[slot] );
		m_obj.y = wheel_y[slot] + p * ( wheel_y[slot+1] - wheel_y[slot] );
		m_obj.width = wheel_w[slot] + p * ( wheel_w[slot+1] - wheel_w[slot] );
		m_obj.height = wheel_h[slot] + p * ( wheel_h[slot+1] - wheel_h[slot] );
		m_obj.rotation = wheel_r[slot] + p * ( wheel_r[slot+1] - wheel_r[slot] );
		m_obj.alpha = wheel_a[slot] + p * ( wheel_a[slot+1] - wheel_a[slot] );
	}
};

local wheel_entries = [];
for ( local i=0; i<num_arts/2; i++ )
	wheel_entries.push( WheelEntry() );

local remaining = num_arts - wheel_entries.len();

// we do it this way so that the last wheelentry created is the middle one showing the current
// selection (putting it at the top of the draw order)
for ( local i=0; i<remaining; i++ )
	wheel_entries.insert( num_arts/2, WheelEntry() );

conveyor <- Conveyor();
conveyor.set_slots( wheel_entries );
conveyor.transition_ms = 50;
try { conveyor.transition_ms = my_config["transition_ms"].tointeger(); } catch ( e ) { }



