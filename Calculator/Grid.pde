public class Grid {

  private int[] center;
  private int bound, scale;
  
  public Grid() {
    center = new int[2];
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
    int increment = 900 / (bound * 2);
    for(int i = -1 * bound + 1; i < bound; i++) {
      int x = 750 + increment * i;
      line(x, 0, x, 900);
      if (i != 0) text(scale * i, x - 10, 465);
      else text(i, 735, 465);
    }
    
    //y lines
    for(int i = -1 * bound; i < bound; i++) {
      int y = 450 + increment * i;
      line(300, y, 1200, y);
      if (i != 0) text(scale * i, 735, y);
    }
  }
  
}
