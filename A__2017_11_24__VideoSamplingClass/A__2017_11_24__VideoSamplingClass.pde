import codeanticode.syphon.*;

//import oscP5.*;
//import netP5.*;

import processing.video.*;

//OscP5 oscP5;
//NetAddress oscLocation;

int videoWidth = 1000;
float windowWidth = 1000 / 5;

Capture cam;
PImage camContainer;
SyphonServer server;
Seed snapshotSeed;

void settings() {
    size(videoWidth, 562, P3D);
    PJOGL.profile = 1;
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
    camContainer = createImage(width, height, RGB);
    camContainer.copy(cam, 0, 0, width, height, 0, 0, width, height);
    drawColorMorpher();
    colorMorpher.blend(camContainer, 0, 0, width, height, 0, 0, width, height, EXCLUSION);
    image(colorMorpher, 0, 0);
    drawColorDrip();
    //text(closestPoint, 100, 100);

    server.sendImage(get());
}

void keyPressed() {
    if (key == CODED) {
        if (keyCode == UP) {
        } else if (keyCode == DOWN) {
        }
    }

    if (key == 'c') {
      snapshotSeed.update();
    }
}

//void oscEvent(OscMessage message) {
//  //message.addrPattern();
//}