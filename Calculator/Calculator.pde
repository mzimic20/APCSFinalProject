Grid n = new Grid();
ArrayList<TextBox> boxes;
float[] center = null;

void setup() {
  size(1200, 900);
  background(240);
  boxes = new ArrayList<TextBox>();
  for(int i = 0; i < 10; i++) {
    boxes.add(new TextBox(i));
  }
}

void draw() {
  background(240);
  for(TextBox t : boxes) {
    t.draw();
  }
  n.draw();
  /*
  Conic c = new Conic("(x+1)^2/49+(y-2)^2/4=1");
  c.getInfo();
  println();
  c.draw(n);
  */
}

void mouseWheel(MouseEvent event) {
  n.zoom(event.getCount() == -1, mouseX, mouseY);
}

void mousePressed(MouseEvent event) {
  center = new float[] {n.rx(mouseX),n.ry(mouseY)};
}

void mouseReleased(MouseEvent event) {
  center = null;
}

void mouseDragged(MouseEvent event) {
  if (center != null && mouseX > 300) {
    n.move(center[0],center[1],mouseX,mouseY);
  }
}

void keyPressed() {
  TextBox target = null;
  for(TextBox b : boxes) {
    if (b.getStatus()) {
      if (key == BACKSPACE) b.remove();
      else if (key != CODED) b.add(key);
      target = b;
    }
  }
  //if (target != null) print(target.getF().getTree());
}

void mouseClicked() {
  for(TextBox b : boxes) {
    b.changeStatus();
  }
}
