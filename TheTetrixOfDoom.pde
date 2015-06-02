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

void setup(){
  
   size(int(15*16*pixSize), int(15*10*pixSize));
   noStroke();
  
}

Block testblock = new Block(100, 100, 0);

void draw(){
  
  background(0);
  
  testblock.draw();
  
  if(scene == Scenes.PLAY_TETRIS) playTetris();
  
}