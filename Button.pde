class Button{  
  int w,h;  //The width and height;
  PVector loc; 
  boolean is_mouse_inside;
  boolean is_clicked;
   color c;
  String label;  //To display the button's label
  Button(int x,int y, int wid, int hei,color col, String s){
    w = wid;
    h = hei;
    loc = new PVector(x,y);
    is_mouse_inside = false;  
    is_clicked = false; 
    c= col;
    label = s;
  }
  
  void display(){
    rectMode(CENTER);
    noStroke();
    
     float wid = w;
     float hei = h;
    if(is_mouse_inside == true){
      wid -= w/6;
      hei -= h/6;
      
      textSize(15);
      if(is_clicked){
         stroke(20,100,100);
       }
      strokeWeight(4);
    }else  textSize(20);
    fill(c);

    rect(loc.x, loc.y, wid,hei, wid/10); 
    
    fill(0);
    text(label,loc.x, loc.y + h/3);
  
  }
  void update(){
     if(mouseX > loc.x - w/2 && mouseX < loc.x + w/2 && mouseY > loc.y - h/2 && mouseY < loc.y + h/2){
          is_mouse_inside = true;
          if(mousePressed){
            is_clicked = true;
          }
      }
      else{
        is_mouse_inside = false;
      }
  }
}

class Color_Buttons{
  int no_of_cols;  //no of colors
  ArrayList<Button> col_buttons;    //The color palette 
  Button eraser;
  int Button_w,Button_h;    //Width and height of each color button
  color cur_col;  //Current color used to draw lines and shapes;
  Color_Buttons(float w, float hy , float hei){
    no_of_cols = 20;
    cur_col = color(0);
     Button_w = int(w/2);
     Button_h = int(hei/(no_of_cols +17) );

    int x = int(w/2);
    int y = int(hy) + int(hei/(no_of_cols+15));
    float hue = 0;
    col_buttons= new ArrayList<Button>();
    Button b;
    int i;
    int spacing = Button_h+10;
    for(i =0 ; i < no_of_cols; ++i){
       b= new Button(x , spacing*i+y, Button_w,Button_h,color(hue,100,100),"" );
       hue += 100/no_of_cols;
       col_buttons.add(b);  
    }
    b= new Button(x,spacing*i+y,Button_w,Button_h,color(0),"");
    col_buttons.add(b);
    b = new Button(x, spacing*(i+1)+y,Button_w,Button_h,color(100),"" );
    col_buttons.add(b);
    eraser = new Button(x,spacing*(i+2)+y +Button_h/4 , Button_w + Button_w/4, Button_h + Button_h/4,color(100),"" );
  }
  void display(){
    Button b;
    for(int i =0; i < col_buttons.size(); ++i){
       b= col_buttons.get(i);
       b.display();
    }
    eraser.display();
    //An inner bordered rectangle to indicate it is eraser
    stroke(0,0,0);    strokeWeight(2);
    pushMatrix();
    translate(eraser.loc.x, eraser.loc.y);
    rotate(45);
    if(eraser.is_mouse_inside)    rect(0,0, eraser.w/5,eraser.h/5);
    else                          rect(0,0, eraser.w/4,eraser.h/4);
    popMatrix();
    noStroke();
  }
  void check_col_buttons_clicked(){
    Button b;
    for(int i =0; i < col_buttons.size(); ++i){
      b = col_buttons.get(i);
      if(mouseX > b.loc.x - b.w/2 && mouseX < b.loc.x + b.w/2 && mouseY > b.loc.y - b.h/2 && mouseY < b.loc.y + b.h/2){
          b.is_mouse_inside = true;
          if(mousePressed){
            b.is_clicked = true;
            eraser.is_clicked = false;
            Button b1;
            for(int j = 0; j < col_buttons.size(); ++j){
                if(i != j){
                  b1 = col_buttons.get(j);
                  b1.is_clicked = false;
                }
            }
          }
      }
      else{
        b.is_mouse_inside = false;
      }
    }
    if(mouseX > eraser.loc.x - eraser.w/2 && mouseX < eraser.loc.x + eraser.w/2 && mouseY > eraser.loc.y - eraser.h/2 && mouseY < eraser.loc.y + eraser.h/2){
        eraser.is_mouse_inside = true;
        if(mousePressed){
         eraser.is_clicked = true;
       }
    }
    else{
      eraser.is_mouse_inside = false;
    }
  }
  void update(){
    Button b1;
    int i;
    check_col_buttons_clicked();
    for(i=0; i < col_buttons.size(); ++i){
      b1 = col_buttons.get(i);
      if(b1.is_clicked){
        cur_col = b1.c;
      }
    }
    if(eraser.is_clicked){
      cur_col = eraser.c;
    }
    
  }
}
