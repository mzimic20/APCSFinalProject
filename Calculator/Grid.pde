public class Grid {

  float[] bound = new float[4];
  
  Grid() {
    bound[0] = -10; //xmin
    bound[1] = 10; //xmax
    bound[2] = -10; //ymin
    bound[3] = 10; //ymax
  }
  
  float sx(float x) {
    return 300 + 900 * (x - bound[0]) / (bound[1] - bound[0]);
  }
  float sy(float y) {
    return 900 - 900 * (y - bound[2]) / (bound[3] - bound[2]);
  }
  float rx(int x) {
    return (x - 300) * (bound[1]-bound[0]) / 900 + bound[0];
  }
  float ry(int y) {
    return (y - 900) * (bound[3]-bound[2]) / -900 + bound[2];
  }
  float increment(float range) {
    return pow(4,(int)(log(range)/log(4))-1);
  }
  void draw() {
    //axes
    line(sx(bound[0]),sy(0),sx(bound[1]),sy(0));
    line(sx(0),sy(bound[2]),sx(0),sy(bound[3]));
    //grid
    float incx = increment(bound[1]-bound[0]);
    for (int i = 0; i <= (bound[1]-bound[0])/incx; i++) {
      float x = incx*((int)(bound[0]/incx)+i);
      line(sx(x),sy(bound[2]),sx(x),sy(bound[3]));
      textAlign(CENTER,TOP);
      if ((int) x != x) {
        text(x, sx(x), sy(0));
      } else {
        text((int) x, sx(x), sy(0));
      }
    }
    float incy = increment(bound[3]-bound[2]);
    for (int i = 0; i <= (bound[3]-bound[2])/incy; i++) {
      float y = incy*((int)(bound[2]/incy)+i);
      line(sx(bound[0]),sy(y),sx(bound[1]),sy(y));
      textAlign(RIGHT,CENTER);
      if ((int) y != y) {
        text(y, sx(0), sy(y));
      } else {
        text ((int) y, sx(0), sy(y));
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
}
