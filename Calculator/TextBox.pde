class TextBox {

  private String e;
  private int rank;
  private boolean clicked, error;
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

    //graph
    if (o instanceof Function) {
      ((Function) o).draw(n);
    }
  }

  boolean getStatus() {
    return clicked;
  }

  //modifies the text by concatenating to the string
  void add(char c) {
    e += c;
    this.updateO();
    if (o instanceof Function) {
      Function f = (Function) o;
      //tests for whether or not parentheses are balanced, if not, it does not graph
      if (f.pbounds(e, e.length() - 1)) {
        error = false;
        this.updateO();
      } else error = true;
    }
  }

  //modifies the text by removing from the string
  void remove() {
    if (!e.isEmpty()) e = e.substring(0, e.length() - 1);
    this.updateO();
    if (o instanceof Function) {
      Function f = (Function) o;
      //tests for whether or not parentheses are balanced, if not, it does not graph
      if (f.pbounds(e, e.length() - 1)) {
        error = false;
        this.updateO();
      } else error = true;
    }
  }

  //changes the selection status and coloration of the textbox
  void changeStatus() {
    if (0 <= mouseX && mouseX <= 300 && rank * 90 <= mouseY && mouseY < (rank + 1) * 90) {
      clicked = true;
    } else clicked = false;
  }

  void updateO() {
        String edited = e;
        if (e.contains("x") || e.contains("y")) {
          //replaces variables with their proper values
            if (e.contains("x^2") && e.contains("y^2")) {
              //o = new Conic(edited);
            } else {
              o = new Function(edited);
            }
        } else if (e.length() > 2) {
          if (e.contains(",")) {
            o = new List(e.charAt(0));
          } else {
            o = new Slider(e.charAt(0));
          }
          ((Variable) o).set(e.substring(2));
        }
  }
}
