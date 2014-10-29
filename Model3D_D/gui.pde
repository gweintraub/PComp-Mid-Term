USimpleGUI gui;

boolean doRebuild;


void initGUI(){
 gui=new USimpleGUI(this); 
// gui.addSlider("rows",rows,3,20);
// gui.addSlider("cols", cols, 4, 30);
// gui.addSlider("rand", rand, 0, 2);
// gui.newRow();
  gui.addSlider("a", a, 0, 2);
   gui.addSlider("b", b, 0, 2);
    gui.addSlider("c", c, 0, 2);
     gui.addSlider("d", d, 0, 2);
     gui.addSlider("twist", twist, 0, 6);
     gui.newRow();
 
 
// gui.addButton("build");
// gui.addButton("saveSTL");
 gui.setLayout(false);
 nav.setGUI(gui);
}

void saveSTL() {
obj.geo.writeSTL(this,"Test.stl");
}


void controlEvent(ControlEvent ev) {
  //set doReuild flag to true upon control even triggered
  doRebuild=true;
}

void build() {
  obj.build();
}
