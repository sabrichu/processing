
class Seed {
    int dripDirection = 0;
    float dripXOff = 0;
    float dripIntensity = 0.01;
    float colorIntensity = 0.0075;
    float colorPanIntensity = 0.00003;

    int[] possibleBlendModes = {
        DIFFERENCE,
        SUBTRACT,
        EXCLUSION,
        ADD,
        LIGHTEST,
        SCREEN
    };
    void slowChange() {
      //colorIntensity = 0.007;
      colorPanIntensity = 0.00003;
    }

    void normalChange() {
      //colorIntensity = 0.01;
      colorPanIntensity = 0.03;
    }

    void update() {
        dripXOff = random(0, 10);
        dripDirection = floor(random(0, 4)); // 4 different directions
        dripIntensity = random(0.005, 0.02);
        colorIntensity = random(0.005, 0.01);
    }
}