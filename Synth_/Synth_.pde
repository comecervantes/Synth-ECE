PFont myFont; 

PImage logo;
PImage ne555;
PImage metronome;
PImage synthe;
PImage note;

import processing.serial.*;
import controlP5.*; 

Serial myPort; 
ControlP5 cp5; 

int bt; 
int bpm; 
int fr; 
int frNE; 
int metro; 
int synth; 
int range; 

void setup(){
  
  size(1200, 800); 
  
  myFont = createFont("Calibri" , 20); 
  textAlign(CENTER, CENTER); 
  textFont(myFont); 
  
  logo = loadImage("logo_ece.png");
  ne555 = loadImage("ne555.png");
  metronome = loadImage("metronome.png");  
  synthe = loadImage("synthe.png");
  note = loadImage("note.png");
  
  logo.resize(440, 250); 
  ne555.resize(180, 200); 
  note.resize(110, 110); 
  
  synthe.resize(70, 70); 
  metronome.resize(90, 90); 
  
  
  myPort = new Serial(this, Serial.list()[5], 9600);
  myPort.bufferUntil('\n'); 
  
  cp5 = new ControlP5(this); 
  
  //cp5.addButton("MUSIQUE") 
     //.setPosition(842, 305)
     //.setSize(100, 100);
  
}

void draw(){
  
String inString = myPort.readStringUntil('\n');
 if (inString != null){
 
 inString = trim(inString);
 int inputs[] = int(split(inString,',')); // on élude les virgules
 
  if(inputs.length == 7){
   bt = inputs[0];
   bpm = inputs[1];
   fr = inputs[2];
   metro = inputs[3];
   synth = inputs[4];
   range = inputs[5];
 }
  
}
    
  
  background(0,122,123); 
 
  
    // premier carré
    
  noStroke(); 
  fill(255,255,255); 
  
  rect(5, 10, 1190, 255, 12, 12, 12, 12); 
  
  fill(0,122,123); 
  
  rect(20, 25, 600, 225, 12, 12, 12, 12); 
  
  fill(255, 255, 255);
  
  textSize(20); 
  text("BPM Métronome", 180, 220); 
  textSize(70);
  text(bpm, 180, 120); 
  
  textSize(20); 
  text("Fr Métronome", 440, 220); 
  textSize(70);
  text(fr, 440, 120); 
    
  image(logo, 680, 10);
    
    // deuxième carré
    
    
  fill(255,255,255); 
    
  rect(5, 274, 1190, 250, 12, 12, 12, 12); 
  
  fill(0,122,123); 
  
  rect(20, 289, 600, 225, 12, 12, 12, 12); 
  
  fill(255,255,255);
  
  image(ne555, 30, 300);
  
  textSize(20); 
  text("Fréquence de sortie du NE555", 390, 320); 
  text("en temps réel", 390, 350); 
  
  textSize(70); 
  
  text(frNE, 360, 410); 
  text("Hz", 470, 410); 
  
  image(metronome, 640, 310);
  image(synthe, 650, 410);
  
      fill(0,122,123); 
  circle(900, 400, 150);
  image(note, 842, 345);
  
  rect(1100, 280, 40, 239, 12, 12, 12, 12); 

   fill(255,255,255); 
  rect(1105, 510, 30, -220 + (range*42) , 12, 12, 12, 12); 

    // clavier 
   
  noStroke(); 
  fill(255,255,255); 
    
  rect(5, 534, 65, 260, 12, 12, 12, 30);
  rect(75, 534, 65, 260, 12, 12, 12, 12);
  rect(145, 534, 65, 260, 12, 12, 30, 12);
  
  rect(215, 534, 65, 260, 12, 12, 12, 30);
  rect(285, 534, 65, 260, 12, 12, 12, 12);
  rect(355, 534, 65, 260, 12, 12, 12, 12);
  rect(425, 534, 65, 260, 12, 12, 30, 12);
  
  rect(495, 534, 65, 260, 12, 12, 12, 30); //1
  rect(565, 534, 65, 260, 12, 12, 12, 12); //2
  rect(635, 534, 65, 260, 12, 12, 30, 12); //3
  
  rect(705, 534, 65, 260, 12, 12, 12, 30); //4
  rect(775, 534, 65, 260, 12, 12, 12, 12); //5
  rect(845, 534, 65, 260, 12, 12, 12, 12); //6
  rect(915, 534, 65, 260, 12, 12, 30, 12); //7
  
  rect(985, 534, 65, 260, 12, 12, 12, 30);
  rect(1055, 534, 65, 260, 12, 12, 12, 12);
  rect(1125, 534, 65, 260, 12, 12, 30, 12);
  
  fill(0,0,0);
  
  rect(49, 530, 46, 150, 5, 5, 10, 10);
  rect(119, 530, 46, 150, 5, 5, 10, 10);

  rect(259, 530, 46, 150, 5, 5, 10, 10);
  rect(329, 530, 46, 150, 5, 5, 10, 10);
  rect(399, 530, 46, 150, 5, 5, 10, 10);

  rect(539, 530, 46, 150, 5, 5, 10, 10);
  rect(609, 530, 46, 150, 5, 5, 10, 10);

  rect(749, 530, 46, 150, 5, 5, 10, 10);
  rect(819, 530, 46, 150, 5, 5, 10, 10);
  rect(889, 530, 46, 150, 5, 5, 10, 10);
  
  rect(1029, 530, 46, 150, 5, 5, 10, 10);
  rect(1099, 530, 46, 150, 5, 5, 10, 10);
  
  textSize(20); 

  text("do", 527, 760); 
  text("re", 597, 760); 
  text("mi", 663, 760); 
  
  text("fa", 737, 760); 
  text("sol", 809, 760); 
  text("la", 875, 760); 
  text("si", 945, 760); 

  stroke(100); 
  
    fill(231, 76, 60); 
  circle(527, 720, 35);
  
    fill(142, 68, 173); 
  circle(597, 720, 35);
  
    fill(52, 152, 219); 
  circle(667, 720, 35);
  
    fill(22, 160, 133); 
  circle(737, 720, 35);
  
    fill(46, 204, 113); 
  circle(807, 720, 35);
  
    fill(241, 196, 15); 
  circle(877, 720, 35);
  
    fill(211, 84, 0); 
  circle(947, 720, 35);
  
  fill(200, 0, 0); 
  textSize(80); 
  
  if ( synth == 0) {
  text("X", 685, 435);
  }
  else if(metro == 0){
  text("X", 685, 355); 
  }
  
  noStroke(); 
  fill(0, 0, 0, 100); 
  
  if(bt == 1 && synth == 1){
      rect(495, 534, 65, 260, 12, 12, 12, 30); //1
      frNE = 60; 
  }
  else if(bt == 2 && synth == 1){
      rect(565, 534, 65, 260, 12, 12, 12, 12); //2
      frNE = 55; 
  }  
  else if(bt == 3 && synth == 1){
      rect(635, 534, 65, 260, 12, 12, 30, 12); //3
      frNE = 44; 
  }  
  else if(bt == 4 && synth == 1){
      rect(705, 534, 65, 260, 12, 12, 12, 30); //4
      frNE = 41; 
  }  
  else if(bt == 5 && synth == 1){
      rect(775, 534, 65, 260, 12, 12, 12, 12); //5
      frNE = 27; 
  }  
  else if(bt == 6 && synth == 1){
      rect(845, 534, 65, 260, 12, 12, 12, 12); //6
      frNE = 38; 
  }  
  else if(bt == 7 && synth == 1){
      rect(915, 534, 65, 260, 12, 12, 30, 12); //7
      frNE = 32; 
  }
  else {
        frNE = 0; 
  }
  
}

void controleEvent(ControlEvent theEvent) {
  if(theEvent.isController()) {
    if(theEvent.getController().getName()=="MUSIQUE") {
      myPort.write('a'); 
      println("MUSIQUE"); 
    }
  }
}
