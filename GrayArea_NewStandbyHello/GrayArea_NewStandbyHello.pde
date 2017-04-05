PFont font;

String mode = "standby";

int helloTimer;
int personEnteredThreshold = 500;
int personLeftThreshold = 870;
int closestPoint = 900;

void setup() {
    size(782, 440, P3D);

    fill(255);
    noStroke();

    font = createFont("Futura-Bold", 72);
    textLeading(1);
    textFont(font);
    textSize(72);
    textAlign(CENTER);
}

void draw() {
    background(0);

    if (mode == "hello") {
        drawHello();
    }

    if (mode == "standby") {
        drawStandBy();
    }

    if (mode == "countdown") {
        //drawCountdown();
    }
}

void drawStandBy() {
    int rectWidth = width / 20;
    float mappedHeight = map(closestPoint, personEnteredThreshold, personLeftThreshold, height * 7 / 8, 0);

    rect(width / 2 - rectWidth / 2, 0, rectWidth, height / 8);
    rect(width / 2 - rectWidth / 2, height - mappedHeight, rectWidth, mappedHeight);

    if (closestPoint < personEnteredThreshold) {
        // mountHello();
        helloTimer = millis();
        mode = "hello";
    }
}

void drawHello() {
    int timeElapsed = millis() - helloTimer;

    if (
        timeElapsed < 500 ||
        timeElapsed > 575 & timeElapsed < 650
    ) {
        rect(width / 2 - width / 40, 0, width / 20, height);
    }

    if (timeElapsed >= 2000 & timeElapsed < 4500) {
        text("HELLO", width / 2, height / 2);
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
        fill(255, 0, 0);
        rect(0, 0, width, height);
    }
}

void keyPressed() {
    if (key == 'h') {
        mode = "hello";
    }
    if (key == 's') {
        mode = "standby";
    }
    if (key == 'c') {
        mode = "countdown";
    }

    if (key == 'j') {
        closestPoint -= 50;
    }

    if (key == 'k') {
        closestPoint += 50;
    }
}