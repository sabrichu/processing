import processing.video.*;

Movie video;

PImage colorMorpher;
PImage videoContainer;

void setup() {
    size(1000, 560);

    noStroke();
    noiseDetail(1);

    colorMorpher = createImage(width, height, RGB);
    videoContainer = createImage(width, height, RGB);

    video = new Movie(this, "DarkClouds.mp4");
    //video.speed(0.1);
    video.loop();
}

void draw() {
    video.read();
    videoContainer.copy(video, 0, 0, video.width, video.height, 0, 0, width, height);

    colorMorph();
    colorMorpher.blend(videoContainer, 0, 0, width, height, 0, 0, width, height, ADD);
    image(colorMorpher, 0, 0);

    colorDrip();
}

int dripDirection = 0;
float dripXOff = 0;
float dripYOff = 0;
float dripNoiseFactor = 0.009;

void colorDrip() {
    int sourceIndex;

    dripXOff = 0;
    colorMorpher.loadPixels();

    if (dripDirection == 0 | dripDirection == 2) {
        for (int i = 0; i < width; i++) {
            int randomY = floor(noise(dripXOff, dripYOff) * height);
            sourceIndex = width * (randomY - 1) + i;

            if (sourceIndex > 0 & sourceIndex < colorMorpher.pixels.length) {
                fill(colorMorpher.pixels[sourceIndex]);

                if (dripDirection == 0) {
                    rect(i, 0, 1, randomY);
                } else {
                    rect(i, randomY, 1, height - randomY);
                }
            }

            dripXOff += dripNoiseFactor;
        }
    } else {
        for (int i = 0; i < height; i++) {
            int randomX = floor(noise(dripXOff, dripYOff) * width);
            // XXX: WTF is going on here?
            //sourceIndex = height * (randomX - 1) + i;
            sourceIndex = i * width + randomX;

            if (sourceIndex > 0 & sourceIndex < colorMorpher.pixels.length) {
                fill(colorMorpher.pixels[sourceIndex]);

                if (dripDirection == 1) {
                    rect(randomX, i, width - randomX, 1);
                    //Layered effect
                    //rect(randomX, i, width, i + 1);
                } else {
                    rect(0, i, randomX, 1);
                }
            }

            dripXOff += dripNoiseFactor;
        }
    }
    dripYOff += dripNoiseFactor;
}

float colorMorphStart = 0;
float colorMorphRmagnitude = 1;
float colorMorphGmagnitude = 1.2;
float colorMorphBmagnitude = 1.5;
float colorMorphXoff = 0;
float colorMorphYoff = 0;
float colorMorphNoiseFactor = 0.002;
float colorMorphZoff = 0;
float colorMorphTimeFactor = 0.03;

void colorMorph() {
    colorMorphYoff = colorMorphStart;

    colorMorpher.loadPixels();

    for (int x = 0; x < width; x++) {
        colorMorphXoff = colorMorphStart;

        for (int y = 0; y < height; y++) {
            // y * width to move down the rows
            // In p5.js, * 4 cos rgba
            colorMorpher.pixels[(x + y * width)] = color(
                rgbValue(colorMorphRmagnitude, colorMorphXoff, colorMorphYoff, colorMorphZoff),
                rgbValue(colorMorphGmagnitude, colorMorphXoff, colorMorphYoff, colorMorphZoff),
                rgbValue(colorMorphBmagnitude, colorMorphXoff, colorMorphYoff, colorMorphZoff)
            );
            colorMorphXoff += colorMorphNoiseFactor;
        }
        colorMorphYoff += colorMorphNoiseFactor;
    }

    colorMorphZoff += colorMorphTimeFactor;

    // Pans the pixels on a diagonal
    colorMorphStart += colorMorphNoiseFactor;

    colorMorpher.updatePixels();
}

int rgbValue(
    float magnitude,
    float xoff,
    float yoff,
    float zoff
) {
    return floor(noise(xoff * magnitude, yoff * magnitude, zoff * magnitude) * 255);
}

void keyPressed() {
    if (key == 's') {
        saveFrame();
    }
}