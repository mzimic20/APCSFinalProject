class TextBox {

  private String e;
  private int rank;
  
  TextBox(int r) {
    e = "";
    rank = r;
  }
  
  void draw() {
    //field
    fill(245);
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

}
