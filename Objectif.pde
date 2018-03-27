class objectif{
  
  PVector pos;
  color c;
  int radius;
  
  objectif(PVector _pos, int rad, int _c){
    pos = _pos;
    radius = rad;
    c = _c;
  }
  
  void show(){
    fill(c);
    ellipse(this.pos.x*Xfactor, this.pos.y*Yfactor, radius*Xfactor, radius*Yfactor);
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