import processing.video.*;
import org.openkinect.freenect.*;
import org.openkinect.processing.*;
//import deadpixel.keystone.*;
import codeanticode.syphon.*;

//Keystone keystone;
//CornerPinSurface keystoneSurface;

Movie video;
Movie standbyVideo;
SyphonServer server;

Kinect kinect;
int closestX = 0;
int closestY = 0;

// Noise control
float xoff = 0;
float noiseFactor = 0.005;

// Loop control
int flickerLoopMinutes = 1;
int flickLoopFrames = 0;
float flickerMaxNumFrames;
int flickerFactor = 60;

int personEnteredThreshold = 350;

void settings() {
    size(1200, 800, P3D);
    PJOGL.profile = 1;
}

void setup() {
    noStroke();

    flickerMaxNumFrames = frameRate * flickerLoopMinutes * 60;

    //keystone = new Keystone(this);
    //keystoneSurface = keystone.createCornerPinSurface(width, height, 20);

    kinect = new Kinect(this);
    kinect.initDepth();

    video = new Movie(this, "Picture.mov");

    standbyVideo = new Movie(this, "Declursified.mov");
    standbyVideo.loop();

    server = new SyphonServer(this, "Processing Syphon");
}

void draw() {
    int closestPoint = getKinectClosestPoint();
    boolean isPersonOutOfRange = closestPoint > personEnteredThreshold;

    if (video.time() == video.duration()) {
        video.jump(0);
        video.stop();
    }

    if (isPersonOutOfRange && video.time() <= 0) {
        standbyVideo.read();
        image(standbyVideo, 0, 0, width, height);

        tintScreen(closestPoint);
        glitchOut();
    } else {
        video.play();
        video.read();
        image(video, 0, 0, width, height);
        filter(INVERT);
    }

    // Debugging
    if (closestPoint < 350) {
        println("Closest point: " + closestPoint);
    }
    fill(255, 0, 0);
    ellipse(closestX, closestY, 10, 10);

    server.sendImage(get());
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

void tintScreen(int closestPoint) {
    float mapped = floor(map(closestPoint, 0, 1048, 0, 255));

    // Debugging
    println("Standby tint mapped: " + mapped);

    fill(0, mapped);
    rect(0, 0, width, height);
}

void glitchOut() {
    loadPixels();

    for (int i = 0; i < width; i++) {
        int randomY = floor(map(noise(xoff), 0, 1, height / 6, height));
        int endHeightOfRect = height - randomY;

        int pixelIndex = width * (randomY - 1) + i;

        if (pixelIndex > 0 & pixelIndex < pixels.length) {
            fill(pixels[pixelIndex]);
            rect(i, randomY, 1, endHeightOfRect);
        }

        if (
            flickLoopFrames > flickerMaxNumFrames / 3 &
            flickLoopFrames < flickerMaxNumFrames / 3 * 2
        ) {
            xoff += noiseFactor;
        }
    }

    xoff += noiseFactor;

    if (flickLoopFrames == flickerMaxNumFrames) {
        flickLoopFrames = 0;
    }

    flickLoopFrames++;
}