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
    if (!e.contains("^2/")) return (float)Math.sqrt(Double.parseDouble(e.substring(e.indexOf("=") + 1, e.length())));
    else return (float)Math.sqrt(Double.parseDouble(e.substring(e.lastIndexOf("^2/") + 3, e.indexOf("="))));
  }
  
  float parseHaxis() {
    if (!e.contains("^2/")) return (float)Math.sqrt(Double.parseDouble(e.substring(e.indexOf("=") + 1, e.length())));
    else {
      if (e.contains("(y")) return (float)Math.sqrt(Double.parseDouble(e.substring(e.indexOf("^2/") + 3, e.indexOf("(y") - 1)));
      else return (float)Math.sqrt(Double.parseDouble(e.substring(e.indexOf("^2/") + 3, e.indexOf("y") - 1)));
    }
  }
  
  float[] parseCenter() {
    float[] coords = new float[2];
    int x = e.indexOf("x");
    if (x > 0 && e.charAt(x - 1) == '(' && (e.charAt(x + 1) == '+' || e.charAt(x + 1) == '-')) {
      coords[0] = Float.parseFloat(e.substring(x + 2, e.indexOf(')')));
      if (e.charAt(e.indexOf("x") + 1) == '+') coords[0] *= -1;
    }
    else coords[0] = 0;
    int y = e.indexOf("y");
    if (y > 0 && e.charAt(y - 1) == '(' && (e.charAt(y + 1) == '+' || e.charAt(y + 1) == '-')) {
      coords[1] = Float.parseFloat(e.substring(y + 2, e.lastIndexOf(')')));
      if (e.charAt(e.indexOf("y") + 1) == '+') coords[0] *= -1;
    }
    else coords[1] = 0;
    return coords;
  }
  
  void draw(Grid n) {
    stroke(0);
    noFill();
    float vt = center[1] + vaxis;
    float vb = center[1] - vaxis;
    float vl = center[0] - haxis;
    float vr = center[0] + haxis;
    ellipse(n.sx(center[0]), n.sy(center[1]), n.sx(vr) - n.sx(vl), n.sy(vb) - n.sy(vt));
  }
  
  String getConic() {
    return e;
  }
  
  void getInfo() {
    print("" + haxis + " " + vaxis + " " + center[0] + " " + center[1]);
  }
  
}
