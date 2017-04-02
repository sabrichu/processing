float dripXOff = 0;
float dripYOff = 0;

void colorDrip() {
    int dripDirection = snapshotSeed.dripDirection;
    float dripIntensity = snapshotSeed.dripIntensity;

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

            dripXOff += dripIntensity;
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

            dripXOff += dripIntensity;
        }
    }
    dripYOff += dripIntensity;
}