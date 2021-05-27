class TextBox {

  private String e;
  private int rank;
  private boolean clicked;
  
  TextBox(int r) {
    e = "";
    rank = r;
    clicked = false;
  }
  
  void draw() {
    //field
    if (clicked) fill(220, 245, 255);
    else fill(245);
    stroke(191);
    rect(0, rank * 90, 300, (rank + 1) * 90);
    
    //ordinal number
    textSize(15);
    fill(191);
    text(rank + 1 + ". ", 15, rank * 90 + 52.5);
    
    //equation
    fill(63);
    text(e, 45, rank * 90 + 52.5);
  }
  
  boolean getStatus() {
    return clicked;
  }
  
  void add(char c) {
    e += c;
  }
  
  void remove() {
    if (e.length() > 0) e = e.substring(0, e.length() - 1);
  }
  
  void changeStatus() {
    if (0 <= mouseX && mouseX <= 300 && rank * 90 <= mouseY && mouseY < (rank + 1) * 90) {
      clicked = true;
    }
    else clicked = false;
  }

}
