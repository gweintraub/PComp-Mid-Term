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

int rows=9, cols=15;
float rand;
float a=1, b=1, c=1, d=1;
float twist=0;

Serial myPort;  // Create object from Serial class

int triangleColor;
boolean decrement;



void setup() {
  triangleColor = 1;
  decrement = true;
  
  size (1366, 768, OPENGL);
  papplet=this;
  nav=new UNav3D(this);
  //nav.setTranslation(width/2, height/2, 0);
  initGUI();


  obj=new Obj();
  fs = new FullScreen(this); 

  // enter fullscreen mode
  fs.enter();
  
  String portName = Serial.list()[4];
  myPort = new Serial(this, portName, 38400); 
  myPort.bufferUntil('\n');
}

void draw() {
  background(0);
  gui.draw();


  translate(width/2, height/2);
  lights();

  rotateX(radians(frameCount));
  rotateZ(radians(frameCount)*0.5f);

  noStroke();
  switch(triangleColor) {
  case 0:
    fill(#0d0000);
    break;
  case 1:
    fill(#3f0002);
    break;
  case 2:
    fill(#520000);
    break;
  case 3:
    fill(#600303);
    break;
  case 4:
    fill(#5b0000);
    break;
  case 5:
    fill(#680000);
    break;
  case 6:
    fill(#7e0000);
    break;
  case 7:
    fill(#a60101);
    break;
  case 8:
    fill(#c10202);
    break;
  case 9:
    fill(#cb2204);
    break;
  case 10:
    fill(#cd0101);
    break;
  case 11:
    fill(#d83004);
    break;
  case 12:
    fill(#dc2904);
    break;
  case 13:
    fill(#e24e06);
    break;
  case 14:
    fill(#e46c05);
    break;
  case 15:
    fill(#e78605);
    break;
  case 16:
    fill(#fd4606);
    break;
  case 17:
    fill(#ffc407);
    break;
  }

  pushMatrix();
  nav.doTransforms();
  if (doRebuild) {
    obj.rebuild();
    doRebuild=false;
  }


  obj.draw();
  popMatrix();
  upAndDown();
}


void serialEvent(Serial myPort) {
  String inByte = myPort.readString();
  
  String[] values = split(inByte, ',');
  
  for(int i=0; i<values.length; i++){
    print(values[i] + ' ');
  }

  myPort.write('x');
  
}



void upAndDown() {
  if (decrement) {
    triangleColor--;
    if (triangleColor<0) {
      decrement = false;
      triangleColor = 0;
    }
  } 
  else {
    triangleColor++;
    if (triangleColor>17) {
      decrement = true;
      triangleColor = 17;
    }
  }
}

