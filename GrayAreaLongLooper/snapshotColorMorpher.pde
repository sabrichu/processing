float colorMorphStart = 0;
float colorMorphXoff = 0;
float colorMorphYoff = 0;
float colorMorphZoff = 0;

PGraphics colorMorpher;

void setupColorMorpher() {
    noStroke();
    noiseDetail(1);

    colorMorpher = createGraphics(width, height);
}

void drawColorMorpher() {
    float colorMorphNoiseFactor = snapshotSeed.colorIntensity;
    float colorMorphTimeFactor = snapshotSeed.colorPanIntensity;
    int colorMorphPixelSize = 10;

    colorMorphYoff = colorMorphStart;

    colorMorpher.beginDraw();

    for (int x = 0; x < width; x += colorMorphPixelSize) {
        colorMorphXoff = colorMorphStart;

        for (int y = 0; y < height; y += colorMorphPixelSize) {
            colorMorpher.noStroke();
            colorMorpher.fill(color(
                rgbValue(1, colorMorphXoff, colorMorphYoff, colorMorphZoff),
                rgbValue(1.2, colorMorphXoff, colorMorphYoff, colorMorphZoff),
                rgbValue(1.5, colorMorphXoff, colorMorphYoff, colorMorphZoff)
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
    // Different magnitudes to make sure we get different rgb values
    return floor(noise(xoff * magnitude, yoff * magnitude, zoff * magnitude) * 255);
}