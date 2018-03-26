class Particule{
  int count;
  float vx, vy, teta;
  PVector pos;
  color c;
  
    Particule(PVector p, float _vx,  float _vy,float _teta){
    vx = _vx * cos(_teta);
    vy = _vy * sin(_teta);
    pos = new PVector(p.x, p.y);
    c = color(255);
  }
  
    Particule(PVector p, float _vx,  float _vy,float _teta, color _c){
    vx = _vx * cos(_teta);
    vy = _vy * sin(_teta);
    pos = new PVector(p.x, p.y);
    c = _c;
  }
  
  void update(){
    if(count == 10){
      particules.remove(this);
    }
    else{
    pos.x += vx;
    pos.y += vy;
   }
    count++;
  }
  
  void show(){
    float n = 255;
    noStroke();
    for(int i = 0; i < 8; i++){
    fill(red(c), green(c), blue(c), n);
    ellipse(pos.x, pos.y, i, i);
    n = n/i;
  }
    stroke(0);
    fill(255);
  }
}