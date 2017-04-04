Movie thankYouVideo;

void setupThankYou() {
    thankYouVideo = new Movie(this, "ThankYou720.mov");
}

void prepareThankYou() {
    // XXX: Kind of weird that I don't have to do this for helloVideo...
    thankYouVideo.jump(0);
}

void drawThankYou() {
    background(0);

    if (thankYouVideo.time() == thankYouVideo.duration()) {
        thankYouVideo.jump(0);
        thankYouVideo.stop();

        mode = "standby";
    }

    thankYouVideo.play();
    thankYouVideo.read();

    drawCenteredVideo(thankYouVideo);
}