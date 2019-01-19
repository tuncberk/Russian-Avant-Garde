PGraphics maskImage;
PGraphics sourceImage;
//refer to https://forum.processing.org/two/discussion/23886/masking-a-shape-with-another-shape
//https://processing.org/reference/PGraphics.html

int radius;
int rectHeight;
int rectWidth;

//color[][] colorScheme = {
//  { #152A3B, #158ca7, #F5C03E, #D63826, #F5F5EB }, 
//  { #0F4155, #288791, #7ec873, #F04132, #fcf068 }, 
//  { #E8614F, #F3F2DB, #79C3A7, #668065, #4B3331 }
//};
color[][] colorScheme = {
  { #972e2a, #437da8, #f1e8c1,#654a2c}, 
  { #112F41, #4FB99F, #f1e8c1,#F2B134},
  { #A30212, #588C8C, #f1e8c1,#011C26},
  { #F67280, #6C5B7B, #f1e8c1,#355C7D},
  { #233D4D, #FE7F2D, #f1e8c1,#579C87},
  { #004E5A, #F06F3E, #f1e8c1,#BE9D7A},
  { #3E4E59, #F25652, #f1e8c1,#D9BB93},
  { #03A1DA, #F12522, #f1e8c1,#CEDA07},
};
int colorSchemeLenth = colorScheme[0].length;

void setup() {
  loadPixels();
  size(1000, 1000);
  radius = height;
  rectWidth = 10;
  rectHeight = 10;
  background(#F2EAE7);
  fill(0, 0, 0, 255);
  noStroke();
  //ellipse(height/2, height/2, radius, radius);
  sourceImage = createGraphics(width, height);
}

void draw() {
  noLoop();
  sourceImage.beginDraw();
  color[] ca = colorScheme[int(random(colorScheme.length))];
  //color[] ca = colorScheme[7];
  for (int i = 0; i < width; i+=rectWidth) {
    //int j = 0;
    int j = int(random(height/2));
    while (j < height) {
      int randCommLength = int(random(4, 20));
      SquareCommune sc = new SquareCommune(randCommLength);
      sc.populate(i, j, ca);
      j += randCommLength*rectHeight;
      j += rectHeight*int(random(20, 60));
    }
  }

  sourceImage.endDraw();
  maskImage = createGraphics(width, height);
  maskImage.beginDraw();
  maskImage.ellipse(height/2, height/2, radius, radius);
  maskImage.endDraw();

  // apply mask
  sourceImage.mask(maskImage);
  image(sourceImage, 0, 0);
}

class SquareCommune {
  int commLength;
  SquareCommune(int lngth) {
    commLength = lngth;
  }
  void populate(int posX, int posY, color[]ca) {
    boolean checkerWhite = false;
    boolean checkerColor = false;
    if (int(random(2))<1)
      checkerColor = true; 
    int colorRange = int(random(2, commLength-1));
    int counterColor = 0;
    
    //color[] ca = colorScheme[int(random(colorScheme.length))];
    int colorSelector = int(random(colorSchemeLenth));
    color c = ca[colorSelector];
    color randomC = ca[int(random(colorSchemeLenth))];
    for (int i = 0; i<commLength; i++) {
      sourceImage.stroke(0);
      sourceImage.strokeWeight(2);
      if (!checkerWhite && int(random(100))<5) {
        sourceImage.fill(#f1e8c1);
        checkerWhite = true;
      } else if(!checkerColor && counterColor < colorRange) {
        sourceImage.fill(randomC);
        counterColor++;
      }
      else{
        sourceImage.fill(c);
      }
      sourceImage.rect(posX, posY, rectWidth, rectHeight);
      posY += rectHeight;
    }
  }
}

void keyPressed() {
  if (key == 's' || key == 'S') {
    saveFrame("art-##.png");
  }
}
