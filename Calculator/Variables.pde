interface Variables {
  public abstract void draw();
  public abstract String value();
}

class Sliders implements Variables {
  String name;
  int value;
  void draw() {
  }
  String value() {
    return "";
  }
}

class Lists implements Variables {
  String name;
  int[] values;
  void draw() {
  }
  String value() {
    return "";
  }
}
