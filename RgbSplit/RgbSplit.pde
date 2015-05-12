void setup() {
  frameRate(25);
//  size(displayWidth, displayHeight);
  size(800, 600);
//  drawWhiteNoise();
  drawCross();
}

PImage sourceImage;
void drawCross() {
  sourceImage = loadImage("kreuz.jpg");
  sourceImage.loadPixels();
  image(sourceImage, 0, 0);
}

void drawWhiteNoise() {
  loadPixels();
  for (int x = 0; x < width; x += 1) {
    for (int y = 0; y < height; y += 1) {
      // rgb random
//      color c = color(random(0, 255), random(0, 255), random(0, 255));
      // grey random
      color c = color(random(0, 255));
      // Set each pixel onscreen to a grayscale value
      pixels[x + y * width] = c;
    }
  }
  updatePixels();
}

int redOffset = 0;
int greenOffset = 0;
int blueOffset = 0;

float quinticIn(float t, float b, float c, float d) {
  float ts=(t/=d)*t;
  float tc=ts*t;
  return b+c*(tc*ts);
}

int animationTimeRed = 0;
int animationTimeGreen = 0;
int animationTimeBlue = 0;

int animationBreakRed = 0;
int animationBreakGreen = 0;
int animationBreakBlue = 0;

final int animationDuration = 10;

boolean animationIncreaseRed = true;
boolean animationIncreaseGreen = true;
boolean animationIncreaseBlue = true;

void calculateNewOffset() {
  redOffset = round(quinticIn(animationTimeRed, 0, 5, animationDuration));
  greenOffset = round(quinticIn(animationTimeGreen, 0, -5, animationDuration));
  blueOffset = round(quinticIn(animationTimeBlue, 0, 10, animationDuration));
}

void advanceAnimations() {
  if (animationBreakRed <= 0) {
    if (!animationIncreaseRed && animationTimeRed <= 0) {
      animationBreakRed = round(random(0, 50));
      animationTimeRed = 0;
      animationIncreaseRed = true;
    } else if (animationIncreaseRed && animationTimeRed >= animationDuration) {
      animationIncreaseRed = false;
    } else if (animationIncreaseRed) {
      animationTimeRed += 1;
    } else {
      animationTimeRed -= 1;
    }
  } else {
    animationBreakRed -= 1;
  }
  
  if (animationBreakGreen <= 0) {
    if (!animationIncreaseGreen && animationTimeGreen <= 0) {
      animationBreakGreen = round(random(0, 50));
      animationTimeGreen = 0;
      animationIncreaseGreen = true;
    } else if (animationIncreaseGreen && animationTimeGreen >= animationDuration) {
      animationIncreaseGreen = false;
    } else if (animationIncreaseGreen) {
      animationTimeGreen += 1;
    } else {
      animationTimeGreen -= 1;
    }
  } else {
    animationBreakGreen -= 1;
  }
  
  if (animationBreakBlue <= 0) {
    if (!animationIncreaseBlue && animationTimeBlue <= 0) {
      animationBreakBlue = round(random(0, 50));
      animationTimeBlue = 0;
      animationIncreaseBlue = true;
    } else if (animationIncreaseBlue && animationTimeBlue >= animationDuration) {
      animationIncreaseBlue = false;
    } else if (animationIncreaseBlue) {
      animationTimeBlue += 1;
    } else {
      animationTimeBlue -= 1;
    }
  } else {
    animationBreakBlue -= 1;
  }
}

void shift() {
  PImage shiftedImage = createImage(sourceImage.width, sourceImage.height, RGB);
  for (int y = 0; y < sourceImage.height; y += 1) {
    for (int x = 0; x < sourceImage.width; x += 1) {
      color oldColor = sourceImage.pixels[x + y * sourceImage.width];
      
      float newRed;
      int newRedXPosition = x + redOffset;
      if (newRedXPosition < 0 || newRedXPosition >= sourceImage.width) {
        // neighbor position would be out of bound
        newRed = oldColor >> 16 & 0xFF;
      } else {
        // take the red from a neighbor
        newRed = sourceImage.pixels[y * sourceImage.width + newRedXPosition] >> 16 & 0xFF;
      }
      
      float newGreen;
      int newGreenXPosition = x + greenOffset;
      if (newGreenXPosition < 0 || newGreenXPosition >= sourceImage.width) {
        // neighbor position would be out of bound
        newGreen = oldColor >> 8 & 0xFF;
      } else {
        // take the red from a neighbor
        newGreen = sourceImage.pixels[y * sourceImage.width + newGreenXPosition] >> 8 & 0xFF;
      }
      
      float newBlue;
      int newBlueYPosition = y + blueOffset;
      if (newBlueYPosition < 0 || newBlueYPosition >= sourceImage.height) {
        // neighbor position would be out of bound
        newBlue = oldColor & 0xFF;
      } else {
        // take the red from a neighbor
        newBlue = sourceImage.pixels[newBlueYPosition * sourceImage.width + x] & 0xFF;
      }
      
      shiftedImage.pixels[x + y * sourceImage.width] = color(newRed, newGreen, newBlue);
    }
  }
  image(shiftedImage, 0, 0);
}

void draw() {
  shift();
  calculateNewOffset();
  advanceAnimations();
}

