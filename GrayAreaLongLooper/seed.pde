class Seed {
    int biosZoeBlendMode = SUBTRACT;
    int colorMorpherBlendMode = ADD;
    int dripDirection = 0;
    float dripIntensity = 0.005;
    float colorIntensity = 0.02;
    float colorPanIntensity = 0.03;
    //float colorize =

    //int[] possibleBZBlendModes = {
    //    DIFFERENCE
    //}

    //int[] possibleCMBlendModes = {
    //    DIFFERENCE
    //}

    void update(
        // int updatedDripDirection,
        // float updatedDripIntensity,
        // float updatedColorIntensity,
        // float updatedColorPanIntensity
    ) {
        // dripDirection = updatedDripDirection;
        // dripIntensity = updatedDripIntensity;
        // colorIntensity = updatedColorIntensity;
        // colorPanIntensity = updatedColorPanIntensity;
        dripDirection = floor(random(0, 4)); // 4 different directions
        dripIntensity = random(0.001, 0.01);
        colorIntensity = random(0.001, 0.04);
        // colorPanIntensity = updatedColorPanIntensity;
    }
}