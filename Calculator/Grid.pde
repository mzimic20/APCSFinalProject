public class Grid {

  float[] bound = new float[4];
  
  Grid() {
    bound[0] = -10; //xmin
    bound[1] = 10; //xmax
    bound[2] = -10; //ymin
    bound[3] = 10; //ymax
  }
  //converts coordinates to pixels
  float sx(float x) {
    return 300 + 900 * (x - bound[0]) / (bound[1] - bound[0]);
  }
  float sy(float y) {
    return 900 - 900 * (y - bound[2]) / (bound[3] - bound[2]);
  }
  //converts pixels to coordinates
  float rx(int x) {
    return (x - 300) * (bound[1]-bound[0]) / 900 + bound[0];
  }
  float ry(int y) {
    return (y - 900) * (bound[3]-bound[2]) / -900 + bound[2];
  }
  //determines spacing of grid lines
  float increment(float range) {
    return pow(4,(int)(log(range)/log(4))-1);
  }
  //makes sure numbers on axes are on screen
  float tx(float x, String y) {
    if (x < 300 + 10 * y.length()) {
      return 300 + 10 * y.length();
    }
    if (x > 1200) {
      return 1200;
    }
    return x;
  }
  float ty(float y) {
    if (y < 0) {
      return 0;
    }
    if (y > 875) {
      return 875;
    }
    return y;
  }
  void draw() {
    //axes
    line(sx(bound[0]),sy(0),sx(bound[1]),sy(0));
    if (sx(0) > 300) {
      line(sx(0),sy(bound[2]),sx(0),sy(bound[3]));
    }
    //grid
    float incx = increment(bound[1]-bound[0]);
    for (int i = 0; i <= (bound[1]-bound[0])/incx+1; i++) {
      float x = incx*((int)(bound[0]/incx)+i);
      if (sx(x) > 300) {
        line(sx(x),sy(bound[2]),sx(x),sy(bound[3]));
        textAlign(CENTER,TOP);
        if ((int) x != x) {
          text(x, sx(x), ty(sy(0)));
        } else {
          text((int) x, sx(x), ty(sy(0)));
        }
      }
    }
    float incy = increment(bound[3]-bound[2]);
    for (int i = 0; i <= (bound[3]-bound[2])/incy+1; i++) {
      float y = incy*((int)(bound[2]/incy)+i);
      line(sx(bound[0]),sy(y),sx(bound[1]),sy(y));
      textAlign(RIGHT,CENTER);
      if (sx(0) != 0) {
        if ((int) y != y) {
          text(y, tx(sx(0), ""+floor(1000*y)/1000.0), sy(y));
        } else {
          text ((int)y, tx(sx(0), ""+(int)y), sy(y));
        }
      }
    }
  }
  void zoom(boolean n, int x, int y) {
    float scale = 1 + (0.5/abs(log(bound[3]-bound[2] + bound[1]-bound[0])));
    if (n) {
      scale = 1 / scale;
    }
    float rx = rx(x);
    float ry = ry(y);
    if (rx > bound[0] && rx < bound[1] && ry > bound[2] && ry < bound[3]) {
      bound[0] = rx - (rx - bound[0]) * scale;
      bound[1] = rx + (bound[1] - rx) * scale;
      bound[2] = ry - (ry - bound[2]) * scale;
      bound[3] = ry + (bound[3] - ry) * scale;
    }
  }
  void move(float x, float y, int mx, int my) {
    float nmx = rx(mx);
    float nmy = ry(my);
    bound[0] -= (nmx-x);
    bound[1] -= (nmx-x);
    bound[2] -= (nmy-y);
    bound[3] -= (nmy-y);
  }
  void connect(float x1, float y1, float x2, float y2) {
    line(sx(x1),sy(y1),sx(x2),sy(y2));
  }
}
