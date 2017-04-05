PFont font;

int helloTimer;

void setupStandby() {
    font = createFont("Futura-Bold", 72);
    textLeading(1);
    textFont(font);
    textSize(72);
    textAlign(CENTER);
}

void mountStandby() {
    fill(255);
    noStroke();

    mode = "standby";
}

void mountHello() {
    helloTimer = millis();
    mode = "hello";
}

void drawStandby() {
    background(0);

    int rectWidth = width / 20;
    int closestPoint = getKinectClosestPoint();
    float mappedHeight = map(closestPoint, personEnteredThreshold, personLeftThreshold, height * 7 / 8, 0);

    rect(width / 2 - rectWidth / 2, 0, rectWidth, height / 8);
    rect(width / 2 - rectWidth / 2, height - mappedHeight, rectWidth, mappedHeight);

    if (isPersonInRange()) {
        mountHello();
    }
}

void drawHello() {
    background(0);

    int timeElapsed = millis() - helloTimer;

    if (
        timeElapsed < 500 ||
        timeElapsed > 575 & timeElapsed < 650
    ) {
        rect(width / 2 - width / 40, 0, width / 20, height);
    }

    if (timeElapsed >= 2000 & timeElapsed < 4500) {
        text("HELLO", width / 2, height / 2 + 30);
    }

    if (timeElapsed >= 6500 & timeElapsed < 9000) {
        text("I'VE NEVER SEEN", width / 2, height / 3);
        text("ANYTHING", width / 2, height / 3 + 90);
        text("LIKE YOU", width / 2, height / 3 + 180);
    }

    if (timeElapsed >= 11000 & timeElapsed < 13500) {
        text("CAN I TAKE", width / 2, height / 2.2);
        text("YOUR PICTURE?", width / 2, height / 2.2 + 90);
    }

    if (timeElapsed >= 15500 & timeElapsed < 21500) {
        float countdownSeconds = map(timeElapsed, 15500, 21000, 6000, 0);
        float nearestThousandth = countdownSeconds - countdownSeconds % 1000;

        rect(0, 0, width * nearestThousandth / 5000, height);
    }

    if (timeElapsed > 22000) {
        mountSnapshot();
    }
}