Movie biosVideo;
Movie zoeVideo;

PImage biosVideoContainer;
PImage zoeVideoContainer;
PImage kinectVideoContainer;

void setupSnapshot() {
    biosVideoContainer = createImage(width, height, RGB);
    zoeVideoContainer = createImage(width, height, RGB);
    kinectVideoContainer = createImage(width, height, RGB);

    zoeVideo = new Movie(this, "Clouds1080p.mov");
    biosVideo = new Movie(this, "moongrades.mov");
}

void mountSnapshot() {
    zoeVideo.loop();
    biosVideo.loop();
    biosVideo.jump(random(biosVideo.duration()));

    snapshotSeed.update();
    mode = "snapshot";
}

void drawSnapshot() {
    biosVideo.read();
    zoeVideo.read();
    biosVideoContainer.copy(biosVideo, 0, 0, biosVideo.width, biosVideo.height, 0, 0, width, height);
    zoeVideoContainer.copy(zoeVideo, 0, 0, zoeVideo.width, zoeVideo.height, 0, 0, width, height);
    zoeVideoContainer.blend(biosVideoContainer, 0, 0, biosVideoContainer.width, biosVideoContainer.height, 0, 0, width, height, DIFFERENCE);
    //zoeVideoContainer.blend(biosVideoContainer, 0, 0, biosVideoContainer.width, biosVideoContainer.height, 0, 0, width, height, EXCLUSION);
    //biosVideoContainer.blend(zoeVideoContainer, 0, 0, zoeVideoContainer.width, zoeVideoContainer.height, 0, 0, width, height, SUBTRACT);

    drawColorMorpher();
    // ADD, DIFFERENCE, EXCLUSION
    //colorMorpher.blend(biosVideoContainer, 0, 0, width, height, 0, 0, width, height, ADD);
    colorMorpher.blend(zoeVideoContainer, 0, 0, width, height, 0, 0, width, height, ADD);
    image(colorMorpher, 0, 0);
    drawColorDrip();

    if (snapshotFrameCounter < snapshotSeed.frameToTakeSnapshot) {
        kinectVideoContainer.copy(kinect.getVideoImage(), 0, 0, kinect.width, kinect.height, 0, 0, width, height);
    }
}

void stopSnapshot() {
    biosVideo.stop();
    zoeVideo.stop();
    kinectVideoContainer.blend(colorMorpher, 0, 0, width, height, 0, 0, width, height, DIFFERENCE);
    kinectVideoContainer.save(pathToImagesFolder + "user-" + filenameToSend);

    //OscMessage message = new OscMessage("/newSnapshot");
    //message.add(filenameToSend);
    //oscP5.send(message, oscLocation);

    System.gc();
}

void takeSnapshot() {
    // Should be good for over a week of snapshots, ha
    String paddedFrameCount = String.format("%07d", frameCount);
    filenameToSend = "snapshot-" + paddedFrameCount + ".png";
    saveFrame(pathToImagesFolder + "snapshot-#######.png");
    println("File saved: " + filenameToSend);
}