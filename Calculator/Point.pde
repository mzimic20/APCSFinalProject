class Point {

  private float x, y;
  
  Point(String e) {
    try {
      x = Float.parseFloat(e.substring(1, e.indexOf(",")));
      y = Float.parseFloat(e.substring(e.indexOf(",") + 1, e.length() - 1));
    } catch (Exception n) {
    }
  }
  
  void draw(Grid n) {
    circle(n.sx(x), n.sy(y), 5);
  }
  
}
