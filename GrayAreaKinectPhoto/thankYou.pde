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
        if (isPersonOutOfRange()) {
            // Wait until person has left before
            thankYouVideo.jump(0);
            thankYouVideo.stop();

            mountStandby();
        }
    }

    thankYouVideo.play();
    thankYouVideo.read();

    drawCenteredVideo(thankYouVideo);
}