PImage sourceImage;

final int animationDuration = 10;
final int maxPauseDuration = 50;
final int minPauseDuration = 0;

LoopingPausingAnimator redXAnimator;
LoopingPausingAnimator redYAnimator;
LoopingPausingAnimator blueXAnimator;
LoopingPausingAnimator blueYAnimator;
LoopingPausingAnimator greenXAnimator;
LoopingPausingAnimator greenYAnimator;

int redXOffset = 0;
int redYOffset = 0;
int greenXOffset = 0;
int greenYOffset = 0;
int blueXOffset = 0;
int blueYOffset = 0;

void setup() {
  frameRate(10);
//  size(displayWidth, displayHeight);
  size(800, 600);
//  drawWhiteNoise();
  drawCross();
  image(sourceImage, 0, 0);
  
  setupAnimators();
}

void setupAnimators() {
  redXAnimator = new QuinticAnimator(animationDuration, minPauseDuration, maxPauseDuration);
  redYAnimator = new QuinticAnimator(animationDuration, minPauseDuration, maxPauseDuration);
  blueXAnimator = new QuinticAnimator(animationDuration, minPauseDuration, maxPauseDuration);
  blueYAnimator = new QuinticAnimator(animationDuration, minPauseDuration, maxPauseDuration);
  greenXAnimator = new QuinticAnimator(animationDuration, minPauseDuration, maxPauseDuration);
  greenYAnimator = new QuinticAnimator(animationDuration, minPauseDuration, maxPauseDuration);
}

void drawCross() {
  sourceImage = loadImage("kreuz.jpg");
  sourceImage.loadPixels();
}

void drawWhiteNoise() {
  sourceImage = createImage(400, 400, RGB);
  for (int x = 0; x < sourceImage.width; x += 1) {
    for (int y = 0; y < sourceImage.height; y += 1) {
      // rgb random
//      color c = color(random(0, 255), random(0, 255), random(0, 255));
      // grey random
      color c = color(random(0, 255));
      // Set each pixel onscreen to a grayscale value
      sourceImage.pixels[x + y * sourceImage.width] = c;
    }
  }
}

void calculateNewOffset() {
  redXOffset = round(redXAnimator.getAnimationValue(0, 5));
  redYOffset = round(redYAnimator.getAnimationValue(0, 5));
  greenXOffset = round(greenXAnimator.getAnimationValue(0, 5));
  greenYOffset = round(greenYAnimator.getAnimationValue(0, 5));
  blueXOffset = round(blueXAnimator.getAnimationValue(0, 5));
  blueYOffset = round(blueYAnimator.getAnimationValue(0, 5));
}

void advanceAnimations() {
  redXAnimator.advanceAnimation();
  redYAnimator.advanceAnimation();
  blueXAnimator.advanceAnimation();
  blueYAnimator.advanceAnimation();
  greenXAnimator.advanceAnimation();
  greenYAnimator.advanceAnimation();
}

void shift() {
  PImage shiftedImage = createImage(sourceImage.width, sourceImage.height, RGB);
  for (int y = 0; y < sourceImage.height; y += 1) {
    for (int x = 0; x < sourceImage.width; x += 1) {
      color oldColor = sourceImage.pixels[x + y * sourceImage.width];
      
      float newRed;
      int newRedXPosition = x + redXOffset;
      if (newRedXPosition < 0 || newRedXPosition >= sourceImage.width) {
        // neighbor position would be out of bound
        newRed = oldColor >> 16 & 0xFF;
      } else {
        // take the red from a neighbor
        newRed = sourceImage.pixels[y * sourceImage.width + newRedXPosition] >> 16 & 0xFF;
      }
      
      float newGreen;
      int newGreenXPosition = x + greenYOffset;
      if (newGreenXPosition < 0 || newGreenXPosition >= sourceImage.width) {
        // neighbor position would be out of bound
        newGreen = oldColor >> 8 & 0xFF;
      } else {
        // take the red from a neighbor
        newGreen = sourceImage.pixels[y * sourceImage.width + newGreenXPosition] >> 8 & 0xFF;
      }
      
      float newBlue;
      int newBlueYPosition = y + blueYOffset;
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
  advanceAnimations();
  calculateNewOffset();
}

