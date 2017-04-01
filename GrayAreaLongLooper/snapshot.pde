Movie glitchedVideo;
PImage glitchedVideoContainer;
int frameToSave;
int secondsToPlaySnapshot = 30;

void setupSnapshot() {
    glitchedVideoContainer = createImage(width, height, RGB);

    glitchedVideo = new Movie(this, "DarkClouds.mp4");
    glitchedVideo.loop();
}

void drawSnapshot() {
    // frameToSave =

    glitchedVideo.read();
    glitchedVideoContainer.copy(glitchedVideo, 0, 0, glitchedVideo.width, glitchedVideo.height, 0, 0, width, height);

    colorMorph();
    colorMorpher.blend(glitchedVideoContainer, 0, 0, width, height, 0, 0, width, height, ADD);
    image(colorMorpher, 0, 0);

    colorDrip();
}