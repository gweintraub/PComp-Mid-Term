import controlP5.*;

import unlekker.util.*;
import unlekker.modelbuilder.*;
import unlekker.modelbuilder.filter.*;
import ec.util.*;

import processing.opengl.*;

UNav3D nav; // camera tool
Obj obj;
PApplet papplet;

void setup() {
  size (600, 600, OPENGL);
  papplet=this;
  nav=new UNav3D(this);
  nav.setTranslation(width/2,height/2,0);
  initGUI();
  
  obj=new Obj();
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
