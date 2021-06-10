class Conic {

  private String e;
  private float vaxis, haxis;
  private float[] center;
  
  Conic(String s) {
    e = s;
    vaxis = parseVaxis();
    haxis = parseHaxis();
    center = parseCenter();
  }
  
  float parseVaxis() {
    if (e.contains("y^2")) return Float.parseFloat(e.substring(e.indexOf("=") + 1, e.length()));
    else return Float.parseFloat(e.substring(e.lastIndexOf("^2/"), e.indexOf("=")));
  }
  
  float parseHaxis() {
    if (e.contains("x^2")) return Float.parseFloat(e.substring(e.indexOf("=") + 1, e.length()));
    else return Float.parseFloat(e.substring(e.indexOf("^2/"), e.indexOf("=")));
  }
  
  float[] parseCenter() {
    float[] coords = new float[2];
    int x = e.indexOf("x");
    if (x > 0 && e.charAt(x - 1) == '(' && (e.charAt(x + 1) == '+' || e.charAt(x + 1) == '-')) {
      coords[0] = Float.parseFloat(e.substring(x + 2, e.indexOf(')')));
    }
    else coords[0] = 0;
    int y = e.indexOf("y");
    if (y > 0 && e.charAt(y - 1) == '(' && (e.charAt(y + 1) == '+' || e.charAt(y + 1) == '-')) {
      coords[1] = Float.parseFloat(e.substring(y + 2, e.lastIndexOf(')')));
    }
    else coords[1] = 0;
    return coords;
  }
  
  void draw(Grid n) {
    stroke(0);
    ellipse(n.sx(center[0]), n.sy(center[1]), n.sy(haxis), n.sy(vaxis));
  }
  
}
