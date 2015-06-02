
float pieceSpeed = 10;

class Block{
  
  PVector position;
  int type = 0; //0:blue, 1:red, 2:yellow, 3:purple
  int variation = 0; //0-->4
    
  Block(int px, int py, int type, int variation){
    position  = new PVector(px, py); 
    this.type = type;
    this.variation = variation;
    
  }
  
  Block(int px, int py){
    this(px, py, floor(random(0,4)), floor(random(0,5)));
  }
  
  void draw(){
  
    imageMode(CENTER);
    //rect(position.x, position.y, 16*pixSize, 16*pixSize);
    
    if(type <= 3){
      int whatBlock = type*5 + variation;
      image(blocks.get(whatBlock), position.x, position.y, 16*pixSize, 16*pixSize);
    } 
        
  }
  
  void drawTris(){
    imageMode(CENTER); 
    
    if(type <= 3){
      int whatBlock = type*5 + variation;
      float pX = map(position.x, 0, 16, blockH*6, blockH*6 + blockH/4);
      float pY = map(position.y, 0, 16, 0, blockH/4);
      image(blocks.get(whatBlock), pX, pY, blockH, blockH);
      //image(blocks.get(whatBlock), position.x, position.y, 16*pixSize, 16*pixSize);
    }
  }
  
  void move(float x, float y){
    position.x += x;
    position.y += y;
  }
  
}

public class Piece{
  
  int forma = 0; //0: barra 1:cuadrado, 2:L, 3:J 4:S, 5:Z 6:T
  
  ArrayList<Block> bloques = new ArrayList<Block>();
  
  PVector position = new PVector(16*pixSize*10/2 - pixSize*8 , -16*pixSize*2);
  
  Piece(int forma){
    this.forma = forma;
    int col = floor(random(0, 4));
    int shape = floor(random(0, 5));
      
    if(forma == 0){    //DIBUJAMOS LA BARRA   
      bloques.add(new Block(int(position.x), int(position.y-24*pixSize), col, shape));
      bloques.add(new Block(int(position.x), int(position.y-8*pixSize), col, shape));
      bloques.add(new Block(int(position.x), int(position.y+8*pixSize), col, shape));
      bloques.add(new Block(int(position.x), int(position.y+24*pixSize), col, shape));    
    }
    else if(forma == 1){
      
      position = new PVector(16*pixSize*10/2 , -16*pixSize*2);
      
      bloques.add(new Block(int(position.x-8*pixSize), int(position.y-8*pixSize), col, shape));
      bloques.add(new Block(int(position.x-8*pixSize), int(position.y+8*pixSize), col, shape));
      bloques.add(new Block(int(position.x+8*pixSize), int(position.y-8*pixSize), col, shape));
      bloques.add(new Block(int(position.x+8*pixSize), int(position.y+8*pixSize), col, shape));
    }
    else if(forma == 2){
      bloques.add(new Block(int(position.x), int(position.y+8*pixSize), col, shape));
      bloques.add(new Block(int(position.x-16*pixSize), int(position.y+8*pixSize), col, shape));
      bloques.add(new Block(int(position.x+16*pixSize), int(position.y+8*pixSize), col, shape));
      bloques.add(new Block(int(position.x+16*pixSize), int(position.y-8*pixSize), col, shape));
    }
    else if(forma == 3){
      bloques.add(new Block(int(position.x), int(position.y-8*pixSize), col, shape));
      bloques.add(new Block(int(position.x-16*pixSize), int(position.y-8*pixSize), col, shape));
      bloques.add(new Block(int(position.x+16*pixSize), int(position.y-8*pixSize), col, shape));
      bloques.add(new Block(int(position.x+16*pixSize), int(position.y+8*pixSize), col, shape));
    }
    else if(forma == 4){
      bloques.add(new Block(int(position.x), int(position.y-8*pixSize), col, shape));
      bloques.add(new Block(int(position.x), int(position.y+8*pixSize), col, shape));
      
      bloques.add(new Block(int(position.x+16*pixSize), int(position.y-8*pixSize), col, shape));
      bloques.add(new Block(int(position.x-16*pixSize), int(position.y+8*pixSize), col, shape));
    }
    else if(forma == 5){
      bloques.add(new Block(int(position.x), int(position.y-8*pixSize), col, shape));
      bloques.add(new Block(int(position.x), int(position.y+8*pixSize), col, shape));
      
      bloques.add(new Block(int(position.x+16*pixSize), int(position.y+8*pixSize), col, shape));
      bloques.add(new Block(int(position.x-16*pixSize), int(position.y+8*pixSize), col, shape));
    }
  }
  
  Piece(){ 
    this(floor(random(0, 5)));
  }
  
  void drawTris(){
    
    for(Block block : bloques){
      block.drawTris();
      if(!isPlaced()) block.move(0, pieceSpeed);
    }
    
    if(!isPlaced()) position.y += pieceSpeed;
    
  }
  
  void move(float x, float y){   
    for(Block block : bloques){
      block.move(x, y);
    }
    
    position.x += x;
    position.y += y;
  }
  
  boolean canMoveLeft(){
    for(Block block : bloques){
      if(block.position.x <= 8*pixSize) return false;
      
      int matrixPosX = floor((block.position.x-8*pixSize) / (16*pixSize));
      int matrixPosY = floor((block.position.y-8*pixSize) / (16*pixSize));
      if(matrixPosY >= 0 && matrixPosX >  0 && grid[matrixPosY+1][matrixPosX-1] != null) return false;
    }
    return true;  
  }
  
  boolean canMoveRight(){
    for(Block block : bloques){
      if(block.position.x >= 16*pixSize*9.5) return false;
      
      int matrixPosX = floor((block.position.x-8*pixSize) / (16*pixSize));
      int matrixPosY = floor((block.position.y-8*pixSize) / (16*pixSize));
      if(matrixPosY >= 0 && matrixPosX < grid[0].length-1 && grid[matrixPosY+1][matrixPosX+1] != null) return false;
    }
    return true;  
  }
  
  boolean isPlaced(){
    for(Block block : bloques){
      int matrixPosX = floor((block.position.x-8*pixSize) / (16*pixSize));
      int matrixPosY = floor((block.position.y-8*pixSize) / (16*pixSize));
      if(matrixPosY >= 19) return true;
      else if(matrixPosY >= 0 && grid[matrixPosY+1][matrixPosX] != null) return true;
    }
    return false;  
  }
  
  void draw(){
   
    
    
  }
  
  
  
}