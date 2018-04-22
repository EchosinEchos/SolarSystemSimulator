class Objectif{
  
  PVector pos;
  PImage img;
  int radius;
  
  Objectif(PVector _pos, int rad, String imgfile){
    pos = _pos;
    radius = rad;
    img = loadImage(imgfile + ".png");
  }
  
  void show(){
    imageMode(CENTER);
    image(img, this.pos.x*Xfactor, this.pos.y*Yfactor, radius*Xfactor, radius*Yfactor);
  }
  
  boolean checkWin(ArrayList<Planete> list){
    
    for(Planete p : list){
      if(dist(p.pos.x, p.pos.y, this.pos.x, this.pos.y) <= (this.radius/2 + p.radius/2)){
        return true; 
      }
    }
    return false;
  }
  
}