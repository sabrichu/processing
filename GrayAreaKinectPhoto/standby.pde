Movie standbyVideo;
Movie helloVideo;

// Noise control
float xoff = 0;
float noiseFactor = 0.005;

// Loop control
int flickerLoopMinutes = 1;
int flickLoopFrames = 0;
float flickerMaxNumFrames;
int flickerFactor = 60;

void setupStandby() {
    flickerMaxNumFrames = frameRate * flickerLoopMinutes * 60;

    helloVideo = new Movie(this, "HelloSTART720.mov");

    standbyVideo = new Movie(this, "Declursified.mov");
    standbyVideo.loop();
}

void mountStandby() {
    helloVideo.jump(0);
    helloVideo.stop();
    mode = "standby";
}

void drawStandby() {
    background(0);

    if (helloVideo.time() == helloVideo.duration()) {
        helloVideo.jump(0);
        helloVideo.stop();
        System.gc();

        mountSnapshot();
    }

    if (!isPersonInRange() && helloVideo.time() <= 0) {
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
    textSize(72);
    fill(0, 255, 0);
    text("CLOSEST VALUE: " + closestPoint, 10, 100);

    fill(255, 0, 0);
    ellipse(closestX, closestY, 10, 10);
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
     // println("Standby tint mapped: " + mapped);

    fill(0, min(mapped, 100));
    rect(0, 0, width, height);
}