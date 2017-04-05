
class Seed {
    int biosZoeBlendMode = SUBTRACT;
    int colorMorpherBlendMode = ADD;
    int dripDirection = 0;
    float dripXOff = 0;
    float dripIntensity = 0.005;
    float colorIntensity = 0.02;
    float colorPanIntensity = 0.03;

    int frameToTakeSnapshot = 0;

    int[] possibleBlendModes = {
        DIFFERENCE,
        SUBTRACT,
        EXCLUSION,
        ADD,
        LIGHTEST,
        SCREEN
    };

    void update() {
        frameToTakeSnapshot = floor(random(0, framesToPlaySnapshot));

        dripXOff = random(0, 10);
        dripDirection = floor(random(0, 4)); // 4 different directions
        dripIntensity = random(0.005, 0.02);
        colorIntensity = random(0.005, 0.01);
        biosZoeBlendMode = possibleBlendModes[floor(random(0, possibleBlendModes.length))];
        colorMorpherBlendMode = possibleBlendModes[floor(random(0, possibleBlendModes.length))];
    }
}