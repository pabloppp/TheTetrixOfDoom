

public class Timer{
  
  Handler handler;
  int initMillis;
  boolean done = false;
  float doafterSeconds;
  
  Timer(){
    initMillis = millis();  
  }
  
  void doAfter(float seconds, Handler h){
    doafterSeconds = seconds;
    handler = h;
  }
  
  void run(){
    if(handler != null && !done){
      if(millis()-initMillis > doafterSeconds*1000){
        handler.run();       
        done = true;
      }
    }
  }
  
  void restart(){
    done = false;
    initMillis = millis();
  }
  
}

public class Handler{
  void run(){
    //DO NOTHING    
  }
}