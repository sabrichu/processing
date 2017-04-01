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

void tintScreen(int closestPoint) {
    float mapped = floor(map(closestPoint, 0, 1048, 0, 255));

    // Debugging
    println("Standby tint mapped: " + mapped);

    fill(0, mapped);
    rect(0, 0, width, height);
}