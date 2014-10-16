import unlekker.mb2.geo.*;
import unlekker.mb2.util.*;
import unlekker.data.*;
import unlekker.mb2.externals.*;
import ec.util.*;

import controlP5.*;

//import unlekker.util.*;
//import unlekker.modelbuilder.*;
//import unlekker.modelbuilder.filter.*;
//import ec.util.*;



import processing.opengl.*;

UNav3D nav; // camera tool
Obj obj;
PApplet papplet;

void setup() {
  size (600, 600, OPENGL);
  
  UMB.setPApplet(this);
  nav = new UNav3D();
   translate(width/2,height/2);
  
  
  
//  papplet=this;
//  nav=new UNav3D(this);
//  nav.setTranslation(width/2,height/2,0);
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
  
  //gui.draw();
  
  
}
