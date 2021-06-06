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
  
  
  
  //initial graphing functions
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
  
  
  
  //new graphing relations that can handle nonfunction relations
  //evaluates the expression for the given x and y values 
  boolean evaluate(float x, float y) {
    ArrayList<String> t = new ArrayList<String>();
    for(int i = 0; i < tree.size(); i++) {
      if (tree.get(i) == "x") t.add("" + x);
      else if (tree.get(i) == "y") t.add("" + y);
      else t.add(t.get(i));
    }
    if (!(t.contains("="))) {
      t.add(0, "=");
      t.add(1, "y");
    }
    if (t.size() > 2) {
      for(int i = t.size() - 3; i >= 0; i--) {
        if (t.get(i) == "+") t.set(i, "" + (Float.parseFloat(t.remove(i + 1)) + Float.parseFloat(t.remove(i + 2))));
        else if (t.get(i) == "-") t.set(i, "" + (Float.parseFloat(t.remove(i + 1)) - Float.parseFloat(t.remove(i + 2))));
        else if (t.get(i) == "*") t.set(i, "" + (Float.parseFloat(t.remove(i + 1)) * Float.parseFloat(t.remove(i + 2))));
        else if (t.get(i) == "/") t.set(i, "" + (Float.parseFloat(t.remove(i + 1)) / Float.parseFloat(t.remove(i + 2))));
        else if (t.get(i) == "^") t.set(i, "" + Math.pow(Float.parseFloat(t.remove(i + 1)), Float.parseFloat(t.remove(i + 2))));
        else if (t.get(i) == "=") {
          if (Math.abs(Float.parseFloat(t.remove(i + 1)) - Float.parseFloat(t.remove(i + 2))) < .001) return true;
        }
      }
    }
    return false;
  }
  
  void draw() {
    stroke(0);
    for(int x = 300; x < 300 + 900; x++) {
      for(int y = 0; y < 900; y++) {
        if (evaluate(n.rx(x), n.ry(y))) point(x, y);
      }
    }
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
