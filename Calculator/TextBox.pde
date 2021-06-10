class TextBox {

  private String e;
  private int rank;
  private boolean clicked, error;
  private Function f;
  private Conic c;
  
  TextBox(int r) {
    e = "";
    rank = r;
    clicked = false;
    error = false;
    if (e.contains("x") && e.contains("y") && (e.indexOf("x") < e.indexOf("=") && e.indexOf("y") < e.indexOf("=")) && e.length() > e.indexOf("=") + 1) c = new Conic(e);
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
    
    //graph
    if (c != null) c.draw(n);
    else f.draw(n);
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
    }
    else error = true;
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
    }
    else error = true;
  }
  
  //changes the selection status and coloration of the textbox
  void changeStatus() {
    if (0 <= mouseX && mouseX <= 300 && rank * 90 <= mouseY && mouseY < (rank + 1) * 90) {
      clicked = true;
    }
    else clicked = false;
  }
  
  void updateF() {
    f = new Function(e);
  }
  
  Function getF() {
    return f;
  }
  
  void updateC() {
    if (e.contains("x") && e.contains("y") && (e.indexOf("x") < e.indexOf("=") && e.indexOf("y") < e.indexOf("=")) && e.length() > e.indexOf("=") + 1) c = new Conic(e);
  }

}
