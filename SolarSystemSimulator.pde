ArrayList<Planete> planetes;
ArrayList<Planete> fix;
ArrayList<Particule> particules;
objectif obj;
int rad = 15;
PVector first;
color c;

int tailleVert = 150, tailleAcceleration = 350;

float Xfactor, Yfactor;



void setup(){
  Xfactor = width / 1080f;
  Yfactor = height / 1920f;
  
   
  
  //size(400, 800);
  planetes = new ArrayList<Planete>();
  fix = new ArrayList<Planete>();
  particules = new ArrayList<Particule>();
  fullScreen();
  frameRate(60);
  noStroke();
  orientation(PORTRAIT);
  obj = new objectif(new PVector(int(random(50, (width-50))), 150), int(100), color(50,50,250));

  int yoff = int(250);
  for(int i = 1; i < random(1,4); i++){
    int rad = int(random(50, 300));
    yoff += rad/2 + random(20,100);// +(int)random(0,100);
    fix.add(new Planete(int(random(rad/2,1080-rad/2)), int(yoff) , rad, rad * 1000000000000f, getRandomColor()));
    yoff += rad/2;
  }
  
  
  //fix.add(new Planete(int(random(80,width-80)), height/2, 300, 90000000000000f, #F06813));
  //fix.add(new Planete(int(random(40,width-40)), height/4, 100, 30000000000000f));
  //fix.add(new Planete(100, 100, 10, 100000000f));
  //planetes.get(0).ax = 1;
  //fix.add(new Planete(width/2, height/2, 50, 1f));
}


void draw(){
  //scale(float(width)/1080, float(height)/1920);
  
  background(0);
  noStroke();
  
  strokeWeight(2);
  stroke(255);
  fill(#757575);
  rect(0, (height-tailleVert*Yfactor-tailleAcceleration*Yfactor), width , (height-tailleVert));
  noStroke();
  fill(#66BB6A);
  rect(0, (height-tailleVert*Yfactor), width , height);
 
  
  obj.show();
  
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
  
  for(int i = 0; i < particules.size(); i++){
    particules.get(i).show(); 
    particules.get(i).update();
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

if(obj.checkWin(planetes)){
  /*textSize(60);
  textAlign(CENTER);
  fill(0,230,0);
  text("You Win",width/2, height/2);
  noLoop();*/
  setup();
  redraw();
  //exit();
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