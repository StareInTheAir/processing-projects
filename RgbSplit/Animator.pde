class LoopingPausingAnimator {
  int time;
  int remainingPauseDuration;
  boolean increase;
  final int animationDuration;
  final int minPauseDuration;
  final int maxPauseDuration; 

  LoopingPausingAnimator(int pauseDuration, int animationDuration, int minPauseDuration, int maxPauseDuration) {
    this.pauseDuration = pauseDuration;
    this.animationDuration = animationDuration;
    this.minPauseDuration = minPauseDuration;
    this.maxPauseDuration = maxPauseDuration;
  }

  void advanceAnimations() {
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
}

