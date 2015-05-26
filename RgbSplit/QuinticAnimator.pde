class QuinticAnimator extends LoopingPausingAnimator {
  QuinticAnimator(int animationDuration, int minPauseDuration, int maxPauseDuration) {
    super(animationDuration, minPauseDuration, maxPauseDuration);
  }
  
  float getAnimationValue(float beginningValue, float endValue) {
    float t = super.time / super.animationDuration;
    float ts = t * t;
    float tc = ts * t;
    return beginningValue + endValue * (tc * ts);
  }
}

