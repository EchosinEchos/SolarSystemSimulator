package com.echosinechos.solarsystem;

import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class SolarSystemSimulator extends PApplet {

ArrayList<Planete> planetes = new ArrayList<Planete>();
ArrayList<Planete> fix = new ArrayList<Planete>();
ArrayList<Particule> particules = new ArrayList<Particule>();
objectif obj = new objectif(new PVector(random(200,width-80), 80), 50, color(50,50,250));
int rad = 15;
PVector first;
int c;

int tailleVert = 100, tailleAcceleration = 250;

public void setup(){
  //size(400, 800);
  
  frameRate(60);
  noStroke();

  
  fix.add(new Planete(PApplet.parseInt(random(80,width-80)), height/2, 300, 90000000000000f, 0xffF06813));
  fix.add(new Planete(PApplet.parseInt(random(40,width-40)), height/4, 100, 3000000000.0000f));
  //fix.add(new Planete(100, 100, 10, 100000000f));
  //planetes.get(0).ax = 1;
  //fix.add(new Planete(width/2, height/2, 50, 1f));
}


public void draw(){
  background(60);
  noStroke();
  
  strokeWeight(2);
  stroke(255);
  fill(0xff757575);
  rect(0, height-tailleVert-tailleAcceleration, width , height-tailleVert);
  noStroke();
  fill(0xff66BB6A);
  rect(0, height-tailleVert, width , height);
 
  
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
   if(mouseY > height-tailleAcceleration-tailleVert){
   first = new PVector(mouseX, mouseY); 
   c = getRandomColor();
   }
  }else{
  stroke(255);
  strokeWeight(2);
  line(mouseX, mouseY, first.x, first.y);
    
  fill(c);
  ellipse(mouseX, mouseY, rad, rad);
  //rad ++;
  }
 
  
}

if(obj.checkWin(planetes)){
  textSize(60);
  textAlign(CENTER);
  fill(0,230,0);
  text("You Win",width/2, height/2);
  noLoop();
  //exit();
  }
}

public void mouseReleased(){
  if(first != null){
  if(mouseY > height-tailleVert){
  Planete p = new Planete(mouseX, mouseY, rad, rad * 100000000000f, c);
  p.vx = (first.x - mouseX)/20;
  p.vy = (first.y - mouseY)/20;
  planetes.add(p);
  }
  first = null;
  }
  //rad = 5;
  //particules.add(new Particule(new PVector(mouseX, mouseY), 0, 0, random(-PI/4,PI/4)));
}


public int getRandomColor(){
  int _c = color(random(255),random(255), random(255));
  
  return _c;
  
}
class objectif{
  
  PVector pos;
  int c;
  int radius;
  
  objectif(PVector _pos, int rad, int _c){
    pos = _pos;
    radius = rad;
    c = _c;
  }
  
  public void show(){
    fill(c);
    ellipse(this.pos.x, this.pos.y, radius, radius);
  }
  
  public boolean checkWin(ArrayList<Planete> list){
    
    for(Planete p : list){
      if(dist(p.pos.x, p.pos.y, this.pos.x, this.pos.y) <= (this.radius/2 + p.radius/2)){
        return true; 
      }
    }
    return false;
  }
  
}
class Particule{
  int count;
  float vx, vy, teta;
  PVector pos;
  int c;
  
    Particule(PVector p, float _vx,  float _vy,float _teta){
    vx = _vx * cos(_teta);
    vy = _vy * sin(_teta);
    pos = new PVector(p.x, p.y);
    c = color(255);
  }
  
    Particule(PVector p, float _vx,  float _vy,float _teta, int _c){
    vx = _vx * cos(_teta);
    vy = _vy * sin(_teta);
    pos = new PVector(p.x, p.y);
    c = _c;
  }
  
  public void update(){
    if(count == 10){
      particules.remove(this);
    }
    else{
    pos.x += vx;
    pos.y += vy;
   }
    count++;
  }
  
  public void show(){
    float n = 255;
    noStroke();
    for(int i = 2; i < 30; i++){
    fill(red(c), green(c), blue(c), n);
    ellipse(pos.x, pos.y, i, i);
    n = n/i;
  }
    stroke(0);
    fill(255);
  }
}
class Planete  {
  PVector pos = new PVector();
  int radius;
  float vx, vy, ax, ay, a, mass;
  float G = 6.67f * pow(10, -11);
  boolean del = false;
  int c;
  
  
 Planete(int x, int y, int rad, float mas){
   pos.x = x;
   pos.y = y;
   radius = rad;
   mass = mas;
   c = color(255);
 } 
 
 Planete(int x, int y, int rad, float mas, int _c){
   pos.x = x;
   pos.y = y;
   radius = rad;
   mass = mas;
   c = _c;
 } 
 
 public float distance(Planete p){
   return sqrt( pow( (pos.x - p.pos.x), 2) + pow( (pos.y - p.pos.y),2 ));
 }
 
 public void show(){
  /*translate(this.pos.x, this.pos.y, 0);
  sphere(radius); */
  fill(c);
  ellipse(pos.x, pos.y, radius, radius);
 }
 public void move(){
   vx += ax;
   vy += ay;
   pos.x += vx;
   pos.y += vy;
 }
 
 public void update(Planete p){
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
 
  public void onTouch(Planete p){
   if(this.radius < p.radius){
     del = true;
     p.radius = PApplet.parseInt(sqrt( pow(this.radius,2) + pow(p.radius,2)));
     p.mass += this.mass;
   }
 }
 
 
 }
  public void settings() {  fullScreen(); }
}
