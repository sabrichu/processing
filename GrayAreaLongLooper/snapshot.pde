Movie biosVideo;
Movie zoeVideo;
Movie[] zoeVideos = new Movie[3];

PImage biosVideoContainer;
PImage zoeVideoContainer;
int frameToSave;

void setupSnapshot() {
    biosVideoContainer = createImage(width, height, RGB);
    zoeVideoContainer = createImage(width, height, RGB);

    //biosVideo = new Movie(this, "Soap720.mov");
    biosVideo = new Movie(this, "Bios.m4v");
    zoeVideos[0] = new Movie(this, "Soap720.mov");
    zoeVideos[1] = new Movie(this, "DarkClouds.mp4");
    zoeVideos[2] = new Movie(this, "INK.mp4");

    zoeVideo = zoeVideos[0];
}

void prepareSnapshot() {
    biosVideo.jump(random(0, biosVideo.duration() - secondsToPlaySnapshot));
    zoeVideo.jump(random(0, zoeVideo.duration() - secondsToPlaySnapshot));
    biosVideo.play();
    zoeVideo.play();

    snapshotSeed.update();
    println("bioszoe: " + snapshotSeed.biosZoeBlendMode);
    println("color: " + snapshotSeed.colorMorpherBlendMode);
}

void drawSnapshot() {
    biosVideo.read();
    zoeVideo.read();
    biosVideoContainer.copy(biosVideo, 0, 0, biosVideo.width, biosVideo.height, 0, 0, width, height);
    zoeVideoContainer.copy(zoeVideo, 0, 0, zoeVideo.width, zoeVideo.height, 0, 0, width, height);

    // zoeVideoContainer.blend(biosVideoContainer, 0, 0, biosVideoContainer.width, biosVideoContainer.height, 0, 0, width, height, snapshotSeed.biosZoeBlendMode);
    biosVideoContainer.blend(zoeVideoContainer, 0, 0, zoeVideoContainer.width, zoeVideoContainer.height, 0, 0, width, height, snapshotSeed.biosZoeBlendMode);

    drawColorMorpher();

    // ADD, DIFFERENCE, EXCLUSION
    colorMorpher.blend(biosVideoContainer, 0, 0, width, height, 0, 0, width, height, snapshotSeed.colorMorpherBlendMode);
    // colorMorpher.blend(zoeVideoContainer, 0, 0, width, height, 0, 0, width, height, snapshotSeed.colorMorpherBlendMode);
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