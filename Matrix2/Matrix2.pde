//https://stackoverflow.com/a/30200250/8645145
//https://www.fontspace.com/daredemotypo/nikkyou-sans
float STEP = 60;
char BEGIN_KANJI = '\u3041';
char END_KANJI = '\u3096';
int RANGE_KANJI = END_KANJI - BEGIN_KANJI;
color LIGHT_COLOR = #00ffff;
color DARK_COLOR = #003333;

int w, h;
char[] charset;
char[][] chars;
color[][] colors;

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
      chars[y][x] = randomKanji();
      colors[y][x] = LIGHT_COLOR;
    }
  }
}

void setup() {
  size(420,620);
  frameRate(60);
  smooth();
  
  w = int(width / STEP);
  h = int(height / STEP);
  charset = buildCharset();
  chars = new char[h][w];
  colors = new color[h][w];
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
        chars[y][x] = randomKanji();
        colors[y][x] = LIGHT_COLOR;
      } else {
        colors[y][x] = lerpColor(colors[y][x], DARK_COLOR, 0.1);
      }
      float xp = (x + 0.5) * STEP + exp(noise(x + time, y) * 3);
      float yp = (y + 0.5) * STEP + exp(noise(x + time, y) * 3);
      fill(colors[y][x]);
      text(chars[y][x], xp, yp);
    }
  }
}

void mousePressed() {
  randomize();
}
