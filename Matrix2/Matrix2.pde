//https://stackoverflow.com/a/30200250/8645145
//https://www.fontspace.com/daredemotypo/nikkyou-sans
float STEP = 30;
char BEGIN_KANJI = '\u3041';
char END_KANJI = '\u3096';
int RANGE_KANJI = END_KANJI - BEGIN_KANJI;

int w, h;
char[][] buffer;
char[] charset;

char[] buildCharset() {
  char[] charset = new char[RANGE_KANJI+1];
  int i = 0;
  for (char c = BEGIN_KANJI; c <= END_KANJI; ++c, ++i) {
    charset[i] = c;
  }
  return charset;
}

char randomKanji() {
  //return char(int(random(BEGIN_KANJI, END_KANJI)));
  return charset[int(random(0, charset.length-1))];
}

void randomize() {
  for (int y = 0; y < h; ++y) {
    for (int x = 0; x < w; ++x) {
      buffer[y][x] = randomKanji();
    }
  }
}

void setup() {
  size(400,400);
  frameRate(60);
  smooth();
  
  w = int(width / STEP);
  h = int(height / STEP);
  buffer = new char[h][w];
  charset = buildCharset();
  randomize();
  
  PFont font = createFont("NikkyouSans-B6aV.ttf", 16, true, charset);
  textFont(font);
  textSize(STEP * 0.75);
  textAlign(CENTER, CENTER);
}

void draw() {
  background(0);
  
  if (frameCount % 60 == 0) {
    randomize();
  }
  
  float time = frameCount / 20.0;
  for (int y = 0; y < h; ++y) {
    for (int x = 0; x < w; ++x) {
      if (random(1) <= 0.1) {
        buffer[y][x] = randomKanji();
      }
      float xp = (x + 0.5) * STEP + noise(x + time, y);
      float yp = (y + 0.5) * STEP + noise(x + time, y);
      fill(#003333);
      text(buffer[y][x], xp-3, yp-3);
      fill(#00ffff);
      text(buffer[y][x], xp, yp);
    }
  }
}

void mousePressed() {
  randomize();
}
