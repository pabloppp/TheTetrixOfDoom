
int blockH = 0;

boolean moving;
float movePixels = 0;

boolean rotating;
float rotateAngle = 0;

float rotateSpeed = 20;

float horizontalSpeed = 16;

Piece currentPiece;

Timer newPieceTimer = new Timer();

void setupPlayTetris(){
  println("SETUP TETRIS");
  newPieceTimer.doAfter(3, new Handler(){
    @Override
    public void run(){
      currentPiece = new Piece();
      println("newPiece");
    }
  });  
}

void playTetris(){
  newPieceTimer.run();
  tetrisBG();
  
  for(int i=0;i<grid.length;i++){
    for(int j=0;j<grid[i].length;j++){
      if(grid[i][j] != null){
        grid[i][j].drawTris();
      }
    }
  }
  
  if(currentPiece != null){
    currentPiece.drawTris();
    
    if(rotating){
      
      rotateAngle -= rotateSpeed; 
      if(rotateAngle <= 0) rotating = false;
    }
    
    if(moving){
      
      float lastMovement = movePixels;
      
      if(lastMovement < 0){
        movePixels += horizontalSpeed;
        currentPiece.move(horizontalSpeed, 0);
      }
      else {
        movePixels -= horizontalSpeed;
        currentPiece.move(-horizontalSpeed, 0);
      }
      
      if(abs(movePixels) < pixSize) movePixels = 0;
      
      if(movePixels == 0 || lastMovement*movePixels < 0){
        moving = false;
        
      }
      
      return;
      
    }
    
    if(currentPiece.isPlaced()){
      for(Block block : currentPiece.bloques){
        int gridX = round((block.position.x-8*pixSize) / (16*pixSize));
        int gridY = round((block.position.y-8*pixSize) / (16*pixSize));
        grid[gridY][gridX] = block;
        block.position.x = gridX*16*pixSize + 8*pixSize;
        block.position.y = gridY*16*pixSize + 8*pixSize;
      }
      currentPiece = null;
      newPieceTimer.restart();
      return;
    }
    
    if(keyPressed){
      if(!moving && !rotating && keyCode == LEFT && currentPiece.canMoveLeft()){
        moving = true;
        movePixels = 16*pixSize;
      }
      else if(!moving && !rotating && keyCode == RIGHT && currentPiece.canMoveRight()){
        moving = true;
        movePixels = -16*pixSize;
      }
      
      if(!moving && !rotating && key == ' '){
        rotating = true;
        rotateAngle = 90;
      }
    }
   
    
  }
  
}

void tetrisBG(){
  
  background(54, 54, 42);
  
  blockH = height / (grid.length+1);
  
  int Xdisp = blockH*6;
  
  for(int i=0;i<grid.length;i++){
    
    tint(255);
    image(blocks.get(20), Xdisp-blockH/2, blockH*i + blockH/2, blockH, blockH);
    
    image(blocks.get(20), Xdisp + blockH/2 + grid[i].length*blockH, blockH*i + blockH/2, blockH, blockH);
    
    tint(150);
    for(int j=0;j<grid[i].length;j++){
      imageMode(CENTER);
      image(blocks.get(22), Xdisp + blockH*j + blockH/2, blockH*i + blockH/2, blockH, blockH);
    }    
  }
  
  tint(255);
  for(int i=0;i<grid[0].length+2;i++){
    image(blocks.get(20), Xdisp-blockH/2 + i*blockH , blockH*grid.length + blockH/2, blockH, blockH);     
    image(blocks.get(20), Xdisp-blockH/2 + i*blockH , blockH*grid.length + blockH*1.5, blockH, blockH); 
  }
  
}