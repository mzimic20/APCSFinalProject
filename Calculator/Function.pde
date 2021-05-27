class Function {

  private String e;
  private ArrayList<Object> tree;
  
  Function(String s) {
    e = s;
    tree = new ArrayList<Object>();
    parseExpression(e);
  }
  
  void parseExpression(String s) {
    //base case
    if (s.length() <= 1) {
      if (s.equals("x") || s.equals("y")) tree.add(s);
      else if (!s.isEmpty()) tree.add(Float.parseFloat(s));
    }
    
    //split along =, = should be the final operation and at the 0th index in tree
    if (s.contains("=")) {
      tree.add('=');
      parseExpression(s.substring(0, s.indexOf("=")));
      parseExpression(s.substring(s.indexOf("=") + 1, s.length()));
    }
    
    //else, search for operators in reverse PEMDAS
    else {
      //loop once for addition and subtraction
      for(int i = 0; i < s.length(); i++) {
        if (s.charAt(i) == '+' || s.charAt(i) == '-' && this.pbounds(s, i)) {
          tree.add(s.charAt(i));
          parseExpression(s.substring(0, i));
          parseExpression(s.substring(i + 1, s.length()));
        }
      }
      //loop again for multiplication and division
      for(int i = 0; i < s.length(); i++) {
        if (s.charAt(i) == '*' || s.charAt(i) == '/' && this.pbounds(s, i)) {
          tree.add(s.charAt(i));
          parseExpression(s.substring(0, i));
          parseExpression(s.substring(i + 1, s.length()));
        }
        //test for variable multiplication, ex: 4x instead of 4 * x, but read 4x as 4 * x
        if ((i != 0 && i < s.length() - 1) &&
            (s.charAt(i + 1) == 'x' || s.charAt(i - 1) == 'x' || s.charAt(i + 1) == 'y' || s.charAt(i - 1) == 'y') &&
            (s.charAt(i) != '+' || s.charAt(i) != '-' || s.charAt(i) != '*' || s.charAt(i) != '/' || s.charAt(i) != '^') && 
            this.pbounds(s, i)) {
          tree.add('*');
          parseExpression(s.substring(0, i));
          parseExpression(s.substring(i + 1, s.length()));
            }
      }
    }
  }
  
  boolean pbounds(String s, int index) {
    int count = 0;
    for(int i = 0; i <= index; i++) {
      if (s.charAt(i) == '(') count++;
      if (s.charAt(i) == ')') count--;
    }
    if (count == 0) return true;
    else return false;
  }

}
