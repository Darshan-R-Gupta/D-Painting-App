class Screen{
    Ribbon r;
   Color_Ribbon cr;
   Canvas c;
    int trans;  //Transparency   
   
   String add;  //For working with the current address
   color cur_col;  //Current color for quick access
   int wt;
   int eraser_dim;
   boolean is_open;  //Is there any image already present
   Screen(){
    r = new Ribbon(height/5);
    c = new Canvas( width/15 , r.h+ (height/20) , width- (width/10), height-r.h-(height/12), color(100) );  
 
    cr = new Color_Ribbon(c.loc.x - (width/70) ,r.h ,height-r.h);
    
    cur_col = cr.cb.cur_col;
    wt = 30;
    eraser_dim = 40;
    add = "";
    is_open = false;
    c.display(); 
    trans =100;
   }
  void display(){    
    r.display();
      
    cr.display();
    fill(100);
    stroke(100);
    strokeWeight(1);
    textSize(20);
    
    text(int(wt),  r.inc.loc.x + r.inc.w,  r.inc.loc.y +  r.inc.h); //To display weight of the current stroke
    text(int(trans),  r.inc_t.loc.x +  r.inc_t.w,  r.inc_t.loc.y +  r.inc_t.h); //To display weight of the current stroke
    
    fill(0);
    text(add,  r.add.loc.x  ,  r.add.loc.y+ r.add.h/2);  //To display current address     
  
  }
  void update(){
    r.update();
    cr.update();
    inc_dec_update(r.inc, '+' );
    inc_dec_update(r.dec, '-');
    
    inc_dec_update(r.inc_t, 'p');  //p for plus
    inc_dec_update(r.dec_t, 'm');  //m for minus
    
    add_update();
    open_file();
    cur_col = cr.cb.cur_col;
  }
  void add_update(){
    if(r.add.is_mouse_inside){  
      cursor(TEXT);   
    }
    else{
      cursor(ARROW);
    }
  }
  void open_file(){  //Function which handles opening of a image file if open button is clicked
    if(r.open.is_clicked && add != ""){
      PImage img = loadImage(add);
      if(is_open == false && img!= null){
        if(img.height >= c.h){ 
          float ori_h = img.height;
          float new_h = int(c.h);
          float ratio = new_h/ori_h;
          img.resize( int(ratio*img.width)  ,int(c.h));
        }
        if(img.width >= c.w){
          float ori_w = img.width;
          float new_w = int(c.w);
          float ratio = new_w/ori_w;
          img.resize( int(c.w), int(ratio*img.height));   
        }
        image(img, c.loc.x, c.loc.y);
        is_open = true;
      }
    }
    if(r.open.is_clicked)  r.open.is_clicked = false;
    if(r.clear.is_clicked){
      c.display();
      add = "";
      r.clear.is_clicked = false;
      is_open=false;
      r.open.is_clicked = false;
    }
  }
  void inc_dec_update(Button i, char c)//c represents the type
  {
   if(i.is_clicked){
     if(c == '+' || c == 'p'){
          if(c == '+'){    
            if(wt < 200)                  wt+=2;
            if(eraser_dim < 200)          eraser_dim += 2;
          }else if(trans < 100)  trans++;
       }
      else{
        if(c == '-'){
          if(wt >2)            wt-=2;
          if(eraser_dim > 2)   eraser_dim -= 2;
        }else if(trans > 2)  trans--;
      }
      i.is_clicked =false;
   }
  }
}
