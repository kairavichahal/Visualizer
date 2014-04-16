//Kairavi Chahal | kchahal
//Project 1 | December 17, 2013
 
//Copyright Kairavi Chahal | 2013 | Carnegie Mellon University
//All rights reserved.

//PARTY AUDIO VISUALIZER
//UP/DOWN arrows to change size of circles.
//Can be hooked up to a screen and provide strobe lighting at a party.

//Play a song while grading/running this! :)

import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

Minim minim;
AudioInput in;
//AudioRecorder rec;
FFT fft;

int scale = 1000;

void setup() {
  size(displayHeight, displayHeight);
  
  minim = new Minim(this);
  in = minim.getLineIn(Minim.STEREO, 128);
  
  fft = new FFT(in.bufferSize(), in.sampleRate());
  
  background(#FFFFFF);
  noFill();
  stroke(#3CC656);
  strokeWeight(1);
  
  frameRate(15);
}

void draw() {
  background(#000000);
  fft.forward(in.mix);

  noStroke();
  ellipseMode(CENTER);
  
  for(int i=0; i < fft.specSize()-1; i++) {
    int row = i%8+1; int col = i/8+1;
    ellipseMode(CENTER);
    fill(#FFFFFF, fft.getBand(i)*10000);
    ellipse(col*width/9, row*height/9, in.left.get(i)*scale, in.right.get(i)*scale);
  } 
}

void stop() {
    in.close();
    minim.stop();
    super.stop();
}

void keyPressed() {
  if (keyCode == UP) {
    scale = scale + 100;
  } else if (keyCode == DOWN) {
    scale = scale - 100;
  }
//  textSize(48); text(scale, width/2, height/2);
}

boolean sketchFullScreen() {
  return true;
}

//PRELIMINARY EXPLORATION:
//  background(255);
  
//  for (int i = 0; i < in.left.size()-1; i++) { 
//    stroke(#FF0000);
//    line(0, in.left.get(i)*height*100, width/3, in.left.get(i)*height*100);
//    stroke(#00FF00);
//    line(width/3, in.mix.get(i)*height*100, 2*width/3, in.mix.get(i)*height*100);
//    stroke(#0000FF);
//    line(2*width/3, in.right.get(i)*height*100, width, in.right.get(i)*height*100);
//  }
  
//  fft.forward(in.mix);
//  for(int i = 0; i < 0+fft.specSize(); i++) {
//    pushMatrix();
//      stroke(255); noFill();
//      ellipse(width/2, height/2, fft.getBand(i)*100, fft.getBand(i)*100);
//    popMatrix();
//  }
