float colorMorphStart = 0;
float colorMorphRmagnitude = 1;
float colorMorphGmagnitude = 1.2;
float colorMorphBmagnitude = 1.5;
float colorMorphXoff = 0;
float colorMorphYoff = 0;
float colorMorphNoiseFactor = 0.002;
float colorMorphZoff = 0;
float colorMorphTimeFactor = 0.03;

PImage colorMorpher;

void setupColorMorpher() {
    noStroke();
    noiseDetail(1);

    colorMorpher = createImage(width, height, RGB);
}

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