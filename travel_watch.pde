import controlP5.*;

ControlP5 cp5;

int S = 100;

float sw, sh, X, Y, shw, dist;

int H1=0, M1=0, H2=0, M2=0, H3=0, M3=0, k=1, n=0, M, H;

JSONObject save;

void setup()
{
  try{
    save = loadJSONObject("data.save");
    H1=save.getInt("H1");
    M1=save.getInt("M1");
    H2=save.getInt("H2");
    M2=save.getInt("M2");
    H3=save.getInt("H3");
    M3=save.getInt("M3");
  }catch(Exception e){
    save=new JSONObject();
    save.setInt("H1", 0);
    save.setInt("M1", 0);
    save.setInt("H2", 0);
    save.setInt("M2", 0);
    save.setInt("H3", 0);
    save.setInt("M3", 0);
    saveJSONObject(save,"data.save");
  }
  
  size(displayWidth, displayHeight, P2D);
  println(displayWidth);
  println(displayHeight);
  sw=displayWidth;
  sh=displayHeight;
  shw=sh/sw; //отношение высоты к ширине
  println(shw);
  dist=sw/36;//минимальное расстояние между объектами и стенками
  
  cp5 = new ControlP5(this);
  
  cp5.addSlider("H")
     .setPosition(dist+50,sh-dist-220)
     .setRange(0, 23)
     .setSize(850, 100)
     .setNumberOfTickMarks(24)
     //.setHeight(100)
     //.setHandleSize(int(sw/10))
     //.setSliderMode(Slider.FLEXIBLE)
     .setValue(0)
     //.setWidth(400)
     ;
  
  cp5.addSlider("M")
     .setPosition(dist+50,sh-dist-80)
     .setRange(0, 55)
     .setSize(850, 100)
     .setNumberOfTickMarks(12)
     //.setHeight(100)
     //.setHandleSize(int(sw/10))
     //.setSliderMode(Slider.FLEXIBLE)
     .setValue(0)
     //.setWidth(400)
     ;
  
  
}

void draw()
{
  background(255);
  
  
  
  
  
  textSize(sw/20);
  textAlign(CENTER, TOP);
  
  if(mouseY<200 && mouseX>900 && mousePressed || n==1)
  {
    n=1;
    if(!mousePressed)
    {
    if(k==1)
    {
      k=0;
      println(k);
      n=0;
    } else if(k==0)
    {
      k=1;
      println(k);
      n=0;
    }
    }
  }
  
    

  if(k==0)
    text("change",900, dist+30);
    
  if(k==1)
    text("don't change",900, dist+30);

  if(mouseY>dist+150+500 && mouseY<dist+150+500+175 && mousePressed && k==0 && (H!=0 || M!=0))
  {
    H1=H;
    M1=M;
    save.setInt("H1", int(H1));
    save.setInt("M1", int(M1));
    save.setInt("H2", int(H2));
    save.setInt("M2", int(M2));
    save.setInt("H3", int(H3));
    save.setInt("M3", int(M3));
    saveJSONObject(save, "data.save");
  }
  
  if(mouseY>dist+150+1000 && mouseY<dist+150+1000+175 && mousePressed && k==0 && (H!=0 || M!=0))
  {
    H2=H;
    M2=M;
    save.setInt("H1", int(H1));
    save.setInt("M1", int(M1));
    save.setInt("H2", int(H2));
    save.setInt("M2", int(M2));
    save.setInt("H3", int(H3));
    save.setInt("M3", int(M3));
    saveJSONObject(save, "data.save");
  }
  
  if(mouseY>dist+150+1500 && mouseY<dist+150+1500+175 && mousePressed && k==0 && (H!=0 || M!=0))
  {
    H3=H;
    M3=M;
    save.setInt("H1", int(H1));
    save.setInt("M1", int(M1));
    save.setInt("H2", int(H2));
    save.setInt("M2", int(M2));
    save.setInt("H3", int(H3));
    save.setInt("M3", int(M3));
    saveJSONObject(save, "data.save");
  }
  
  fill(0);
  
  fill(0);
  textSize(sw/20);
  textAlign(CENTER, TOP);
  
  text("Hour", 1000, sh-dist-200);
  text("Min", 1000, sh-dist-60);
  
  text(H,dist+10,sh-dist-200);
  text(M,dist+10,sh-dist-60);
  
  textSize(sw/10);
  
  text("My time", sw/2, dist);
  time(dist+150+0*sh/4, 0, 0);
  
  text("+"+H1+":"+M1, sw/2, dist+500);
  time(dist+150+500, H1, M1);
  
  text("+"+H2+":"+M2, sw/2, dist+1000);
  time(dist+150+1000, H2, M2);
  
  text("+"+H3+":"+M3, sw/2, dist+1500);
  time(dist+150+1500, H3, M3);
  
}

void time(float y, int H_const, int M_const)
{
  if(M_const+minute()>59)
  {
     H_const++;
     M_const=M_const-60;
  }
  
  if(H_const+hour()>23)
  {
     H_const=H_const-24; 
  }
  
  int h=hour()+H_const;
  int h0=h/10;
  int h1=h%10;
  int m=minute()+M_const;
  int m0=m/10;
  int m1=m%10;
  int s=second();
  int s0=s/10;
  int s1=s%10;
  
  for(int x=1; x<3; x++)
    for(int j=0; j<7; j++)
    if(j==2 || j==4)
      rect(dist+x*300+(x-1)*(dist+25), y+j*25, 20, 20);
      
  draw_number(h0, 1.5*dist, y);
  draw_number(h1, 1.5*dist+150, y);
  draw_number(m0, 1.5*dist+300+20+dist, y);
  draw_number(m1, 1.5*dist+300+20+dist+150, y);
  draw_number(s0, 1.5*dist+300+20+dist+300+25+dist, y);
  draw_number(s1, 1.5*dist+300+20+dist+300+25+dist+150, y);
  
}


void draw_number(int n, float d, float y){
  
 switch(n)
 {
  case 0:
  {
    for(int i=0; i<5; i++)
    for(int j=0; j<7; j++)
      if(((i>0 && i<4) && (j<1 || j>5)) || (i==0 || i==4) && (j<6 && j>0))
        rect(d+i*25, y+j*25, 20, 20);
  }break;
  
  case 1:
  {
    for(int i=0; i<5; i++)
    for(int j=0; j<7; j++)
      if(((i>0 && i<4) && (j==6)) || (i==2) && (j>=0 && j<6) || (i==1 && j==1))
        rect(d+i*25, y+j*25, 20, 20);
  }break;
  
  case 2:
  {
    for(int i=0; i<5; i++)
    for(int j=0; j<7; j++)
      if(((i>0 && i<4) && (j<1 || j>5)) || (i==0 || i==4) && (j>5 || j==1) || (i==-j+6))
        rect(d+i*25, y+j*25, 20, 20);
  }break;
  
  case 3:
  {
    for(int i=0; i<5; i++)
    for(int j=0; j<7; j++)
      if(((i>0 && i<4) && (j<1 || j>5)) || (i==0 || i==4) && (j==5 || j<1) || (i==-j+4 && j<3) || (i==j && j>2))
        rect(d+i*25, y+j*25, 20, 20);
  }break;
  
  case 4:
  {
    for(int i=0; i<5; i++)
    for(int j=0; j<7; j++)
      if((j==4) || (i==3) || (i==-j+3))
        rect(d+i*25, y+j*25, 20, 20);
  }break;
  
  case 5:
  {
    for(int i=0; i<5; i++)
    for(int j=0; j<7; j++)
      if(((i>0 && i<4) && (j<1 || j>5 || j==2)) || (i==0 || i==4) && (j==5 || j<1) || (i==0) && (j>0 && j<3) || (i==4) && (j>2 && j<5))
        rect(d+i*25, y+j*25, 20, 20);
  }break;
  
  case 6:
  {
    for(int i=0; i<5; i++)
    for(int j=0; j<7; j++)
      if(((i>0 && i<4) && (j==3 || j>5)) || (i==0 || i==4) && (j<6 && j>3) || (j==3 && i==0) || (j==0 && i==3) || (i==-j+2))
        rect(d+i*25, y+j*25, 20, 20);
  }break;
  
  case 7:
  {
    for(int i=0; i<5; i++)
    for(int j=0; j<7; j++)
      if((j==0) || (i==1 && j>3) || (i==-j+5 && i>0))
        rect(d+i*25, y+j*25, 20, 20);
  }break;
  
  case 8:
  {
    for(int i=0; i<5; i++)
    for(int j=0; j<7; j++)
      if(((i>0 && i<4) && (j<1 || j>5 || j==3)) || (i==0 || i==4) && (j<6 && j>3 || j>0 && j<3))
        rect(d+i*25, y+j*25, 20, 20);
  }break;
  
  case 9:
  {
    for(int i=0; i<5; i++)
    for(int j=0; j<7; j++)
      if(((i>0 && i<4) && (j==3 || j<1)) || (i==0 || i==4) && (j>0 && j<3) || (j==3 && i==4) || (j==6 && i==1) || (i==-j+8))
        rect(d+i*25, y+j*25, 20, 20);
  }break;
  
 }
   
}
