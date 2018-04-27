ArrayList<Planete> planetes;
ArrayList<Planete> fix;
ArrayList<Objectif> obj;
ArrayList<Particule> particules;
PVector etoiles[] = new PVector[15];
boolean used[];
char dificulty = 4;

int rad = 15;
PVector first;
color c;



int tailleVert = 150, tailleAcceleration = 350;
float Xfactor, Yfactor;



void setup(){
  Xfactor = width / 1080f;
  Yfactor = height / 1920f;
   
  
  size(450, 800);
  //fullScreen();
  
  smooth();
  used = new boolean[7];
  planetes = new ArrayList<Planete>();
  fix = new ArrayList<Planete>();
  particules = new ArrayList<Particule>();
  obj = new ArrayList();
  frameRate(60);
  noStroke();
  orientation(PORTRAIT);  
  //openLevel();
  randomLevel();
  
  for(int i=0; i < 15; i++){
    etoiles[i] = new PVector(random(width), random(height-tailleVert*Yfactor-tailleAcceleration*Yfactor));
  }
  
}


void draw(){
  //scale(float(width)/1080, float(height)/1920);
  
  background(0);
  noStroke();
  
  strokeWeight(2);
  stroke(83);
  
  for(PVector pos : etoiles){
    stroke(random(150, 255));
    ellipse(pos.x, pos.y, 2,2);
  }
  
  
  rectMode(CORNERS);
  
  noStroke();
  fill(58,227,25,265);
  rect(0, (height-tailleVert*Yfactor), width , height);
  
  stroke(255);
  noFill();
  strokeWeight(4+sin(frameCount*PI/73f));
  fill(184,178,184,79);
  rect(1, (height-tailleVert*Yfactor-tailleAcceleration*Yfactor), width -2 , height -2);
 
  for(Objectif o : obj){
    o.show();
  }
  
  for(int i = 0; i < particules.size(); i++){
    particules.get(i).show(); 
    particules.get(i).update();
  }
  
  for(Planete p : fix){
    for(Planete p2 : planetes){
      //if(p2 != p  && p2 != null){
        //if(c == 5){
        particules.add(new Particule(p2.pos, -p2.vx, -p2.vy, random(-PI/4,PI/4), p2.c));
        //c = 0;  
        //}
        p2.update(p);
        p2.move();
        p2.show();
        //c++;
      //}
  }
  //p.move();
  p.show();
  }
  for(int i = 0; i < planetes.size(); i++){
    if(planetes.get(i).del){
     planetes.remove(i); 
    }
  }
  
  
if(mousePressed){
  noStroke();
  if(first == null){
   if(mouseY > height-tailleAcceleration*Yfactor-tailleVert*Yfactor){
   first = new PVector(mouseX, mouseY); 
   c = getRandomColor();
   }
  }else{
  stroke(255);
  strokeWeight(2);
  line(mouseX, mouseY, first.x, first.y);
    
 fill(255);
 ellipse(first.x, first.y, 10*Xfactor,10*Yfactor);
    
  fill(c);
  ellipse(mouseX, mouseY, rad*Xfactor, rad*Yfactor);
  //rad ++;
  }
  
}
for(Objectif o : obj){
  if(o.checkWin(planetes)){
    setup();
    break;
   }
}
  
}

void mouseReleased(){
  if(first != null){
  if(mouseY > height-tailleVert*Yfactor){
  Planete p = new Planete(int(mouseX/Xfactor), int(mouseY/Yfactor), rad, rad * 100000000000f, c);
  p.vx = (first.x - mouseX)/20;
  p.vy = (first.y - mouseY)/20;
  planetes.add(p);
  }
  first = null;
  }
  //rad = 5;
  //particules.add(new Particule(new PVector(mouseX, mouseY), 0, 0, random(-PI/4,PI/4)));
}


color getRandomColor(){
  color _c;
  do{
      _c = color(random(255),random(255), random(255));
  }while(green(_c)+red(_c)+blue(_c) < 100 || (green(_c)+red(_c)+blue(_c))%255 < 30);
  
  return _c;
  
}


void openLevel(){
  JSONArray Level = loadJSONArray("data/Level.json");
  JSONArray Obstacles = Level.getJSONArray(0);
  for(int i = 0; i < Obstacles.size(); i++){
   JSONObject current = Obstacles.getJSONObject(i);
   fix.add(new Planete(current.getInt("x"), current.getInt("y"), current.getInt("radius"), current.getFloat("mass")));
  }
  
  JSONArray objs = Level.getJSONArray(1);
  for(int i = 0; i < objs.size(); i++){
  JSONObject current = objs.getJSONObject(i);
  obj.add(new Objectif(new PVector(current.getInt("x"), current.getInt("y")), current.getInt("radius"), "Terre"));
  }
  
  tailleVert = Level.getInt(2);
  tailleAcceleration = Level.getInt(3);
}
void randomLevel(){
  obj.add(new Objectif(new PVector(int(random(50, (width-50))), 150), int(100), "Terre"));

  int yoff = int(250);
  for(int i = 1; i < random(1,dificulty); i++){
    int rad = int(random(50, dificulty*75));
    yoff += rad/2 + random(20,100);// +(int)random(0,100);
    fix.add(new Planete(int(random(rad/2,1080-rad/2)), int(yoff) , rad, rad * 1000000000000f));
    yoff += rad/2;
  }
}
