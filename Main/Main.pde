//Hi and welcome to TOAFCKTGFM. Be careful ok?

//import some libs, we're gonna need them.
import geomerative.*;

import ddf.minim.*;

import g4p_controls.*;

import shapes3d.utils.*;
import shapes3d.animation.*;
import shapes3d.*;

Minim minim;
AudioPlayer player;
AudioInput input;

float TIMER = 0.0;
float REAL_TIME = 0.0;

boolean TIMER_RUNNING = false;
boolean MUSIC_PLAYING = false;

public static final int FRAMERATE = 120;
public static String SONG = "omerta.mp3"; // \m/

void setup()
{
  //constructor  
  frameRate(FRAMERATE); //makkelijker rekenen, 60 / 2 = 30
  
  size(1000, 1000);
 
  minim = new Minim(this);
 
  //play song! \m/
  player = minim.loadFile("res/music/" + SONG);
 
  
}

//het gaat vanuit een woordenlijst
//woord => tijd

void draw()
{
    //realtime of render?
    //laad muziek en afspelen?
    if(TIMER_RUNNING)
    {
        TIMER += 0.25;
    }
    
    REAL_TIME = TIMER / 30.0; 
}

void keyPressed()
{
    if(!MUSIC_PLAYING)
    {
        println("\r\n");
        println("\r\n");
        
        println("== \\m/(-.-)\\m/ ==");
        println("== PLAYING MUSIC: " + SONG + "==");
        println("== \\m/(-.-)\\m/ ==");
        
        println("\r\n");
        println("\r\n");
        
        player.play();
        TIMER_RUNNING = true;
        MUSIC_PLAYING = true;
    }
}


