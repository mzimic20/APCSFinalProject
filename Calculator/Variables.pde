interface Variable {
  public abstract void draw();
  public abstract String value();
}

class Slider implements Variable {
  String name;
  int value;
  public Slider(String n) {
    name = n;
    value = 0;
  }
  void set(int v) {
    value = v;
  }
  void draw() {
  }
  String value() {
    return "";
  }
}

class List implements Variable {
  String name;
  int[] values;
  void draw() {
  }
  String value() {
    return "";
  }
}
