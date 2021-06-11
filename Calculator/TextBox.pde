import java.util.Arrays;
class TextBox {

  private String e;
  int rank;
  boolean clicked, error;
  private Function f;
  private Conic c;
  private Point p;
  private Object o;

  TextBox(int r) {
    e = "";
    rank = r;
    clicked = false;
    error = false;
    if (e.length() > 0 && e.charAt(0) == '(' && e.charAt(e.length() - 1) == ')' && e.contains(",")) p = new Point(e);
    else if (e.contains("x") && e.contains("y") && (e.indexOf("x") < e.indexOf("=") && e.indexOf("y") < e.indexOf("=")) && e.length() > e.indexOf("=") + 1) c = new Conic(e);
    else f = new Function(e);
  }

  void draw() {
    textAlign(LEFT);
    //field
    if (clicked) fill(220, 245, 255);
    else if (error) fill(255, 220, 220);
    else fill(245);
    stroke(191);
    rect(0, rank * 90, 300, (rank + 1) * 90);

    //ordinal number
    textSize(15);
    fill(191);
    text(rank + 1 + ". ", 10, rank * 90 + 52.5);

    //equation
    fill(63);
    text(e, 30 + 10 * (int) (log(rank+1) / log(10)), rank * 90 + 52.5);

    //color
    stroke(genColor());
    fill(genColor());
    if (!e.isEmpty()) circle(280, rank * 90 + 45, 5);
    
    //graph
    if (p != null) p.draw(n);
    else if (c != null) c.draw(n);
    else f.draw(n);
    stroke(191);
  
    //graph
    if (o instanceof ArrayList<?> && ((ArrayList) o).size() > 0 && ((ArrayList) o).get(0) instanceof Function) {
      for (int i = 0; i < ((ArrayList) o).size(); i++) {
        ((Function)((ArrayList) o).get(i)).draw(n);
      }
    }
    if (o instanceof Slider) {
      //((Slider) o).
    }

  }
  
  color genColor() {
    color out = #888888;
    if (rank == 1) out = #dd6666;
    else if (rank == 2) out = #6666dd;
    else if (rank == 3) out = #66dd66;
    else if (rank == 4) out = #cc55cc;
    else if (rank == 5) out = #dd8866;
    else if (rank == 6) out = #66dddd;
    else if (rank == 7) out = #663366;
    else if (rank == 8) out = #eeaacc;
    else if (rank == 9) out = #000000;
    return out;
  }

  boolean getStatus() {
    return clicked;
  }

  //modifies the text by concatenating to the string
  void add(char c) {
    e += c;
    //tests for whether or not parentheses are balanced, if not, it does not graph
    if (f.pbounds(e, e.length() - 1)) {
      error = false;
      this.updateF();
      this.updateC();
      this.updateP();
    }
    this.updateO();
    if (o instanceof ArrayList<?> && ((ArrayList) o).size() > 0 && ((ArrayList) o).get(0) instanceof Function) {
      for (int i = 0; i < ((ArrayList) o).size(); i++) {
        Function f = (Function)((ArrayList) o).get(i);
        //tests for whether or not parentheses are balanced, if not, it does not graph
        if (f.pbounds(e, e.length() - 1)) {
          error = false;
          this.updateO();
        } else error = true;
      }

    }
  }

  //modifies the text by removing from the string
  void remove() {
    if (!e.isEmpty()) e = e.substring(0, e.length() - 1);
    this.updateF();
    //tests for whether or not parentheses are balanced, if not, it does not graph
    if (f.pbounds(e, e.length() - 1)) {
      error = false;
      this.updateF();
      this.updateC();
      this.updateP();
    }
    this.updateO();
    if (o instanceof ArrayList<?> && ((ArrayList) o).size() > 0 && ((ArrayList) o).get(0) instanceof Function) {
      for (int i = 0; i < ((ArrayList) o).size(); i++) {
        Function f = (Function)((ArrayList) o).get(i);
        //tests for whether or not parentheses are balanced, if not, it does not graph
        if (f.pbounds(e, e.length() - 1)) {
          error = false;
          this.updateO();
        } else error = true;
      }
    }
  }

  //changes the selection status and coloration of the textbox
  void changeStatus() {
    if (0 <= mouseX && mouseX <= 300 && rank * 90 <= mouseY && mouseY < (rank + 1) * 90) {
      clicked = true;
    } else clicked = false;
  }
  
  void updateF() {
    f = new Function(e);
  }
  
  void updateC() {
    if (e.contains("x") && e.contains("y") && (e.indexOf("x") < e.indexOf("=") && e.indexOf("y") < e.indexOf("=")) && e.length() > e.indexOf("=") + 1) c = new Conic(e);
  }
  
  void updateP() {
    if (e.length() > 0 && e.charAt(0) == '(' && e.charAt(e.length() - 1) == ')' && e.contains(",")) p = new Point(e);
    else p = null;
  }
  
  Point getP() {
    return p;
  }

  void updateO() {
    //replaces variables in equation with correct value
    if (e.contains("x") || e.contains("y")) {
      //determines max length of all lists
    int l = 0;
    for (Character key : vars.keySet()) {
      int j = vars.get(key).split(",").length;
      if (j > l) {
        l = j;
      }
    }
      if (e.contains("x^2") && e.contains("y^2")) {
        //o = new ArrayList<Conic>();
      } else {
        o = new ArrayList<Function>();
      }
      if (l != 0) {
      for (int i = 0; i < l; i++) {
        String edited = e;
        for (Character key : vars.keySet()) {
          String[] r = vars.get(key).split(",");
          if (r.length-1 < i) {
            continue;
          } else {
            edited = edited.replace(""+key, r[i]);
          }
        }
        //replaces variables with their proper values
        if (e.contains("x^2") && e.contains("y^2")) {
          //((ArrayList<Conic>) o).add(new Conic(edited));
        } else {
          ((ArrayList<Function>) o).add(new Function(edited));
        }
      }}
       else {
        if (e.contains("x^2") && e.contains("y^2")) {
            //((ArrayList<Conic>) o).add(new Conic(e));
          } else {
            ((ArrayList<Function>) o).add(new Function(e));
          }
      }
    } else if (e.length() >= 2 && e.contains("=")) {
      if (e.contains(",") || e.contains("[") || e.contains("]")) {
        o = new List(e.charAt(0));
      } else {
        o = new Slider(e.charAt(0));
      }
      ((Variable) o).set(e.substring(2));
    }
  }
}
