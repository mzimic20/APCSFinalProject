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
  float increment(float range) {
    float sum = 0;
    for (int i = 6; i <= 10; i++) {
      sum += range/i;
    }
    sum /= 5;
    return floor(sum*100)/100;
  }
  void draw() {
    //axes
    line(sx(bound[0]),sy(0),sx(bound[1]),sy(0));
    line(sx(0),sy(bound[2]),sx(0),sy(bound[3]));
    //grid
    int l = 10;
    float incx = increment(bound[1]-bound[0]);
    for (int i = 0; i <= l; i++) {
      line(sx(incx*((int)(bound[0]/incx)+i)),sy(bound[2]),sx(incx*((int)(bound[0]/incx)+i)),sy(bound[3]));
      textAlign(CENTER,TOP);
      text(incx*((int)(bound[0]/incx)+i),sx(incx*((int)(bound[0]/incx)+i)),sy(0));
    }
    float incy = increment(bound[3]-bound[2]);
    for (int i = 0; i <= l; i++) {
      line(sx(bound[0]),sy(incy*((int)(bound[2]/incy)+i)),sx(bound[1]),sy(incy*((int)(bound[2]/incy)+i)));
      textAlign(RIGHT,CENTER);
      text(incy*((int)(bound[2]/incy)+i),sx(0),sy(incy*((int)(bound[2]/incy)+i)));
    }
  }
  void zoom(boolean n, int x, int y) {
    if (n) {
    } else {
    }
  }
}
