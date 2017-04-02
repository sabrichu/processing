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

String mode = "standby";
// 10 frames per second (if performing well)
int secondsToPlaySnapshot = 30 * 10;
int snapshotCounter = 0;

Seed snapshotSeed;

void settings() {
    size(1200, 800, P3D);
    PJOGL.profile = 1;
}

void setup() {
    setupStandby();
    setupColorMorpher();
    setupSnapshot();
    // setupThankYou();

    snapshotSeed = new Seed();

    // For listening
    oscP5 = new OscP5(this, 12000);
    // For sending
    oscLocation = new NetAddress("localhost", 8000);

    server = new SyphonServer(this, "Processing Syphon");
}

void draw() {
    if (mode == "standby") {
        drawStandby();
    }

    if (mode == "snapshot") {
        if (snapshotCounter < secondsToPlaySnapshot) {
            drawSnapshot();
            snapshotCounter++;
        } else {
            stopSnapshot();
            mode = "thanks";
            snapshotCounter = 0;
        }
    }

    if (mode == "thanks") {
        background(255, 0, 0);
        // drawThankYou();
        // Thank You DRGKLERKJLEK
        // Or however you pronounce that
        // please exit and retrieve your photobooth
        // if thank video has ended, mode = "standby"
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
        mode = "standby";
    }

    if (key == 'p') {
        prepareSnapshot();
        mode = "snapshot";
    }
}

void oscEvent(OscMessage message) {
  //message.addrPattern();
}