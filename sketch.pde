import processing.sound.*;
//import peasy.*;

PImage img;
//PeasyCam cam;

SoundFile file;
Amplitude amp;

float d = 500;
float s = 25;

void setup() {
  size(900, 900, P3D);
  img = loadImage("image.png");
  img.resize(900, 900);
  
  //cam = new PeasyCam(this, 900);
  
  file = new SoundFile(this, "sound.mp3");
  file.play();
  
  amp = new Amplitude(this);
  amp.input(file);
}

void draw() {
  background(#f1f1f1);
  
  img.loadPixels();
  
  noStroke();
  sphereDetail(8);
  float tiles = 200;
  float tileSize = width/tiles;
  push();
  translate(width/2,height/2);
  rotateY(radians(frameCount)*1.5);
  
  float v = amp.analyze();
  
  directionalLight(450, 450, 450, .5, 0, -1);
  //ambientLight(236, 225, 255, 0, 0, 1);
 
  if(s > 1) {
    scale(s);
    s = s - 0.4;
  }
  
  for (int x = 0; x < tiles; x++) {
    for (int y = 0; y < tiles; y++) {
      color c = img.get(int(x*tileSize),int(y*tileSize));
      float b = map(brightness(c),0,255,1,0);
      float z = map(b,0,1,-100,100);
      
      //int i = int(y*tileSize + tileSize/2); 
      //int j = int(y*tileSize + tileSize/2);
      //int loc = i + j*width;          
      //color e = img.pixels[loc];
     
      push();
      
      translate(x*tileSize - width/2, y*tileSize - height/2, z);
  
      //e = color(red(int(img.pixels[loc])), green(int(img.pixels[loc])), blue(int(img.pixels[loc])));
      fill(c);

      box(tileSize*b*v*1.5);
      pop();     
    }
  }
  
  pop();
  
  //saveFrame("frame-####.jpg");

}
