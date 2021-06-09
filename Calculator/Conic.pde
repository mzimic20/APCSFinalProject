class Conic {

  private String e;
  private float vaxis, haxis;
  private float[] center;
  
  Conic(String s) {
    e = s;
    vaxis = parseVaxis();
    haxis = parseHaxis();
    //center = parseCenter();
  }
  
  float parseVaxis() {
    if (e.charAt(e.indexOf("y^2") + 3) == '/') {
      float l = getNum(e.indexOf("y^2") + 3);
      return l;
    }
    return 0;
  }
  
  float parseHaxis() {
    if (e.charAt(e.indexOf("x^2") + 3) == '/') {
      float l = getNum(e.indexOf("x^2") + 3);
      return l;
    }
    return 0;
  }
  
  float getNum(int index) {
    for(int i = index; i < e.length(); i++) {
      if (!Character.isDigit(e.charAt(i))) return Float.parseFloat(e.substring(index, i));
    }
    return 0;
  }
  
}
