float colorMorphStart = 0;
float colorMorphRmagnitude = 1;
float colorMorphGmagnitude = 1.2;
float colorMorphBmagnitude = 1.5;
float colorMorphXoff = 0;
float colorMorphYoff = 0;
float colorMorphZoff = 0;

PGraphics colorMorpher;

int colorMorphPixelSize = 10;

void setupColorMorpher() {
    noStroke();
    noiseDetail(1);

    colorMorpher = createGraphics(width, height);
}

void colorMorph() {
    float colorMorphNoiseFactor = snapshotSeed.colorIntensity;
    float colorMorphTimeFactor = snapshotSeed.colorPanIntensity;

    colorMorphYoff = colorMorphStart;

    colorMorpher.beginDraw();

    for (int x = 0; x < width; x += colorMorphPixelSize) {
        colorMorphXoff = colorMorphStart;

        for (int y = 0; y < height; y += colorMorphPixelSize) {
             colorMorpher.noStroke();
            colorMorpher.fill(color(
                rgbValue(colorMorphRmagnitude, colorMorphXoff, colorMorphYoff, colorMorphZoff),
                rgbValue(colorMorphGmagnitude, colorMorphXoff, colorMorphYoff, colorMorphZoff),
                rgbValue(colorMorphBmagnitude, colorMorphXoff, colorMorphYoff, colorMorphZoff)
            ));
            colorMorpher.rect(x, y, colorMorphPixelSize, colorMorphPixelSize);

            colorMorphXoff += colorMorphNoiseFactor;
        }
        colorMorphYoff += colorMorphNoiseFactor;
    }

    colorMorphZoff += colorMorphTimeFactor;

    // Pans the pixels on a diagonal
    colorMorphStart += colorMorphNoiseFactor;

    colorMorpher.endDraw();
}

int rgbValue(
    float magnitude,
    float xoff,
    float yoff,
    float zoff
) {
    return floor(noise(xoff * magnitude, yoff * magnitude, zoff * magnitude) * 255);
}