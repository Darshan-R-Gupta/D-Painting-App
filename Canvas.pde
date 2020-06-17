class Canvas{
  PVector loc;  //Upper left position;
  float w,h;
  color back_col;  //Background_ color;

  Canvas(float x, float y,float wid, float hei, color c){
    loc = new PVector(x,y);
    w = wid;
    h = hei;
    back_col = c;
  }
  void display(){
    noStroke();
    fill(back_col);
    rectMode(CORNER);
    rect(loc.x, loc.y, w,h);
  }
  boolean checkEraserInside(float wid, float hei){  //Thickness of the current eraser;
    if(mouseX > loc.x+wid/2 && mouseX < loc.x+w-wid/2 && mouseY > loc.y+hei/2 && mouseY < loc.y +h-hei/2){  
      return true;    //Here w and h are width and height of the canvas;
    }
    return false;
  }
  boolean checkBrushInside(float wid, float hei){  //Thickness of the current stroke
    if(mouseX > loc.x+wid/2 && mouseX < loc.x+w-wid/2 && mouseY > loc.y+hei/2 && mouseY < loc.y +h-hei/2){  
      return true;    //Here w and h are width and height of the canvas;
    }
    return false;
    
  }
}
