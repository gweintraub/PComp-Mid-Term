USimpleGUI gui;
int rows=6, cols=12;
float rand;
float a=1, b=1, c=1, d=1;
float twist=0;
boolean doRebuild;


void initGUI(){
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
 gui.setLayout(false);
 nav.setGUI(gui);
}


void controlEvent(ControlEvent ev) {
  //set doReuild flag to true upon control even triggered
  doRebuild=true;
}

void build() {
  obj.build();
}
