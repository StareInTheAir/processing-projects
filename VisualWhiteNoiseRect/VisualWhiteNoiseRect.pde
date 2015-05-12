int scaleFactor = 1;

void setup() {
  frameRate(5);
  size(displayWidth, displayHeight);
//  size(800, 600);
  noCursor();
  noStroke();
}

void setScaleFactor(int newScaleFactor) {
  if (newScaleFactor > 0) {
    scaleFactor = newScaleFactor;
  }
  println("scale factor = " + scaleFactor);
}

boolean sketchFullScreen() {
  return true;
}

void keyPressed() {
  if (key == '+') {
    setScaleFactor(scaleFactor + 1);
  } else if (key == '-') {
    setScaleFactor(scaleFactor - 1);
  } 
}

void draw() {
  for (int x = 0; x < width; x += scaleFactor) {
    for (int y = 0; y < height; y += scaleFactor) {
      // rgb random
//      color c = color(random(0, 255), random(0, 255), random(0, 255));
      // grey random
      color c = color(random(0, 255));
      fill(c);
      rect(x, y, scaleFactor, scaleFactor);
    }
  }
}

