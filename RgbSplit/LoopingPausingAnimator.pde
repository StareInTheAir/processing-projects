abstract class LoopingPausingAnimator {
  int time;
  int remainingPauseDuration;  
  boolean increase;
  final int animationDuration;
  final int minPauseDuration;
  final int maxPauseDuration; 

  LoopingPausingAnimator(int animationDuration, int minPauseDuration, int maxPauseDuration) {
    this.animationDuration = animationDuration;
    this.minPauseDuration = minPauseDuration;
    this.maxPauseDuration = maxPauseDuration;
    
    this.time = 0;
    this.remainingPauseDuration = 0;
    this.increase = true;
  }

  void advanceAnimation() {
    if (remainingPauseDuration <= 0) {
      if (!increase && time <= 0) {
        remainingPauseDuration = round(random(minPauseDuration, maxPauseDuration));
        time = 0;
        increase = true;
      } else if (increase && time >= animationDuration) {
        increase = false;
      } else if (increase) {
        time += 1;
      } else {
        time -= 1;
      }
    } else {
      remainingPauseDuration -= 1;
    }
  }
  
  abstract float getAnimationValue(float beginningValue, float endValue);
}

