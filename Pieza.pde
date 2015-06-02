

class Block{
  
  PVector position;
  int type = 0; //0:blue, 1:red, 2:yellow, 3:purple
  int variation = 0;
  
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
    image(blocks.get(1), position.x, position.y, 16*pixSize, 16*pixSize);
    
  }
  
  
  
}