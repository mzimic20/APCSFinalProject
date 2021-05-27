public class Grid {

  private float[] center;
  private float bound, scale;
  
  Grid() {
    center = new float[2];
    center[0] = 0;
    center[1] = 0;
    bound = 10;
    scale = 1;
  }
  
  void draw() {
    //white square background
    fill(255);
    stroke(125);
    square(300, 0, 900);
    
    //x lines and labels
    stroke(191);
    textSize(12);
    fill(31);
    float increment = 900 / (bound * 2);
    for(float i = -1 * bound + 1; i < bound; i++) {
      float x = 750 + increment * i;
      line(x, 0, x, 900);
      if (i != 0) text((int)(scale * i + center[0]), x - 10, 465);
      else text((int)i, 735, 465);
    }
    
    //y lines
    for(float i = -1 * bound + 1; i < bound; i++) {
      float y = 450 + increment * i;
      line(300, y, 1200, y);
      if (i != 0) text((int)(scale * i * -1 + center[1]), 735, y);
    }
  }
  
  void zoom(float i) {
    bound -= i;
  }
  
}
