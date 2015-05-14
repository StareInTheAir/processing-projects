class QuinticAnimator extends LoopingPausingAnimator {
  float getAnimationValue(float beginningValue, float endValue) {
    float t = super.time / super.animationDuration;
    float ts = t * t;
    float tc = ts * t;
    return beginningValue + endValue * (tc * ts);
  }
  
  QuinticAnimator(int animationDuration, int minPauseDuration, int maxPauseDuration) {
    super(animationDuration, minPauseDuration, maxPauseDuration);
  }
}

