import processing.serial.*;
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

Serial myPort;  // Create object from Serial class
String val;     // Data received from the serial port


void setup() {
  //  String portName = Serial.list()[1]; //change the 0 to a 1 or 2 etc. to match your port
  //  myPort = new Serial(this, portName, 9600); 
  size (1366, 768, OPENGL);
  papplet=this;
  nav=new UNav3D(this);
  //nav.setTranslation(width/2, height/2, 0);
  initGUI();


  obj=new Obj();
  fs = new FullScreen(this); 

  // enter fullscreen mode
  fs.enter();
}

void draw() {
  background(0);

  translate(width/2, height/2);
 lights();

  rotateX(radians(frameCount));
  rotateZ(radians(frameCount)*0.5f);

  noStroke();

  fill(255);
  pushMatrix();
  nav.doTransforms();
  if (doRebuild) {
    obj.rebuild();
    doRebuild=false;
  }


  obj.draw();
  popMatrix();

  // gui.draw();
}

