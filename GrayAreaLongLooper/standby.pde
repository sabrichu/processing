Kinect kinect;
int closestX = 0;
int closestY = 0;
Movie standbyVideo;
Movie helloVideo;
float videoWidthPercentage = 0.5;

// Noise control
float xoff = 0;
float noiseFactor = 0.005;

// Loop control
int flickerLoopMinutes = 1;
int flickLoopFrames = 0;
float flickerMaxNumFrames;
int flickerFactor = 60;

int personEnteredThreshold = 350;

void setupStandby() {
    flickerMaxNumFrames = frameRate * flickerLoopMinutes * 60;

    kinect = new Kinect(this);
    kinect.initDepth();

    helloVideo = new Movie(this, "HelloSTART720.mov");

    standbyVideo = new Movie(this, "Declursified.mov");
    standbyVideo.loop();
}

void drawStandby() {
    background(0);

    int closestPoint = getKinectClosestPoint();
    boolean isPersonOutOfRange = closestPoint > personEnteredThreshold;

    if (helloVideo.time() == helloVideo.duration()) {
        helloVideo.jump(0);
        helloVideo.stop();
        System.gc();

        prepareSnapshot();
        mode = "snapshot";
    }

    if (isPersonOutOfRange && helloVideo.time() <= 0) {
        standbyVideo.read();
        drawCenteredVideo(standbyVideo);

        tintScreen(closestPoint);
        glitchOut();
    } else {
        tint(255, 255);

        helloVideo.play();
        helloVideo.read();

        drawCenteredVideo(helloVideo);
        // filter(INVERT);
    }

    // Debugging
    if (closestPoint < 350) {
        println("Closest point: " + closestPoint);
    }
    fill(255, 0, 0);
    ellipse(closestX, closestY, 10, 10);
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

void glitchOut() {
    float relativeVideoHeight = getRelativeVideoHeight(standbyVideo);

    loadPixels();

    for (int i = 0; i < width; i++) {
        int randomY = floor(map(noise(xoff), 0, 1, height / 4, height));
        float endHeightOfRect = height - randomY - (height - relativeVideoHeight) / 2;

        int pixelIndex = width * (randomY - 1) + i;

        if (pixelIndex > 0 & pixelIndex < pixels.length) {
            fill(pixels[pixelIndex]);
            rect(i, randomY, 1, endHeightOfRect);
        }

        if (
            // XXX: There's probably a way to do this using sin()...
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

void tintScreen(int closestPoint) {
    float mapped = floor(map(closestPoint, 0, 1048, 0, 255));

    // Debugging
     println("Standby tint mapped: " + mapped);

    fill(0, min(mapped, 200));
    rect(0, 0, width, height);
}