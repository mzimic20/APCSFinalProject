import java.util.ArrayDeque;
import java.util.NoSuchElementException;
class Function {

  private String e;
  private ArrayList<String> tree;

  Function(String s) {
    e = s;
    tree = new ArrayList<String>();
    parseExpression(e);
    for(int i = 0; i < tree.size(); i++) {
      if (tree.get(i).equals("")) tree.set(i, "0");
    }
  }

  //creates an expression tree based on the string equation
  void parseExpression(String s) {
    //strip parentheses if they encase the whole expression
    if (s.length() > 1 && s.charAt(0) == '(') {
      boolean strip = true;
      for (int i = 0; i < s.length() - 1; i++) {
        if (this.pbounds(s, i)) strip = false;
      }
      if (strip) s = s.substring(1, s.length() - 1);
    }

    //base case
    if (this.isNumber(s) || s.length() <= 1) {
      tree.add(s);
    }

    //split along =, = should be the final operation and at the 0th index in tree
    else if (s.contains("=")) {
      tree.add("=");
      parseExpression(s.substring(0, s.indexOf("=")));
      parseExpression(s.substring(s.indexOf("=") + 1, s.length()));
    }

    //else, search for operators in reverse PEMDAS
    else {
      boolean next = true;
      //loop once for addition and subtraction
      for (int i = s.length() - 1; i >= 0; i--) {
        if ((s.charAt(i) == '+' || s.charAt(i) == '-') && this.pbounds(s, i)) {
          tree.add("" + s.charAt(i));
          parseExpression(s.substring(0, i));
          parseExpression(s.substring(i + 1, s.length()));
          next = false;
          break;
        }
      }
      //loop again for multiplication and division
      if (next) {
        for (int i = s.length() - 1; i >= 0; i--) {
          if (s.charAt(i) == '*' || s.charAt(i) == '/' && this.pbounds(s, i)) {
            tree.add("" + s.charAt(i));
            parseExpression(s.substring(0, i));
            parseExpression(s.substring(i + 1, s.length()));
            next = false;
            break;
          }
          //test for notation like 3x and count it as multiplication
          else if (i > 0 && (s.charAt(i) == 'x' || s.charAt(i) == 'y') && this.pbounds(s, i) &&
            (s.charAt(i - 1) != '+' || s.charAt(i - 1) != '-' || 
            s.charAt(i - 1) != '*' || s.charAt(i - 1) != '/' || 
            s.charAt(i - 1) != '^')) {
            tree.add("*");
            parseExpression(s.substring(0, i));
            parseExpression(s.substring(i, s.length()));
            next = false;
            break;
          }
          //test for notation 3(x+1) and count as multiplication
          else if (i > 0 && (s.charAt(i) == '(') &&
            (s.charAt(i - 1) != '+' || s.charAt(i - 1) != '-' || 
            s.charAt(i - 1) != '*' || s.charAt(i - 1) != '/' || 
            s.charAt(i - 1) != '^')) {
            tree.add("*");
            parseExpression(s.substring(0, i));
            parseExpression(s.substring(i, s.length()));
            next = false;
            break;
          }
        }
      }
      //loop again for exponentiation
      if (next) {
        for (int i = s.length() - 1; i >= 0; i--) {
          if (s.charAt(i) == '^' && this.pbounds(s, i)) {
            tree.add("^");
            parseExpression(s.substring(0, i));
            parseExpression(s.substring(i + 1, s.length()));
            next = false;
            break;
          }
        }
      }
    }
  }

  //evaluates the expression for the given x and y values 
  boolean evaluate(int index, float x, float y) {
    return false;
  }

  //tests whether or not the specified index is in a parenthetical expression
  boolean pbounds(String s, int index) {
    int count = 0;
    for (int i = 0; i <= index; i++) {
      if (s.charAt(i) == '(') count++;
      if (s.charAt(i) == ')') count--;
    }
    if (count == 0) return true;
    else return false;
  }

  //tests whether or not the input string is a number or not
  boolean isNumber(String s) {
    char[] c = s.toCharArray();
    for (char i : c) {
      if (i != '.') {
        if (!Character.isDigit(i)) return false;
      }
    }
    return true;
  }

  ArrayList<String> getTree() {
    return tree;
  }
<<<<<<< HEAD
 

  void draw(Grid n) {
    if (tree.get(0).equals("=") && tree.get(1).equals("y") && tree.lastIndexOf("y") < 2) {
      float x1 = n.rx(300);
      float y1 = evaluate(x1,2);
      for (int i = 301; i < 300 + 899; i++) {
        float x2 = n.rx(i+1);
        float y2 = evaluate(x2,2);
        n.connect(x1, y1, x2, y2);
        x1 = x2;
        y1 = y2;
      }
      return;
    }
    if (tree.get(0).equals("=") && tree.get(1).equals("x") && tree.lastIndexOf("x") < 2) {
      float y1 = n.ry(900);
      float x1 = evaluate(y1,2);
      for (int i = 900; i >= 0; i--) {
        float y2 = n.ry(i-1);
        float x2 = evaluate(y2,2);
        n.connect(x1,y1,x2,y2);
        x1 = x2;
        y1 = y2;
      }
      return;
    }
    if (!tree.contains("=") && (!tree.contains("y") && tree.contains("x"))) {
      float x1 = n.rx(300);
      float y1 = evaluate(x1,0);
      for (int i = 301; i < 300 + 899; i++) {
        float x2 = n.rx(i+1);
        float y2 = evaluate(x2,0);
        n.connect(x1, y1, x2, y2);
        x1 = x2;
        y1 = y2;
      }
      return;
    }
  }
  float evaluate(float v, int index) {
    String[] r = tree.toArray(new String[0]);
    for (int i = 0; i < r.length; i++) {
      if (r[i].equals("x") || r[i].equals("y")) {
        r[i] = "" + v;
      }
    }
    if (r.length > index) {
      ArrayDeque<Float> stack = new ArrayDeque<Float>();
      for (int i = r.length-1; i >= index; i--) {
=======
  void draw(Grid n) {
    for (int i = 300; i < 300 + 899; i++) {
      float x1 = n.rx(i);
      float y1 = evaluate(x1);
      float x2 = n.rx(i+1);
      float y2 = evaluate(x2);
      n.connect(x1, y1, x2, y2);
    }
  }
  float evaluate(float x) {
    String[] r = tree.toArray(new String[0]);
    for (int i = 0; i < r.length; i++) {
      if (r[i].equals("x")) {
        r[i] = "" + x;
      }
    }
    if (r.length > 2) {
      ArrayDeque<Float> stack = new ArrayDeque<Float>();
      for (int i = r.length-1; i >= 2; i--) {
>>>>>>> marko
        if (isFloat(r[i])) {
          stack.addLast(Float.parseFloat(r[i]));
        } else {
          float m, n;
          try {
            m = stack.removeLast();
            n = stack.removeLast();
            if (r[i].equals("+")) {
              stack.addLast(m + n);
            } else if (r[i].equals("-")) {
              stack.addLast(m - n);
            } else if (r[i].equals("*")) {
              stack.addLast(m * n);
            } else if (r[i].equals("/")) {
              stack.addLast(m / n);
            } else if (r[i].equals("%")) {
              stack.addLast(m % n);
            } else if (r[i].equals("^")) {
              stack.addLast(pow(m,n));
            }
            else {
              //throw new IllegalArgumentException("incorrectly formatted string: operation");
            }
          } 
          catch (NoSuchElementException e) {
            //throw new IllegalArgumentException("not enough operands");
          }
        }
      }
      if (stack.size() == 1) {
        return stack.removeLast();
      } else if (stack.size() == 0) {
        //throw new IllegalArgumentException("incorrectly formatted string: empty");
      } else {
        //throw new IllegalArgumentException("too many operands");
      }
    }
    return 0;
  }
  boolean isFloat(String str) {
    try {
      Float.parseFloat(str);
      return true;
    } 
    catch (NumberFormatException e) {
      return false;
    }
  }
}
