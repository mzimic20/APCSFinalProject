import java.util.Arrays;
class TextBox {

  private String e;
  int rank;
  boolean clicked, error;
  private Object o;

  TextBox(int r) {
    e = "";
    rank = r;
    clicked = false;
    error = false;
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
    if (o instanceof ArrayList<?> && ((ArrayList) o).size() > 0) {
      for (int i = 0; i < ((ArrayList) o).size(); i++) {
        if (((ArrayList) o).get(0) instanceof Function) {
          ((Function)((ArrayList) o).get(i)).draw(n);
        }
        if (((ArrayList) o).get(0) instanceof Conic) {
          ((Conic)((ArrayList) o).get(i)).draw(n);
        }
        if (((ArrayList) o).get(0) instanceof Point) {
          ((Point)((ArrayList) o).get(i)).draw(n);
        }
      }
      if (o instanceof Slider) {
        //((Slider) o).
      }
    }
    stroke(191);
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
    } else this.updateO();
  }

  //modifies the text by removing from the string
  void remove() {
    if (e.length() == 1) {e = ""; o = null;} else if (!e.isEmpty()) { e = e.substring(0, e.length() - 1);
    }
    if (o instanceof ArrayList<?> && ((ArrayList) o).size() > 0 && ((ArrayList) o).get(0) instanceof Function) {
      for (int i = 0; i < ((ArrayList) o).size(); i++) {
        Function f = (Function)((ArrayList) o).get(i);
        //tests for whether or not parentheses are balanced, if not, it does not graph
        if (f.pbounds(e, e.length() - 1)) {
          error = false;
          this.updateO();
        } else error = true;
      }
    } else {
      this.updateO();
    }
  }

  //changes the selection status and coloration of the textbox
  void changeStatus() {
    if (0 <= mouseX && mouseX <= 300 && rank * 90 <= mouseY && mouseY < (rank + 1) * 90) {
      clicked = true;
    } else clicked = false;
  }

  void updateO() {
    //replaces variables in equation with correct value
    if (e.contains("x") || e.contains("y") || (e.contains("(") && e.contains(")"))) {
      //determines max length of all lists
      int l = 0;
      for (Character key : vars.keySet()) {
        int j = vars.get(key).split(",").length;
        if (j > l) {
          l = j;
        }
      }
      if ((e.length() > 2 && (e.substring(0,2).equals("y=") || e.substring(0,2).equals("x="))) || (!e.contains("=") && !e.contains("(") && !e.contains(")"))) {
        o = new ArrayList<Function>();
      } else if (e.contains("x") && e.contains("y") && (e.indexOf("x") < e.indexOf("=") && e.indexOf("y") < e.indexOf("=")) && e.length() > e.indexOf("=") + 1) {
        o = new ArrayList<Conic>();
      } else if (e.contains("(") && e.contains(")")) {
        o = new ArrayList<Point>();
      }
      if (l != 0) {
        for (int i = 0; i < l; i++) {
          String edited = e;
          for (Character key : vars.keySet()) {
            String[] r = vars.get(key).split(",");
            if (r.length-1 < i) {
              continue;
            } else {
              if (r[i].equals("")) {
                continue;
              }
              edited = edited.replace(""+key, r[i]);
            }
          }
          //replaces variables with their proper values
          if ((e.length() > 2 && (e.substring(0,2).equals("y=") || e.substring(0,2).equals("x="))) || (!e.contains("=") && !e.contains("(") && !e.contains(")"))) {
            ((ArrayList<Function>) o).add(new Function(edited));
          } else if (e.contains("x") && e.contains("y") && (e.indexOf("x") < e.indexOf("=") && e.indexOf("y") < e.indexOf("=")) && e.length() > e.indexOf("=") + 1) {
            ((ArrayList<Conic>) o).add(new Conic(edited));
          } else if (e.contains("(") && e.contains(")")) {
            ((ArrayList<Point>) o).add(new Point(edited));
          }
        }
      } else {
        if ((e.length() > 2 && (e.substring(0,2).equals("y=") || e.substring(0,2).equals("x="))) || (!e.contains("=") && !e.contains("(") && !e.contains(")"))) {

          ((ArrayList<Function>) o).add(new Function(e));
        } else if (e.contains("x") && e.contains("y") && (e.indexOf("x") < e.indexOf("=") && e.indexOf("y") < e.indexOf("=")) && e.length() > e.indexOf("=") + 1) {
          ((ArrayList<Conic>) o).add(new Conic(e));
        } else if (e.contains("(") && e.contains(")")) {
          ((ArrayList<Point>) o).add(new Point(e));
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
