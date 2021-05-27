Grid n = new Grid();
ArrayList<TextBox> boxes;

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
}

void mouseWheel(MouseEvent event) {
  n.zoom(event.getCount() == -1, mouseX, mouseY);
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
  print(target.getF().getTree());
}

void mouseClicked() {
  for(TextBox b : boxes) {
    b.changeStatus();
  }
}
