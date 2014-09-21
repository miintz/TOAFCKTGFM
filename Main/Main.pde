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

int wordIndex = 0;

boolean TIMER_RUNNING = false;
boolean MUSIC_PLAYING = false;

public static final int FRAMERATE = 120;
public static final String SONG = "omerta.mp3"; //make this configurable somehow \m/

RShape CURRENT;

//het gaat vanuit een woordenlijst
//woord => tijd. zoiets:

ArrayList<Object[]> words = new ArrayList<Object[]>();

void setup()
{
  //constructor, basic setup
  frameRate(FRAMERATE); //makkelijker rekenen, 60 / 2 = 30 of 120 / 4 = 30  
  size(1000, 1000);  
 
  RG.init(this);
  CURRENT = RG.getText("Hello world!", "FreeSans.ttf", 72, CENTER);
 
  minim = new Minim(this); 
  //load song! \m/ 
  player = minim.loadFile("res/music/" + SONG);
 
 
   
  //add some words
  String[] word = new String[2];
  word[0] = "Whoever";
  word[1] = "1.00";   
  words.add(word); 
  
  word = new String[2];
  word[0] = "appeals";
  word[1] = "1.50";   
  words.add(word);
  
  word = new String[2];
  word[0] = "to";
  word[1] = "2.00";   
  words.add(word);
  
  word = new String[2];
  word[0] = "the";
  word[1] = "2.50";   
  words.add(word);
  
  word = new String[2];
  word[0] = "laws";
  word[1] = "3.00";   
  words.add(word);
  
  word = new String[2];
  word[0] = "against";
  word[1] = "3.50";   
  words.add(word);
  
  word = new String[2];
  word[0] = "his";
  word[1] = "4.00";   
  words.add(word);
  
  word = new String[2];
  word[0] = "fellow";
  word[1] = "4.50";   
  words.add(word);
  
  word = new String[2];
  word[0] = "man";
  word[1] = "5.00";   
  words.add(word);
  
  word = new String[2];
  word[0] = "is";
  word[1] = "5.50";   
  words.add(word);
  
  word = new String[2];
  word[0] = "either";
  word[1] = "6.00";   
  words.add(word);
  
  word = new String[2];
  word[0] = "a";
  word[1] = "6.50";   
  words.add(word);
  
  word = new String[2];
  word[0] = "fool";
  word[1] = "7.00";   
  words.add(word);
  
  word = new String[2];
  word[0] = "or";
  word[1] = "7.50";   
  words.add(word);
  
  word = new String[2];
  word[0] = "a";
  word[1] = "8.00";   
  words.add(word);
  
  word = new String[2];
  word[0] = "coward";
  word[1] = "8.50";   
  words.add(word);
}

Object[] prevWord;
Object[] nextWord;

void draw()
{ 
    translate(width / 2, height / 2);
    
    //realtime of render?
    //laad muziek en afspelen?
    //hoe de fok ga je dit uberhaupt doen?
    if(TIMER_RUNNING)
    {               
        TIMER += 0.25; // 30.0 / FRAMERATE     
        REAL_TIME = TIMER / 30.0; //this is the actual seconds i think, depends on framerate and the gods of metal
        
        //start looping the array;
        if(nextWord == null)
        {
          nextWord = words.get(wordIndex);
          prevWord = words.get(wordIndex);
          
          println("setting first word: '" + nextWord[0] + "'");          
        }        
        
        //de timing is mogelijk niet af te stemmen op de framerate. dus moet een estimation maken... kan de sync verknoeien
        //dus ik heb een tijd van het woord en de huidige tijd. die komen niet overeen, maar kan kijken of het dichterbij kan komen, zo niet, weergeven
        float nextTime = Float.valueOf(nextWord[1].toString()).floatValue(); //lol
       
        //prevTime is de tijd van het woord
        //nu moet ik kijken of REAL_TIME daar dicht genoeg bij zit, hoe doe ik dat?
        
        //als ik prevTime van REAL_TIME (groter getal) af haal hou ik een getal over, als dat getal modulo framerate kleiner is dan 120 / 30 = 4 kan het niet dichterbij komen
        //of ik zorg er gewoon voor dat alles afgerond in de array gaat...
        
      
        CURRENT.draw();        
        
        if(REAL_TIME == nextTime) 
        { 
          //nu gebruik ik dit om de text te clearen, moet anders... 
          //background(#D5A500);
          
          //deze 3 regels staan nu in keyPressed... maar moet apart van de sync komen natuurlijk
          //wordIndex++;
          
          //prevWord = words.get(wordIndex - 1);
          //nextWord = words.get(wordIndex);                  
        }       
    }      
}

void keyPressed()
{
    char k = key;
    
    switch(k)
    {
      case ' ': //spacebar, start song
        println("\r\n");
        println("\r\n");
        
        println("== \\m/(-.-)\\m/ ==");
        println("== PLAYING: " + SONG + " ==");
        println("== \\m/(-.-)\\m/ ==");
        
        println("\r\n");
        println("\r\n");
                
        TIMER_RUNNING = true;
        MUSIC_PLAYING = true;
        
        wordIndex = 0;
        prevWord = null;
        nextWord = null;
        
        player.play();
      break;
      case 'v': //sync
          if(MUSIC_PLAYING)
          {
            if(wordIndex != words.size())
            {
              println(nextWord[0] + " : " + REAL_TIME);            
                 
              if(wordIndex != 0)         
                prevWord = words.get(wordIndex - 1);
                
              nextWord = words.get(wordIndex);    
              
              wordIndex++;
               
              CURRENT = RG.getText(String.valueOf(nextWord[0]), "FreeSans.ttf", 72, CENTER);  
              background(#D5A500);   
            }
            else //end of word list, restart for now
            {
              minim.stop();
              minim = new Minim(this); 
              //load song! \m/ 
              player = minim.loadFile("res/music/" + SONG);
              
              TIMER_RUNNING = false;
              MUSIC_PLAYING = false;
              
              TIMER = 0.0;
              REAL_TIME = 0.0;
            }
          }
      break;
    }    
}


