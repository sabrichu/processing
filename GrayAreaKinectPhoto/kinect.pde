Kinect kinect;
int closestX = 0;
int closestY = 0;

int personEnteredThreshold = 350;

void setupKinect() {
    kinect = new Kinect(this);
    kinect.initDepth();
    kinect.initVideo();
}

int getKinectClosestPoint() {
    int closestValue = 9000;

    int[] rawDepth = kinect.getRawDepth();
    for (int i = 0; i < rawDepth.length; i++) {
        int currentDepthValue = rawDepth[i];

        if (currentDepthValue > 0 && currentDepthValue < closestValue) {
            closestValue = currentDepthValue;
            closestX = i % kinect.width;
            closestY = (i - closestX) / kinect.width;
        }
    }

    return closestValue;
}