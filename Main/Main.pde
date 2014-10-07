//Hi and welcome to TOAFCKTGFM. Be careful ok?

//import some libs, we're gonna need them.
import geomerative.*;

import ddf.minim.*;

import g4p_controls.*;

import shapes3d.utils.*;
import shapes3d.animation.*;
import shapes3d.*;

import java.io.File;

Minim minim;
AudioPlayer player;
AudioInput input;

float TIMER = 0.0;
float REAL_TIME = 0.0;

int wordIndex = 0;
int countdown = 2;

boolean TIMER_RUNNING = false;
boolean MUSIC_PLAYING = false;

boolean DRAWING = false;

public static final int FRAMERATE = 120;
public static final String SONG = "torment.mp3"; //make this configurable somehow \m/

RShape CURRENT;

Player head;
Syncer syncer;
Util util;

public String MODE; //een heule belangrijke

HashMap<String,Float> Actual = new HashMap<String,Float>(); //Float dus, niet float (geen hoofdletter) want dat werkt niet 
ArrayList<Object[]> SyncData = new ArrayList<Object[]>();
ArrayList<String> UsedIntruments = new ArrayList<String>();

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
  util = new Util();

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

      MODE = "sync";
      SYNC_MODE = "intro";
      background(#dddddd);
    }

    if ((mouseX < 500.0 && mouseX > 200.0) && mouseY < 500.0 && mouseY > 400.0)
    {      
      MODE = "play";
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
  if (MODE == "sync")
  {
    if (SYNC_MODE == "syncing" || SYNC_MODE == "intro")
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

    if (TIMER_RUNNING)
    { 
      //the odd float precision thing comes into play here, i can only make approximations until i figure this out      
      TIMER += 0.25; // 30.0 / FRAMERATE     
      REAL_TIME = TIMER / 30.0; //this is the actual seconds i think, depends on framerate and the Gods of Metal

      player.play();
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
  Util util = null;
  Syncer()
  {
    util = new Util();
  }

  public void draw()
  {
    background(#FFFFFF);
    textSize(14);

    if (SYNC_MODE == "intro")
    {
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
      if (util.in_str_list(SYNC_INST, UsedIntruments))
        text(SYNC_INST + " already synced. Press F12 to return.", 100, 50);  
      else
      {     
        text("Press the keys you wish to use for " + SYNC_INST + ", press F12 to write to file and return to instrument screen.", 100, 50);

        for (int i = 0; i < SyncData.size (); i++) 
        {
          Object[] insdata = SyncData.get(i);

          if (insdata[0] == SYNC_INST)
          {                      
            ArrayList<String> insync = (ArrayList<String>)insdata[1];

            for (int o = 0; o < insync.size (); o++)
            {
              textSize(16);
              text(insync.get(o), 100, 150 + (o * 50));
            }
          }
        }
      }
    }
    if (SYNC_MODE == "song")
    {      
      if(TIMER_RUNNING)
      {        
        if(player.isPlaying())
        {
          //the odd float precision thing comes into play here, i can only make approximations until i figure this out      
          TIMER += 0.25; // 30.0 / FRAMERATE     
          REAL_TIME = TIMER / 30.0; //this is the actual seconds i think, depends on framerate and the Gods of Metal
          
          stroke(0);
          for(int i = 0; i < player.bufferSize() - 1; i++)
          {
            line(i, 50 + player.left.get(i) * 50, + 1, 50 +player.left.get(i + 1) * 50);
            line(i, 150 + player.right.get(i)*50, i+1, 150 + player.right.get(i + 1) * 50);            
          }
        }
        else
          player.play();
      }
      else
      {
        //aftellen!!
        if(frameCount % FRAMERATE == 0) // 3 2 1
        {
          if(countdown != 0)
            countdown --;
          else
          {
            TIMER_RUNNING = true;
            countdown = 2;
          }
        }
                
        text(countdown + 1, width / 2, height / 2);
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
  }

  public void syncKeyPressed()
  {    
    if (SYNC_MODE == "syncing")
    {
      if (keyCode != 123 && keyCode != 122)
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
        if (!util.in_str_list(Character.toString(key), insync))
        {
          insync.add(Character.toString(key));
          insdata[1] = insync;

          SyncData.remove(i);      
          SyncData.add(insdata);
        }
      } else
      {        
        //f12 pressed, write to a file
        File f = new File("syncdata.txt");
        if (f.exists())
          f.delete();

        PrintWriter output = createWriter("syncdata.txt");

        for (int i = 0; i < SyncData.size (); i++)
        {
          Object[] insync = SyncData.get(i);
          for (int j = 0; j < insync.length; j++)
          {
            if (j != insync.length - 1)
              output.print(insync[j]+",");
            else
              output.print(insync[j]+":");
          }
        }

        output.flush();
        output.close();

        println(SYNC_INST);
        UsedIntruments.add(SYNC_INST);

        //now return to instrument screen!!
        SYNC_MODE = "intro";

        if (keyCode == 122) //F11
        {
          SYNC_MODE = "song";
        }
      }
    } else if (SYNC_MODE == "intro")
    {
      //go back to main screen so reset the constants
      if (keyCode == 123)
      {
        background(#FFFFFF);

        SYNC_MODE = null;
        MODE = null;
      }
    }
    if (SYNC_MODE == "song")
    {
       
    }
  }
} 

public class Util
{
  Util() {
  }

  //generics plz :-(
  public boolean in_str_list(String value, ArrayList<String> list)
  {
    //check array 
    for (int i = 0; i < list.size (); i++)
    {
      //blijkbaar kan == niet bij strings, gare taal
      String aa = list.get(i);           
      if (aa.equals(value))
      {
        return true;
      }
    }

    return false;
  }

  boolean in_str_array(String value, String[] array)
  {
    //check array 
    for (int i = 0; i < array.length; i++)
    {
      if (array[i].equals(value))
      {
        return true;
      }
    }

    return false;
  }
  
  void printMultiArray(int[][] array)
  {
    //multiarray print! lovely old job.  
    println("start multi array");
    for (int y = 0; y < array.length; y++)
    {
      String print = "";    
      for (int x = 0; x < array[y].length; x++)
      {
        print = print + array[y][x] + ',';
      }
  
      println(print);
    }
    println("end multi array");
  }
}

