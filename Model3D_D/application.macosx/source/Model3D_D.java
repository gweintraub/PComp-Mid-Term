import processing.core.*; 
import processing.xml.*; 

import controlP5.*; 
import unlekker.util.*; 
import unlekker.modelbuilder.*; 
import unlekker.modelbuilder.filter.*; 
import ec.util.*; 
import processing.opengl.*; 

import java.applet.*; 
import java.awt.Dimension; 
import java.awt.Frame; 
import java.awt.event.MouseEvent; 
import java.awt.event.KeyEvent; 
import java.awt.event.FocusEvent; 
import java.awt.Image; 
import java.io.*; 
import java.net.*; 
import java.text.*; 
import java.util.*; 
import java.util.zip.*; 
import java.util.regex.*; 

public class Model3D_D extends PApplet {










UNav3D nav; // camera tool
Obj obj;
PApplet papplet;

public void setup() {
  size (600, 600, OPENGL);
  papplet=this;
  nav=new UNav3D(this);
  nav.setTranslation(width/2,height/2,0);
  initGUI();
  
  obj=new Obj();
}

public void draw() {
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
class Obj {
  UVertexList vl[];
  UGeometry geo;

  
  Obj() {
    //copy global parameters
  
    build();
  }
  
  public void build(){
    vl=UVertexList.getVertexLists(rows);
    for(int i=0; i<cols; i++) {
      vl[0].add(new UVec3(100,0,0).rotateY(map(i,0,cols,0,TWO_PI)));
    }
    
    for(int i=rows-1; i>-1; i--) {
      vl[i]=new UVertexList(vl[0]);
      for(int j=0; j<vl[i].n; j++) {
        vl[i].v[j].mult(random(0.8f,1.5f));
      }
      vl[i].translate(0,100*i,0);
      vl[i].close();
    }
    
    
   rebuild();
  }
  
  public void rebuild() {
    UVertexList vlcopy[]=UVertexList.getVertexLists(vl.length);
    for(int i=0; i<vl.length; i++){
      vlcopy[i]=new UVertexList(vl[i]);
      vlcopy[i].translate(0,-i*100,0).
      scale(mod(map(i,0, vl.length-1, 0,1))).rotateY(map(i,0,vl.length-1, 0, twist*PI)).
      translate(0,i*100,0);
    }
    
    geo=new UGeometry().quadStrip(vlcopy, false);
    geo.triangleFan(vlcopy[0],true, false);
    geo.triangleFan(vlcopy[vl.length-1], true, true);
    geo.center();
  }
  
  public float mod(float t) {
    return bezierPoint(a,b,c,d, t);
  }
  
  public void draw() {
    geo.draw(papplet);
    
  }
}
USimpleGUI gui;
int rows=6, cols=12;
float rand;
float a=1, b=1, c=1, d=1;
float twist=0;
boolean doRebuild;


public void initGUI(){
 gui=new USimpleGUI(this); 
 gui.addSlider("rows",rows,3,20);
 gui.addSlider("cols", cols, 4, 30);
 gui.addSlider("rand", rand, 0, 2);
 gui.newRow();
  gui.addSlider("a", a, 0, 2);
   gui.addSlider("b", b, 0, 2);
    gui.addSlider("c", c, 0, 2);
     gui.addSlider("d", d, 0, 2);
     gui.addSlider("twist", twist, 0, 6);
     gui.newRow();
 
 
 gui.addButton("build");
 gui.addButton("saveSTL");
 gui.setLayout(false);
 nav.setGUI(gui);
}

public void saveSTL() {
obj.geo.writeSTL(this,"Test.stl");
}


public void controlEvent(ControlEvent ev) {
  //set doReuild flag to true upon control even triggered
  doRebuild=true;
}

public void build() {
  obj.build();
}
  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#FFFFFF", "Model3D_D" });
  }
}
