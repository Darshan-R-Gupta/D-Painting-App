import processing.net.*;
Screen scr;
PImage output;
PImage img;
int mode = 0;
int mx, my,px,py;

Server s;
Client c;
color background;
int type=0;  //1 means eraser mode and 0 means paint mode
void setup(){
  
  colorMode(HSB,100);
  background = color(random(100), random(70,100) ,random(70,100) );  //#6CE319
  background( background );
 fullScreen();
 
 //  size(800, 600);
    textAlign(CENTER);
  output = createImage(width,height,RGB);
  scr = new Screen();
  
  noStroke();
  fill(100);
  s = new Server(this, 12345);
}
void draw(){
  noStroke();
  fill(scr.cur_col);
   c= s.available();
   if(c != null){   
     mode = c.read();
     if(mode == 0){
       stroke(c.read(),c.read(),c.read(),c.read());
       strokeWeight(c.read() );
       
       px = int(map(c.read(), 0, 255, scr.c.loc.x, scr.c.loc.x+ scr.c.w ));
       py = int(map(c.read(), 0, 255, scr.c.loc.y, scr.c.loc.y+ scr.c.h ));
       
       mx = int(map(c.read(), 0, 255, scr.c.loc.x, scr.c.loc.x+ scr.c.w ));
       my = int(map(c.read(), 0, 255, scr.c.loc.y, scr.c.loc.y+ scr.c.h ));

       line(px,py,mx,my);
      }
     else if(mode == 1){
        rectMode(CENTER);
        fill(c.read() , c.read() ,c.read() ,c.read() );     
        mx = int(map(c.read(), 0, 255, scr.c.loc.x, scr.c.loc.x+ scr.c.w ));
        my = int(map(c.read(), 0, 255, scr.c.loc.y, scr.c.loc.y+ scr.c.h ));
        int er_dim = c.read();
        rect(mx, my, er_dim, er_dim);
     }
   }
  scr.update();
  scr.display();
}
void mouseDragged(){ //<>//
 if(scr.cr.cb.eraser.is_clicked){
      type = 1;
      if(scr.c.checkEraserInside(scr.eraser_dim, scr.eraser_dim)){
        fill(scr.c.back_col, scr.trans);
        rectMode(CENTER);
         noStroke();
       rect(mouseX, mouseY, scr.eraser_dim,scr.eraser_dim);
       s.write(type);
       s.write( int(hue(scr.c.back_col)) );
       s.write( int(saturation(scr.c.back_col)) );
       s.write( int(brightness(scr.c.back_col)) );
       s.write( scr.trans ); 
       s.write( int(map(mouseX, scr.c.loc.x , scr.c.loc.x+scr.c.w, 0,255))  );
       s.write( int(map(mouseY, scr.c.loc.y , scr.c.loc.y+scr.c.h, 0,255))  );
       s.write(scr.eraser_dim);      
      }
  }
  else{  
      if(scr.c.checkBrushInside(scr.wt, scr.wt) ){
      strokeWeight(scr.wt);
      stroke(scr.cur_col,scr.trans);
      line(pmouseX,pmouseY, mouseX, mouseY);   
      type =0;
        s.write( type );
        
        s.write( int(hue(scr.cur_col)) ); 
        s.write( int(saturation(scr.cur_col)) );
        s.write( int(brightness(scr.cur_col)) );
        
        s.write( scr.trans );
        s.write( scr.wt    );
        
        s.write( int(map(pmouseX, scr.c.loc.x, scr.c.loc.x + scr.c.w, 0,255) ) );
        s.write( int(map(pmouseY, scr.c.loc.y, scr.c.loc.y + scr.c.h, 0,255) ) );
        
        s.write( int(map(mouseX, scr.c.loc.x, scr.c.loc.x + scr.c.w, 0,255) ) );
        s.write( int(map(mouseY, scr.c.loc.y, scr.c.loc.y + scr.c.h, 0,255) ) );
     }
  }
}
void keyPressed(){
  if(key == ' '){
    saveFrame("Output.jpg");
    img = loadImage("Output.jpg");
    output = img.get(int(scr.c.loc.x), int(scr.c.loc.y), int(scr.c.w),int(scr.c.h));
    output.save("Output.jpg");
  }
  if(scr.r.add.is_clicked)
  {
    if(key != CODED && keyCode != BACKSPACE){
       scr.add += key;
    }
    else if(keyCode == BACKSPACE){
       if(scr.add.length()  > 0){
         scr.add = scr.add.substring(0, scr.add.length() -1);
        }
    } 
  }
  
  
}
