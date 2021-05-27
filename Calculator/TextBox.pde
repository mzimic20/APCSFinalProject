class TextBox {

  private String e;
  private int rank;
  
  TextBox(int i) {
    e = "";
    rank = i;
  }
  
  void draw() {
    //field
    fill(245);
    stroke(125);
    rect(0, rank * 90, 300, (rank + 1) * 90);
    
    //number
    textSize(15);
    fill(192);
    text(rank + 1 + ". ", 15, rank * 90 + 52.5);
    
    //equation
    fill(63);
    text(e, 50, rank * 90 + 52.5);
  }

}
