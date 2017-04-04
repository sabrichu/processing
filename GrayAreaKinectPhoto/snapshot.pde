Movie biosVideo;
Movie zoeVideo;
Movie[] zoeVideos = new Movie[2];

PImage biosVideoContainer;
PImage zoeVideoContainer;
PImage kinectVideoContainer;
int frameToSave;

void setupSnapshot() {
    biosVideoContainer = createImage(width, height, RGB);
    zoeVideoContainer = createImage(width, height, RGB);
    kinectVideoContainer = createImage(width, height, RGB);

    zoeVideo = new Movie(this, "darkerClouds.mov");
    //zoeVideo = new Movie(this, "DarkClouds.mp4");
    biosVideo = new Movie(this, "moongrades.mov");
    //biosVideo = new Movie(this, "moons.mov");
}

void prepareSnapshot() {
    zoeVideo.loop();    
    biosVideo.loop();
    biosVideo.jump(random(biosVideo.duration()));

    snapshotSeed.update();
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

    //kinectVideoContainer.copy(kinect.getVideoImage(), 0, 0, kinect.width, kinect.height, 0, 0, width, height);

    drawColorDrip();
}

void stopSnapshot() {
    biosVideo.stop();
    zoeVideo.stop();

    System.gc();
}

void takeSnapshot() {
    //kinectVideoContainer.save(pathToImagesFolder + "user-snapshot-" + frameCount + ".png");

    // Should be good for over a week of snapshots, ha
    String paddedFrameCount = String.format("%07d", frameCount);
    filenameToSend = "snapshot-" + paddedFrameCount + ".png";
    saveFrame(pathToImagesFolder + "snapshot-#######.png");
    println("File saved: " + filenameToSend);

    // XXX: Move this so that we don't show the image right away
    OscMessage message = new OscMessage("/newSnapshot");
    message.add(filenameToSend);
    oscP5.send(message, oscLocation);
}