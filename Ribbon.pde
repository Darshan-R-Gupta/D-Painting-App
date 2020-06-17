class Ribbon{
  color back_col;
  float h;    //The height of the ribbon;
  Button inc;  //Increments the size of current stroke;
  Button dec;  //Decrements the size of current stroke;
  Button open;    //For opening any file;
  Button add;  //The address placeholder
  Button clear;  //For clearing any existing background image on the screen
  Button inc_t;//Increments the transparency
  Button dec_t; //Decrements the transparency
  Ribbon(int hei){
    back_col = color(15);
    h = hei;
    inc = new Button(width-70,50,40,15,color(#AFAFAF), "+");
    dec = new Button(width-70,70, 40,15, color(#AFAFAF),"-");
    
    add = new Button(300, int(30), 350, 20,color(100),"" ); 
    open = new Button(int(add.loc.x + add.w/2+80), int(add.loc.y), 80,20, color(#A8E33E),"Open" );
    clear = new Button(int(open.loc.x + open.w/2+60 ), int(add.loc.y), 80,20, color(#A8E33E),"Clear" );
    inc_t = new Button(width-220,50,40,15,color(#AFAFAF), "+");
    dec_t = new Button(width-220,70, 40,15, color(#AFAFAF), "-");      
 }
  void display(){
    fill(back_col);
    
    stroke(back_col);
    strokeWeight(1);
    rectMode(CORNER);
    rect(0,0,width,h);
    
    noFill();
    stroke(100);
    rectMode(CORNER);
    strokeWeight(1);
    rect(add.loc.x-add.w/2-20, add.loc.y-add.h/2 - 40, add.w + open.w + clear.w + 100, add.h+70 );

    inc.display();
    dec.display();
      
    inc_t.display();
    dec_t.display();
    
    open.display();
    clear.display();
    
    //Special method to display some buttons
    add_display();  //as we don't need hover effect  
    
    fill(100);
    stroke(100);
    strokeWeight(1);
    textSize(20);
    text("Brush Size", inc.loc.x, inc.loc.y - inc.h);
    
    text("Open Image", add.loc.x, add.loc.y+add.h + 10);
    
    line( inc.loc.x-70, 0,  inc.loc.x-70,  h);    
    
    text("Opacity",  inc_t.loc.x,  inc_t.loc.y -  inc_t.h);
    
    line( inc_t.loc.x-70, 0,  inc_t.loc.x -70,  h);
  
  }
  void update(){
    inc.update();
    dec.update();
    inc_t.update();
    dec_t.update();
    add.update();
    open.update();
    clear.update();
  }
   void open_clear_update(){
        if(mouseX > open.loc.x - open.w/2 && mouseX < open.loc.x + open.w/2 && mouseY > open.loc.y - open.h/2 && mouseY < open.loc.y + open.h/2){
          open.is_mouse_inside = true;
          if(mousePressed){
            if(open.is_clicked){
              open.is_clicked = false;
            }
            else{
              open.is_clicked = true;
            }
          }
      }
      else{
        open.is_mouse_inside = false;
      }
      
      if(mouseX > clear.loc.x - clear.w/2 && mouseX < clear.loc.x + clear.w/2 && mouseY > clear.loc.y - clear.h/2 && mouseY < clear.loc.y + clear.h/2){
          clear.is_mouse_inside = true;
          if(mousePressed){
            
            clear.is_clicked = true;
          }
      }
      else{
        clear.is_mouse_inside = false;
      }
   }
  void add_display(){  
    fill(add.c);
    rect(add.loc.x, add.loc.y, add.w,add.h); 
    noStroke();
   }
}
class Color_Ribbon{
  Color_Buttons cb;
  color back_col;  //The background color of the ribbon
  float wid;      //The width of the ribbon
  float hy;
  float hei;
  boolean is_open;  
  int circle_rad;  //The radius of the circle
  Color_Ribbon(float w, float hy_, float hei_){
    hy = hy_;
    hei = hei_;
    cb = new Color_Buttons(w,hy,hei);
    wid = w;
    circle_rad = 40;
    back_col = color(15);
    is_open=  false;  
  }
  void display(){
    if(is_open){
      fill(back_col);   
      stroke(back_col);
      strokeWeight(1);
      rectMode(CORNER);
      rect(0,hy,wid,hei);  
      cb.display();   
    }
    else{
      fill(background);
      stroke(background);
      strokeWeight(1);
      rectMode(CORNER);
      rect(0,hy+1,wid,hei);
     
      fill(cb.cur_col);
      stroke(cb.cur_col);
      strokeWeight(1);
      
      ellipse(0,height/2, 40, 40);
      fill(100);
      text(">", 0,height/2+10);
      }
  }
  void update(){
    if(mouseX < 20){
      if(mouseY > height/2 - 20 && mouseY < height/2 +20){
        is_open = true;
      }
    }
    if(mouseX > wid){
     is_open = false;
    }
    if(is_open){
      cb.update();
    }
  }
}
