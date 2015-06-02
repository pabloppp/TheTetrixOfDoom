import processing.net.*;
float pixSize = 4;

Block grid[][] = new Block[20][10];  //10x20 tiles

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
Scenes scene;

PImage blockTileset;
ArrayList<PImage> blocks;

void setup(){
  
   size(int(15*16*pixSize), int(15*10*pixSize));
   noStroke();
   noSmooth();
   
   frameRate(30);
   
   blocks = new ArrayList<PImage>();
   
   blockTileset = loadImage("tiles.png");
   println(blockTileset.width);
   for(int i=0; i<floor(blockTileset.height/16); i++){
     for(int j=0; j<floor(blockTileset.width/16); j++){
       blocks.add( blockTileset.get(j*16, i*16, 16, 16) ); 
     }
   }
   
   setScene(Scenes.PLAY_TETRIS);
   
}


void draw(){
  
  background(0);
 
  if(scene == Scenes.PLAY_TETRIS) playTetris();
  if(scene == Scenes.PLAY_PLATFORM) playPlatform();
  
  text("FPS: "+int(frameRate), width-50, height-10);
  
}

void setScene(Scenes s){
  if(s == Scenes.PLAY_TETRIS) setupPlayTetris();
  if(s == Scenes.PLAY_PLATFORM) setupPlayPlatform();
  scene = s;  
}