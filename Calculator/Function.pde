class Function {

  private String e;
  private ArrayList<Object> tree;
  
  Function(String s) {
    e = s;
    tree = new ArrayList<Object>();
    parseExpression(e);
  }
  
  //creates an expression tree based on the string equation
  void parseExpression(String s) {
    //base case
    if (this.isNumber(s) || s.length() <= 1) {
      tree.add(s);
    }
    
    //split along =, = should be the final operation and at the 0th index in tree
    else if (s.contains("=")) {
      tree.add('=');
      parseExpression(s.substring(0, s.indexOf("=")));
      parseExpression(s.substring(s.indexOf("=") + 1, s.length()));
    }
    
    //else, search for operators in reverse PEMDAS
    else {
      boolean next = true;
      //loop once for addition and subtraction
      for(int i = 0; i < s.length(); i++) {
        if (s.charAt(i) == '+' || s.charAt(i) == '-' && this.pbounds(s, i)) {
          tree.add(s.charAt(i));
          parseExpression(s.substring(0, i));
          parseExpression(s.substring(i + 1, s.length()));
          next = false;
          break;
        }
      }
      //loop again for multiplication and division
      if (next) {
        for(int i = 0; i < s.length(); i++) {
          if (s.charAt(i) == '*' || s.charAt(i) == '/' && this.pbounds(s, i)) {
            tree.add(s.charAt(i));
            parseExpression(s.substring(0, i));
            parseExpression(s.substring(i + 1, s.length()));
            next = false;
            break;
          }
          //test for notation like 3x and 3(x+1) and count it as multiplication
          else if (i > 0 && (s.charAt(i) == 'x' || s.charAt(i) == 'y' || s.charAt(i) == '(') && this.pbounds(s, i) &&
                   (s.charAt(i - 1) != '+' || s.charAt(i - 1) != '-' || 
                   s.charAt(i - 1) != '*' || s.charAt(i - 1) != '/' || 
                   s.charAt(i - 1) != '^')) {
            tree.add('*');
            parseExpression(s.substring(0, i));
            parseExpression(s.substring(i, s.length()));
            next = false;
            break;
          }
        }
      }
      //loop again for exponentiation
      if (next) {
        for(int i = 0; i < s.length(); i++) {
          if (s.charAt(i) == '^' && this.pbounds(s, i)) {
            tree.add('^');
            parseExpression(s.substring(0, i));
            parseExpression(s.substring(i + 1, s.length()));
            next = false;
            break;
          }
        }
      }
      //LOOP FOR PARENTHESES GOES HERE
    }
  }
  
  //evaluates the expression for the given x and y values 
  boolean evaluate(float x, float y, int index) {
    return false;
  }
  
  //tests whether or not the specified index is in a parenthetical expression
  boolean pbounds(String s, int index) {
    int count = 0;
    for(int i = 0; i <= index; i++) {
      if (s.charAt(i) == '(') count++;
      if (s.charAt(i) == ')') count--;
    }
    if (count == 0) return true;
    else return false;
  }
  
  //tests whether or not the input string is a number or not
  boolean isNumber(String s) {
    char[] c = s.toCharArray();
    for(char i : c) {
      if (!Character.isDigit(i) || i != '.') return false;
    }
    return true;
  }
  
  ArrayList<Object> getTree() {
    return tree;
  }

}
