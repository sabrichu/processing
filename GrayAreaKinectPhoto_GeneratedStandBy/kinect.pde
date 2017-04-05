Kinect kinect;
int closestX = 0;
int closestY = 0;
int closestPoint = 900;
int personEnteredThreshold = 500;
int personLeftThreshold = 870;
float deg;

void setupKinect() {
    kinect = new Kinect(this);
    kinect.initDepth();
    kinect.initVideo();

    deg = kinect.getTilt();
}

boolean isPersonOutOfRange() {
    //closestPoint = getKinectClosestPoint();
    return closestPoint > personLeftThreshold;
}

boolean isPersonInRange() {
  //closestPoint = getKinectClosestPoint();
    return closestPoint < personEnteredThreshold;
}

int getKinectClosestPoint() {
    return closestPoint;
  //int closestValue = 900;

  //  int[] rawDepth = kinect.getRawDepth();
  //  for (int i = 0; i < rawDepth.length; i++) {
  //      int currentDepthValue = rawDepth[i];

  //      if (currentDepthValue > 0 && currentDepthValue < closestValue) {
  //          closestValue = currentDepthValue;
  //          closestX = i % kinect.width;
  //          closestY = (i - closestX) / kinect.width;
  //      }
  //  }

  //  return closestValue;
}