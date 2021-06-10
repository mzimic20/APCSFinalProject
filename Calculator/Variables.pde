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
      vars.put(name,e);
    } else {
      vars.put(name,"0");
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
    e = e.replace("[","");
    e = e.replace("]","");
    if (e.length() >= 1) {
      vars.put(name,e);
    } else {
      vars.put(name,"0");
    }
  }
}
