class Obj {
  UVertexList vl[];
  UGeometry geo;

  
  Obj() {
    //copy global parameters
  
    build();
  }
  
  void build(){
    vl=UVertexList.getVertexLists(rows);
    for(int i=0; i<cols; i++) {
      vl[0].add(new UVec3(100,0,0).rotateY(map(i,0,cols,0,TWO_PI)));
    }
    
    for(int i=rows-1; i>-1; i--) {
      vl[i]=new UVertexList(vl[0]);
      for(int j=0; j<vl[i].n; j++) {
        vl[i].v[j].mult(random(0.8,1.5));
      }
      vl[i].translate(0,100*i,0);
      vl[i].close();
    }
    
    
   rebuild();
  }
  
  void rebuild() {
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
  
  float mod(float t) {
    return bezierPoint(a,b,c,d, t);
  }
  
  void draw() {
    geo.draw(papplet);
    
  }
}
