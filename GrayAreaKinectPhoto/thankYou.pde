Movie thankYouVideo;

void setupThankYou() {
    thankYouVideo = new Movie(this, "ThankYou720.mov");
}

void mountThankYou() {
    thankYouVideo.jump(0);
    mode = "thanks";
}

void drawThankYou() {
    background(0);

    if (thankYouVideo.time() == thankYouVideo.duration()) {
        thankYouVideo.jump(0);
        thankYouVideo.stop();

        mountStandby();
    }

    thankYouVideo.play();
    thankYouVideo.read();

    drawCenteredVideo(thankYouVideo);
}