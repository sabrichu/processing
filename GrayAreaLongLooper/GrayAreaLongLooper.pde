import codeanticode.syphon.*;

import oscP5.*;
import netP5.*;

import org.openkinect.freenect.*;
import org.openkinect.processing.*;

import processing.video.*;

OscP5 oscP5;
NetAddress oscLocation;

SyphonServer server;

String pathToImagesFolder = "/Users/sabrichu/Projects/Creative Code 2017/The snapshot/dist/images/";
String filenameToSend;

String mode = "snapshot";

void settings() {
    size(1200, 800, P3D);
    PJOGL.profile = 1;
}

void setup() {
    setupColorMorpher();
    setupSnapshot();

    // For listening
    oscP5 = new OscP5(this, 12000);

    // For sending
    oscLocation = new NetAddress("localhost", 8000);

    setupStandby();

    server = new SyphonServer(this, "Processing Syphon");
}

void draw() {
    if (mode == "snapshot") {
        drawSnapshot();
    }

    if (mode == "hallo") {
        drawStandby();
    }

    server.sendImage(get());
}

void keyPressed() {
    if (key == 's') {
        // Should be good for over a week of snapshots, ha
        String paddedFrameCount = String.format("%07d", frameCount);
        filenameToSend = "snapshot-" + paddedFrameCount + ".png";
        saveFrame(pathToImagesFolder + "snapshot-#######.png");

        // XXX: Move this so that we don't show the image right away
        OscMessage message = new OscMessage("/newSnapshot");
        message.add(filenameToSend);
        oscP5.send(message, oscLocation);
    }

    if (key == 'h') {
        mode = "hallo";
    }

    if (key == 'p') {
        mode = "snapshot";
    }
}

void oscEvent(OscMessage message) {
  //message.addrPattern();
}