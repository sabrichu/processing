Movie biosVideo;
Movie zoeVideo;
PImage biosVideoContainer;
PImage zoeVideoContainer;
int frameToSave;

void setupSnapshot() {
    biosVideoContainer = createImage(width, height, RGB);
    zoeVideoContainer = createImage(width, height, RGB);

    //biosVideo = new Movie(this, "Soap720.mov");
    biosVideo = new Movie(this, "darkerClouds.mov");
    biosVideo.loop();

    zoeVideo = new Movie(this, "Soap720.mov");
    zoeVideo.loop();
}

void prepareSnapshot() {
    biosVideo.jump(random(0, biosVideo.duration()));
    zoeVideo.jump(random(0, biosVideo.duration()));

    snapshotSeed.update();
}

void drawSnapshot() {
    biosVideo.read();
    biosVideoContainer.copy(biosVideo, 0, 0, biosVideo.width, biosVideo.height, 0, 0, width, height);
    zoeVideo.read();
    zoeVideoContainer.copy(zoeVideo, 0, 0, zoeVideo.width, zoeVideo.height, 0, 0, width, height);
    zoeVideoContainer.blend(biosVideoContainer, 0, 0, biosVideoContainer.width, biosVideoContainer.height, 0, 0, width, height, snapshotSeed.biosZoeBlendMode);

    drawColorMorpher();

    // ADD, DIFFERENCE, EXCLUSION
    colorMorpher.blend(zoeVideoContainer, 0, 0, width, height, 0, 0, width, height, snapshotSeed.colorMorpherBlendMode);
    image(colorMorpher, 0, 0);

    drawColorDrip();
}

void stopSnapshot() {
    biosVideo.stop();
    zoeVideo.stop();

    System.gc();
}

void takeSnapshot() {
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