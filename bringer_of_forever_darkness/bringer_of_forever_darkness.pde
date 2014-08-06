import vialab.SMT.event.*;
import vialab.SMT.util.*;
import vialab.SMT.*;
import vialab.SMT.renderer.*;
import vialab.SMT.swipekeyboard.*;

import vialab.SMT.*;

int num = 20;
float step, sz, offSet, theta, angle;
float[] thetasX;
float[] thetasY;
float[] heights;
boolean[] active;
float speed;
float currColor;
int touches;
 
void setup() {
  int w = displayWidth;
  int h = displayHeight;
  currColor = 0;
  size( w, h, SMT.RENDERER );
  SMT.init( this, TouchSource.AUTOMATIC);
  strokeWeight(30 * (w / 600));
  step = w / 20;
  
  speed = .1;
  noCursor();
  
//  SMT.init( this, TouchSource.AUTOMATIC);

  Zone zone = new Zone( "MyZone");
  SMT.add( zone);
  
  SMT.setTouchDraw(TouchDraw.NONE);
  
  thetasX = new float[num];
  thetasY = new float[num];
  heights = new float[num * 2];
  active = new boolean[num * 2];
  for (int i = 0; i < num; i++) {
    thetasX[i] = 0;
  }
  for (int i = 0; i < num; i++) {
    thetasY[i] = 0;
  }
  for (int i = 0; i < num * 2; i++) {
    heights[i] = 0;
  }
  for (int i = 0; i < num * 2; i++) {
    active[i] = false;
  }
}

void drawMyZone( Zone zone){
  currColor += .001;
//  colorMode(HSB,255,100,100);
//  background(255, 255, 255);
  noStroke();
//  fill(currColor % 1 * 255, 255, 255, 255);
//  rect(0, 0, width, height);
  fill(255, 255, 255, touches * 10);
  rect(0, 0, width, height);
//  colorMode(RGB);
//  translate(width/2, height);
  angle=0; 
//  for (int i=0; i<thetasX.length; i++) {
//    colorMode(HSB,255,100,100);
//    sz = i*step;
////    float offSet = TWO_PI/num*i;
////    float arcEnd = map(thetas[i],-1,1, PI, TWO_PI);
//    line(i * 30, height, i * 30, height - thetasX[i] * height);
//    stroke(0, 0, 0);
//  }
  
  for (int i=0; i<thetasY.length; i++) {
    colorMode(HSB,255,100,100);
    sz = i*step;
//    float offSet = TWO_PI/num*i;
//    float arcEnd = map(thetas[i],-1,1, PI, TWO_PI);
    if (i % 2 == 0) {
      line(0, i * (height / 20), thetasY[i] * width, i * (height / 20));
    } else {
      line(width, i * (height / 20), width - thetasY[i] * width, i * (height / 20));
    }
    stroke(0, 0, 0);
    if (i == 0) {
      println(thetasY[i]);
    }
  }
  
//  for (int i=num; i<num * 2; i++) {
//    colorMode(HSB,255,100,100);
//    stroke(255 - heights[i] * 255, 90, 90);
//    noFill();
//    sz = (i - 20)*step + step / 2;
//    float offSet = TWO_PI/num*i;
//    float arcEnd = map(thetas[i],-1,1, PI, TWO_PI);
//    arc(0, 0, sz, sz, arcEnd, TWO_PI);
//  }
  colorMode(RGB);
  resetMatrix();
  touches = 0;
}

void pickDrawMyZone( Zone zone){
  rect( 0, 0, width, height);
}

void draw() {
  for (int i = 0; i < num; i++) {
    thetasX[i] -= speed;
    if (thetasX[i] < 0) {
      thetasX[i] = 0;
    }
  }
  
  for (int i = 0; i < thetasY.length; i++) {
    thetasY[i] -= speed;
    if (thetasY[i] < 0) {
      thetasY[i] = 0;
    }
  }
}

void touchMyZone( Zone zone){
  touches = zone.getTouches().length;
  for (int i = 0; i < zone.getTouches().length; i++) {
    int slice = floor(zone.getTouches()[i].getX() / width * 20);
    thetasX[slice] += speed * 2;
    heights[num - slice] = zone.getTouches()[i].getY() / height;
    if (thetasX[slice] >= 1 + speed) {
      thetasX[slice] = 1 + speed;
    }
    
    int sliceY = floor(zone.getTouches()[i].getY() / height * 20);
    thetasY[sliceY] += speed * 2;
    heights[num - slice] = zone.getTouches()[i].getX() / width;
    if (thetasY[sliceY] >= 1 + speed) {
      thetasY[sliceY] = 1 + speed;
    }
  }
//  zone.rst();
}

boolean sketchFullScreen() {
  return true;
}
