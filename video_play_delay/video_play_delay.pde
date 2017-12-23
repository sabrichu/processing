import codeanticode.syphon.*;


import processing.video.*;
//Capture video;

Movie video;
SyphonServer server;
PImage camContainer;
PImage camContainerDelay;
int numberFrameDelay = 50;

int indexToWrite = 0;
int indexToRead = 1;
PImage[] savedCamFrames = new PImage[numberFrameDelay];

void settings() {
    //video = new Movie(this, "why.mov");
    
    size(1000, 500, P3D);
    PJOGL.profile = 1;
}

void setup() {
    //video = new Capture(this, Capture.list()[0]);
    //video.start();

  
  //frameRate(15);
    video = new Movie(this, "why.mov");
    //video.speed(-1);
    video.loop();
    server = new SyphonServer(this, "Processing Syphon");
}

void draw() {
    video.read();
        savedCamFrames[indexToWrite] = video.get();

    camContainer = createImage(width, height, RGB);
     camContainerDelay = createImage(width, height, RGB);
    camContainer.copy(video, 0, 0, width, height, 0, 0, width, height);

    if (savedCamFrames[indexToRead] != null) {
         camContainerDelay.copy(savedCamFrames[indexToRead], 0, 0, width, height, 0, 0, width, height);
    }

        indexToWrite++;
    indexToRead++;

    if (indexToRead >= numberFrameDelay) {
        indexToRead = 0;
    }

    if (indexToWrite >= numberFrameDelay) {
        indexToWrite = 0;
    }
    camContainer.blend(camContainerDelay, 0, 0, width, height, 0, 0, width, height, MULTIPLY);
    set(0, 0, camContainer);
    
    //image(camContainer, 0, 0);
    server.sendImage(get());
}