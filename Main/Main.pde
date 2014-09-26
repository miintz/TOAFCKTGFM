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

ArrayList<Object[]> SyncData = new ArrayList<Object[]>();

String SYNC_MODE = "intro";
String SYNC_INST = ""; 

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
}

Object[] prevWord;
Object[] nextWord;

void draw()
{ 
  //draw menu
  if (MODE == null)
  {
    //draw buttons for program control
    fill(#FFFFFF);

    rect(200.0, 200.0, 300.0, 100.0);
    rect(200.0, 400.0, 300.0, 100.0);
    rect(200.0, 600.0, 300.0, 100.0);

    textSize(32);
    fill(0, 102, 153);
    
    text("Synchronize it!", 220, 250); 
    text("Play it!", 220, 450);
    text("Exit :-(", 220, 650);
  }  

  if (MODE == "sync")
  {
    syncer.draw();
  }

  if (MODE == "play")
  {
    head.draw();
  }
}

void mouseClicked()
{
  if (MODE == null)
  {
    if ((mouseX < 500.0 && mouseX > 200.0) && mouseY < 300.0 && mouseY > 200.0)
    {
      //sync button
      println("sync button");
      MODE = "sync";
      SYNC_MODE = "intro";
      background(#dddddd);
    }


    if ((mouseX < 500.0 && mouseX > 200.0) && mouseY < 500.0 && mouseY > 400.0)
    {
      MODE = "play";
      println("play button");
    }


    if ((mouseX < 500.0 && mouseX > 200.0) && mouseY < 700.0 && mouseY > 600.0)
    {
      //exit button      
      println("bye bye :(");
      exit();
    }
  } else if (MODE == "sync")
  {
    syncer.mouseClicked();
  }
}

void keyPressed()
{
  println("Key pressed " + MODE + "  " + SYNC_MODE);
  if(MODE == "sync")
  {
    if(SYNC_MODE == "syncing")
    {
      syncer.syncKeyPressed();
    }  
  }
}

public class Player
{
  Player()
  {
  }

  public void draw()
  {
    translate(width / 2, height / 2);

    //    if (TIMER_RUNNING)
    //    {               
    //      TIMER += 0.25; // 30.0 / FRAMERATE     
    //      REAL_TIME = TIMER / 30.0; //this is the actual seconds i think, depends on framerate and the gods of metal
    //      
    //      //float nextTime = Float.valueOf(nextWord[1].toString()).floatValue(); //lol
    //
    //      //CURRENT.draw();        
    //
    //      if (REAL_TIME == nextTime) 
    //      {   
    //        CURRENT = RG.getText(String.valueOf(nextWord[0]), "FreeSans.ttf", 72, CENTER);
    //
    //        //nu gebruik ik dit om de text te clearen, moet anders... 
    //        background(#D5A500);
    //
    //        //deze 3 regels staan nu in keyPressed... maar moet apart van de sync komen natuurlijk
    //       // wordIndex++;
    //
    //        prevWord = words.get(wordIndex - 1);
    //        nextWord = words.get(wordIndex);
    //      }
    //    }
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
  }

  public void draw()
  {
    if (SYNC_MODE == "intro")
    {
      background(#FFFFFF);

      textSize(14);

      text("Select instrument or something:", 100, 50);

      textSize(16);

      text("Lyics", 100, 200);
      text("Guitar", 100, 300);
      text("Drums", 100, 400);
      text("Other", 100, 500);      

      textSize(14);
    }
    if (SYNC_MODE == "syncing")
    {
      background(#FFFFFF);

      textSize(14);
  
      text("Press the keys you wish to use for " + SYNC_INST, 100, 50);
            
      for (int i = 0; i < SyncData.size(); i++) //dit werkt niet met toevoegen van de toetsen, moet in deze loop gebeuren ipv de loop inb keypressed
      {
        Object[] insdata = SyncData.get(i);
        if (insdata[0] == SYNC_INST)
        {          
          ArrayList<String> insync = (ArrayList<String>)insdata[1];
          for(int o = 0; o < insync.size(); i++)
          {
            text(insync.get(o), 100, 150 + (o * 50));
          }
        }       
      }
    }
  }

  public void mouseClicked()
  {
    if (SYNC_MODE == "intro")
    {
      float x = mouseX;
      float y = mouseY;      

      if ((x > 100 && x < 200) && (y > 175 && y < 200))
        SYNC_INST = "lyrics";  
      if ((x > 100 && x < 200) && (y > 275 && y < 300))
        SYNC_INST = "guitar";
      if ((x > 100 && x < 200) && (y > 375 && y < 400))
        SYNC_INST = "drums";
      if ((x > 100 && x < 200) && (y > 475 && y < 500))
        SYNC_INST = "other";

      //maak een lijst voor het gekozen instrument 
      Object[] insdata = new Object[2];
      insdata[0] = SYNC_INST;
      insdata[1] = new ArrayList<String>();            
      
      SyncData.add(insdata);
      
      SYNC_MODE = "syncing";
    } 
    else if (SYNC_MODE == "syncing")
    {
      //hier iets?
    }
  }

  public void syncKeyPressed()
  {
    if (SYNC_MODE == "syncing")
    {
      //moet ik eerst de juiste lijst zien te vinden
      Object[] insdata = null;
      int i = 0;       
      
      for (i = 0; i < SyncData.size (); i ++)
      {
        insdata = SyncData.get(i);
        
        if (insdata[0] == SYNC_INST) {
          break;       
        }
      }
      
      //voeg keyCode of key toe?
      ArrayList<String> insync = (ArrayList<String>)insdata[1];
      
      insync.add(Character.toString(key));
      insdata[1] = insync;
      
      SyncData.remove(i);      
      SyncData.add(insdata);      
      
      println("size: " + insync.size());
    }
    
    println("Hier?");
  }
}

