interface Variable {
  public abstract void set(String e);
}

class Slider implements Variable {
  Character name;
  String value = "";
  float lbound = -10;
  float rbound = 10;
  public Slider(Character n) {
    name = n;
  }
  void set(String e) {
    if (e.length() >= 1) {
      int l = 0;
      for (Character key : vars.keySet()) {
        int j = vars.get(key).split(",").length;
        if (j > l) {
          l = j;
        }
      }
      vars.put(name, e+String.format("%0"+(l-1) + "d", 0).replace("0", "," + e));
    } else {
      vars.remove(name);
    }
  }
}

class List implements Variable {
  Character name;
  String value = "";
  public List(Character n) {
    name = n;
  }
  void set(String e) {
    e = e.replace("[", "");
    e = e.replace("]", "");
    if (e.length() >= 1) {
      vars.put(name, e);
    } else {
      vars.remove(name);
    }
  }
}
