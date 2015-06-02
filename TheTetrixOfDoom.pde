import processing.net.*;
float pixSize = 4;

//GLOBAL STATES
public enum Scenes{
  SPLASH,
  //MAINMENU
  MAINMENU_MAIN, //main options
  MAINMENU_SINGLE, //single player options
  MAINMENU_MULTI, //multiplayer options
  MAINMENU_HOST,
  MAINMENU_JOIN,
  //PLAY
  PLAY_TETRIS,
  PLAY_PLATFORM,
  GAMEOVER
  
}

Scenes scene = Scenes.PLAY_TETRIS;

PImage blockTileset;
ArrayList<PImage> blocks;

void setup(){
  
   size(int(15*16*pixSize), int(15*10*pixSize));
   noStroke();
   noSmooth();
   
   blocks = new ArrayList<PImage>();
   
   blockTileset = loadImage("tiles.png");
   println(blockTileset.width);
   for(int i=0; i<floor(blockTileset.height/16); i++){
     for(int j=0; j<floor(blockTileset.width/16); j++){
       blocks.add( blockTileset.get(j*16, i*16, 16, 16) ); 
     }
   }
  
}

Block testblock = new Block(100, 100, 0);

void draw(){
  
  background(0);
  
  testblock.draw();
  
  if(scene == Scenes.PLAY_TETRIS) playTetris();
  
}