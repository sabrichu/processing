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
        tint(255, 255);
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