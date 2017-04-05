int thankYouTimer;

void setupThankYou() {
    font = createFont("Futura-Bold", 72);
    textLeading(1);
    textFont(font);
    textSize(72);
    textAlign(CENTER);
}

void mountThankYou() {
    fill(255);
    noStroke();

    thankYouTimer = millis();
    mode = "thanks";
}

void drawThankYou() {
    background(0);

    int timeElapsed = millis() - thankYouTimer;

    if (timeElapsed >= 2000 & timeElapsed < 4500) {
        text("THANK YOU", width / 2, height / 2.2);
        text(randomName, width / 2, height / 2.2 + 90);
    }

    if (timeElapsed >= 6500 & timeElapsed < 9000) {
        text("PLEASE EXIT", width / 2, height / 2.2);
        text("FOR YOUR PHOTO", width / 2, height / 2.2 + 90);
    }

    if (timeElapsed > 11000 && isPersonOutOfRange()) {
        mountStandby();
    }
}