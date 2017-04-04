import codeanticode.syphon.*;

//import oscP5.*;
//import netP5.*;

import org.openkinect.freenect.*;
import org.openkinect.processing.*;

import processing.video.*;

//OscP5 oscP5;
//NetAddress oscLocation;

SyphonServer server;

String pathToImagesFolder = "/Users/sabrichu/Projects/Creative Code 2017/The Photobooth/dist/images/";
String filenameToSend;

String mode = "standby";

int secondsToPlaySnapshot = 30;
int framesToPlaySnapshot;
int snapshotFrameCounter = 0;

Seed snapshotSeed;

void settings() {
    size(782, 440, P3D);
    PJOGL.profile = 1;
}

void setup() {
    setupKinect();
    setupStandby();
    setupColorMorpher();
    setupSnapshot();
    setupThankYou();

    hint(ENABLE_ASYNC_SAVEFRAME);

    snapshotSeed = new Seed();
    framesToPlaySnapshot = int(secondsToPlaySnapshot * frameRate);

    // For listening
    //oscP5 = new OscP5(this, 12000);
    // For sending
    //oscLocation = new NetAddress("localhost", 8000);

    server = new SyphonServer(this, "Processing Syphon");
}

void draw() {
    if (mode == "standby") {
        drawStandby();
    }

    if (mode == "thanks") {
        drawThankYou();
    }

    if (mode == "snapshot") {
        if (snapshotFrameCounter < framesToPlaySnapshot) {
            drawSnapshot();

            if (snapshotFrameCounter == snapshotSeed.frameToTakeSnapshot) {
                takeSnapshot();
            }

            snapshotFrameCounter++;
        } else {
            stopSnapshot();
            snapshotFrameCounter = 0;

            prepareThankYou();
            mode = "thanks";
        }
    }

    server.sendImage(get());
}

void keyPressed() {
    if (key == 's') {
        takeSnapshot();
    }

    if (key == 'h') {
        mode = "standby";
    }

    if (key == 'p') {
        prepareSnapshot();
        mode = "snapshot";
    }
}

//void oscEvent(OscMessage message) {
//  //message.addrPattern();
//}