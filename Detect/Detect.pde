
int DOT_RESOLUTION = 20;
String PICFILE = "us-temps.png";

PImage art;
boolean showDots;
int resolution;

/*================================
  You should leave setup alone, with the exception
  of changing the size if not using the provided boats.jpg
  imgage.
================================*/
void setup() {
  size(770, 550);
  showDots = false;
  resolution = DOT_RESOLUTION;
  art = loadImage(PICFILE);
  art.loadPixels();
  noStroke();
}//setup

/*================================
  You should leave draw alone.
================================*/
void draw() {
  background(255);
  image(art, 0, 0);
  if (showDots) {
    dots(art, resolution);
  }
}//draw


/*================================
  keyPressed
  `r`: reset back to the original image.
  `g`: grayScale the image
  `e`: perform edge detection on the image (this will be added tomorrow)
================================*/
void keyPressed() {
  if (key == 'h') {
    art = highlightRed(art);
  }
  else if (key == 'd') {
    showDots = !showDots;
  }//edge detect
  else if (key == 'r') {
    art = loadImage(PICFILE);
    art.loadPixels();
  }//reset image
}//keyPressed


/*================================
  Returns the grayScale value of a color
================================*/
int calculateGray(color c) {
  int g = int((red(c) + green(c) + blue(c)))/3;
  return g;
}//calculateGray
/*================================
  Returns the correct pixel index for img based on the provided x and y values.
================================*/
int getIndexFromXY(int x, int y, PImage img) {
  return y * img.width + x;
}//getIndexFromXY


PImage highlightRed(PImage img) {
  PImage newImg = new PImage(img.width, img.height);
  for (int p=0; p < img.width * img.height; p++) {
    if (red(img.pixels[p]) > calculateGray(img.pixels[p])) {
      newImg.pixels[p] = img.pixels[p];
    }//if red stay red
    else {
      newImg.pixels[p] = color(calculateGray(img.pixels[p]));
    }//else become gray
  }//for
  return newImg;
}//higlightRed



void dots(PImage img, int resolution) {
  for (int x=0; x < img.width; x += resolution) {
    for (int y=0; y < img.height; y += resolution) {
      if (red(img.pixels[getIndexFromXY(x, y, img)]) > calculateGray(img.pixels[getIndexFromXY(x, y, img)])) {
        fill(255, 0, 0);
      } else {
        fill(0, 0, 255);
      }
      circle(x, y, resolution/2);
    }
  }
}//dots
