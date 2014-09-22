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

Player head;
Syncer syncer;

public String MODE;

//het gaat vanuit een woordenlijst
//woord => tijd. zoiets:

ArrayList<ArrayList<String[]>> SyncData = new ArrayList<ArrayList<String[]>>();
ArrayList<String[]> words = new ArrayList<String[]>();

void setup()
{
  //constructor, basic setup
  frameRate(FRAMERATE); //makkelijker rekenen, 60 / 2 = 30 of 120 / 4 = 30  
  size(1000, 1000);  
 
  RG.init(this);
  CURRENT = RG.getText("Hello world!", "FreeSans.ttf", 72, CENTER);
 
  head = new Player();
  syncer = new Syncer();
 
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
  //draw menu
  if(MODE == null)
  {
    //draw buttons for program control
    fill(#FFFFFF);
    
    rect(200.0,200.0,300.0,100.0);
    rect(200.0,400.0,300.0,100.0);
    rect(200.0,600.0,300.0,100.0);
 
    textSize(32);
    fill(0, 102, 153);
    text("Synchronize it!", 220, 250); 
    text("Play it! \\m/", 220, 450);
    text("Exit :-(", 220, 650);    
  }  
  
  if(MODE == "SYNC")
  {
    syncer.draw();
  }
  
  if(MODE == "PLAY")
  {
    head.draw();
  }
}

void mouseClicked()
{
  if((mouseX < 500.0 && mouseX > 200.0) && mouseY < 300.0 && mouseY >200.0)
  {
    //sync button
    println("sync button");
  }
  
  
  if((mouseX < 500.0 && mouseX > 200.0) && mouseY < 500.0 && mouseY > 400.0)
  {
    //sync button
    println("play button");
  }
  
  
  if((mouseX < 500.0 && mouseX > 200.0) && mouseY < 700.0 && mouseY > 600.0)
  {
    //sync button
    println("exit :-( button");
  }
}

void keyPressed()
{
        
}

public class Player
{
  Player()
  {
    
  }
  
  public void draw()
  {
    translate(width / 2, height / 2);
    
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
    
        float nextTime = Float.valueOf(nextWord[1].toString()).floatValue(); //lol
       
        CURRENT.draw();        
        
        if(REAL_TIME == nextTime) 
        {   
          CURRENT = RG.getText(String.valueOf(nextWord[0]), "FreeSans.ttf", 72, CENTER);
          
          //nu gebruik ik dit om de text te clearen, moet anders... 
          background(#D5A500);
          
          //deze 3 regels staan nu in keyPressed... maar moet apart van de sync komen natuurlijk
          wordIndex++;
          
          prevWord = words.get(wordIndex - 1);
          nextWord = words.get(wordIndex);            
        }       
    }   
  }
  
  public void keyPressed()
  {
    switch(key)
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
    }
  }
  
}

public class Syncer
{
  Syncer()
  {
    //
  }
  
  public void draw()
  {
    
  }
  
  public void syncKeyPressed()
  {
    switch(key)
    {
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
      
      case '0': //E snaar 0 fret
        println(" == 0 == E snaar fret 0");
      break; 
      
      case '3':
        print(" == 3 == E snaar fret 3");
      break;
      
      case '5':
        println(" == 5 == E snaar fret 5");
      break;
      
      case '7':
        println(" == 9 == E snaar fret 9");
      break;
      
      case '9':
      break;
    }
  }
}


