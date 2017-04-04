float dripYOff = 0;

void drawColorDrip() {
    int dripDirection = snapshotSeed.dripDirection;
    float dripIntensity = snapshotSeed.dripIntensity;
    float dripXOff = snapshotSeed.dripXOff;

    int sourceIndex;

    colorMorpher.loadPixels();

    if (dripDirection == 0 | dripDirection == 2) {
        for (int i = 0; i < width; i++) {
            int randomY = floor(map(noise(dripXOff, dripYOff), 0, 1, height / 2, height));
            if (dripDirection == 0) {
                randomY = floor(map(noise(dripXOff, dripYOff), 0, 1, 0, height / 2));
            }

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
            int randomX = max(floor(noise(dripXOff, dripYOff) * width), width / 2);
            if (dripDirection == 1) {
                randomX = min(floor(noise(dripXOff, dripYOff) * width), width / 2);
            }

            // XXX: WTF is going on here?
            sourceIndex = height * (randomX - 1) + i;
            //sourceIndex = i * width + randomX;

            if (sourceIndex > 0 & sourceIndex < colorMorpher.pixels.length) {
                fill(colorMorpher.pixels[sourceIndex]);

                if (dripDirection == 1) {
                    //rect(randomX, i, width - randomX, 1);
                    //Layered effect
                    rect(randomX, i, width, i + 1);
                } else {
                    rect(0, i, randomX, 1);
                }
            }

            dripXOff += dripIntensity;
        }
    }
    dripYOff += dripIntensity;
}