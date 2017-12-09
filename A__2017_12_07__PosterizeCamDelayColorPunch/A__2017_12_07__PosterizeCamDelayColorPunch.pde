import codeanticode.syphon.*;

//import oscP5.*;
//import netP5.*;

import processing.video.*;

//OscP5 oscP5;
//NetAddress oscLocation;

Capture cam;
PImage colorContainer;
PImage camContainer;
PImage camContainerDelay;

int numberFrameDelay = 2;

int indexToWrite = 0;
int indexToRead = 1;

Boolean drawDrip = true;

PImage[] savedCamFrames = new PImage[numberFrameDelay];

SyphonServer server;
Seed snapshotSeed;

void settings() {
    size(1500, 500, P3D);
    PJOGL.profile = 1;
    //frameRate(1);
}

void setup() {
    setupColorMorpher();

    // For listening
    //oscP5 = new OscP5(this, 12000);
    // For sending
    //oscLocation = new NetAddress("localhost", 8000);
    cam = new Capture(this, Capture.list()[0]);
    cam.start();

    snapshotSeed = new Seed();

    server = new SyphonServer(this, "Processing Syphon");
}

void draw() {
    cam.read();

    savedCamFrames[indexToWrite] = cam.get();

    camContainer = createImage(width, height, RGB);
    // camContainerDelay = createImage(width / 2, height, RGB);
    camContainer.copy(cam, int(width * 0.25), 0, width / 2, height, 0, 0, width / 3, height);

    if (savedCamFrames[indexToRead] != null) {
        // camContainer.copy(savedCamFrames[indexToRead], int(width * 0.25), 0, width / 2, height, width / 2, 0, width / 2, height);
    }

    indexToWrite++;
    indexToRead++;

    if (indexToRead >= numberFrameDelay) {
        indexToRead = 0;
    }

    if (indexToWrite >= numberFrameDelay) {
        indexToWrite = 0;
    }

    drawColorMorpher();

    colorContainer = createImage(width, height, RGB);
    colorContainer.copy(colorMorpher, 0, 0, width, height, 0, 0, width / 3, height);
    colorContainer.copy(colorMorpher, 0, 0, width, height, width / 3, 0, width / 3, height);
    colorContainer.copy(colorMorpher, 0, 0, width, height, width * 2 / 3, 0, width / 3, height);
    camContainer.filter(POSTERIZE, 4);
    camContainer.blend(colorContainer, 0, 0, width, height, 0, 0, width, height, ADD);
    //camContainer.blend(colorContainer, 0, 0, width, height, 0, 0, width, height, EXCLUSION);
      // colorMorpher.blend(camContainer, 0, 0, width, height, width / 2, 0, width / 2, height, ADD);

    image(camContainer, 0, 0);
    // image(camContainerDelay, width / 2, 0);
     // image(colorMorpher, 0, 0);

// Remember to change the loadPixels source depending on what you call image() in
      if (drawDrip) {
      drawColorDrip();
      }

    server.sendImage(get());
}

void keyPressed() {
    if (key == CODED) {
        if (keyCode == UP) {
        } else if (keyCode == DOWN) {
        }
    }

    if (key == 'q') {
      drawDrip = false;
    }
    
    if (key == 'w') {
      drawDrip = true;
    }

    if (key == 'a') {
        snapshotSeed.slowChange();
    }

    if (key == 's') {
        snapshotSeed.normalChange();
    }

    if (key == 'c') {
        snapshotSeed.update();
   }
}

//void oscEvent(OscMessage message) {
//  //message.addrPattern();
//}