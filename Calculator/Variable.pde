interface Variable {
  public abstract void set(String e);
}

class Slider implements Variable {
  Character name;
  float n = 0;
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
      if (l > 0) vars.put(name, e+new String(new char[l-1]).replace("\0",","+e));
    } else {
      vars.remove(name);
    }
    if (e.equals("")) {n = 0;} else {n = Float.parseFloat(e);}
    if (n < lbound) {
      lbound = n;
    }
    if (n > rbound) {
      rbound = n;
    }
  }
  
}

class List implements Variable {
  Character name;
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
