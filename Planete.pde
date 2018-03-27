class Planete  {
  PVector pos = new PVector();
  int radius;
  float vx, vy, ax, ay, a, mass;
  float G = 6.67 * pow(10, -11);
  boolean del = false;
  color c;
  
  
 Planete(int x, int y, int rad, float mas){
   pos.x = x;
   pos.y = y;
   radius = rad;
   mass = mas;
   c = color(255);
 } 
 
 Planete(int x, int y, int rad, float mas, color _c){
   pos.x = x;
   pos.y = y;
   radius = rad;
   mass = mas;
   c = _c;
 } 
 
 float distance(Planete p){
   return sqrt( pow( (pos.x - p.pos.x), 2) + pow( (pos.y - p.pos.y),2 ));
 }
 
 void show(){

  /*translate(this.pos.x, this.pos.y, 0);
  sphere(radius); */
  fill(c);
  ellipse(pos.x*Xfactor, pos.y*Yfactor, radius*Xfactor, radius*Yfactor);

 }
 void move(){
   vx += ax;
   vy += ay;
   pos.x += vx;
   pos.y += vy;
 }
 
 void update(Planete p){
   float dist = distance(p);
   
   
   //float angle = atan2( p.pos.y-pos.y, p.pos.x-pos.x);
   //float angle = acos((-this.pos.x + p.pos.x)/dist);
   //float angle = asin((-this.pos.y + p.pos.y)/dist);
   a = (G * p.mass)/pow(dist, 2);
   //ax = a * cos(angle);
   //ay = a * sin(angle);
   ax = a * (p.pos.x - this.pos.x)/dist;
   ay = a * (p.pos.y - this.pos.y)/dist;
   //println(angle == angle2);  
   
   
   if(dist <= (this.radius/2 + p.radius/2)){
     onTouch(p);
   }
 }
 
  void onTouch(Planete p){
   if(this.radius < p.radius){
     del = true;
     p.radius = int(sqrt( pow(this.radius,2) + pow(p.radius,2)));
     p.mass += this.mass;
   }
 }
 
 
 }