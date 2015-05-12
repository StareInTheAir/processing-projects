int scaleFactor = 1;

void setup() {
  frameRate(5);
  size(displayWidth, displayHeight);
  //size(800, 600);
  noCursor();
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
  loadPixels();
  for (int x = 0; x < width; x += scaleFactor) {
    for (int y = 0; y < height; y += scaleFactor) {
      // rgb random
//      color c = color(random(0, 255), random(0, 255), random(0, 255));
      // grey random
      color c = color(random(0, 255));
      for (int heightInc = 0; heightInc < scaleFactor; heightInc += 1) {
        for (int widthInc = 0; widthInc < scaleFactor; widthInc += 1) {
          if (x + widthInc < width && y + heightInc < height) {
            // Set each pixel onscreen to a grayscale value
            pixels[x + widthInc + (y + heightInc) * width] = c;
          }
        }
      }
    }
  }
  updatePixels();
}

