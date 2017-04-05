float videoWidthPercentage = 0.4;
float videoHeightPercentage = 0.5;

float getRelativeVideoHeight(Movie video) {
    return map(video.height, 0, video.height, 0, height * videoHeightPercentage);
}

void drawCenteredVideo(Movie video) {
    float relativeVideoWidth = map(video.width, 0, video.width, 0, width * videoWidthPercentage);
    float relativeVideoHeight = getRelativeVideoHeight(video);

    image(video, (width - relativeVideoWidth) / 2, (height - relativeVideoHeight) / 2, width * videoWidthPercentage, height * videoHeightPercentage);
}