float dripYOff = 0;
float rectWidth = 1;

void drawColorDrip() {
    float dripIntensity = snapshotSeed.dripIntensity;
    float dripXOff = snapshotSeed.dripXOff;

    int sourceIndex;

    colorMorpher.loadPixels();

    for (int i = 0; i < width; i += rectWidth) {
        int randomY = floor(map(noise(dripXOff, dripYOff), 0, 1, 0, height * 0.75));
        sourceIndex = width * (randomY) + i;

        if (sourceIndex > 0 & sourceIndex < colorMorpher.pixels.length) {
            fill(colorMorpher.pixels[sourceIndex]);
            rect(i, 0, rectWidth, height);
        }

        dripXOff += dripIntensity;
    }
    dripYOff += dripIntensity;
}