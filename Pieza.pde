

class Block{
  
  PVector position;
  int type = 0; //0:blue, 1:red, 2:yellow, 3:purple
  
  Block(int px, int py, int type){
    position  = new PVector(px, py); 
    this.type = type;
  }
  
  Block(int px, int py){
    this(px, py, floor(random(0,4)));
  }
  
  void draw(){
  
    rectMode(CENTER);
    rect(position.x, position.y, 16*pixSize, 16*pixSize);
    
  }
  
  
  
}