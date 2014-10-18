import controlP5.*;
import fullscreen.*;



import unlekker.util.*;
import unlekker.modelbuilder.*;
import unlekker.modelbuilder.filter.*;
import ec.util.*;

import processing.opengl.*;

UNav3D nav; // camera tool
Obj obj;
PApplet papplet;
FullScreen fs; 

void setup() {
  size (1366, 768, OPENGL);
  papplet=this;
  nav=new UNav3D(this);
  nav.setTranslation(width/2,height/2,0);
  initGUI();
  
  obj=new Obj();
   fs = new FullScreen(this); 
  
  // enter fullscreen mode
  fs.enter(); 
}

void draw() {
  background(0);
  noStroke();
  lights();
  fill(255);
  pushMatrix();
  nav.doTransforms();
  if(doRebuild){
    obj.rebuild();
    doRebuild=false;
  }
  
  obj.draw();
  popMatrix();
  
  gui.draw();
  
  
}
