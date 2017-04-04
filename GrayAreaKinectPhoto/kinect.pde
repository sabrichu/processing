Kinect kinect;

void setupKinect() {
    kinect = new Kinect(this);
    kinect.initDepth();
    kinect.initVideo();
}