Grid g;
ArrayList<TextBox> boxes;

void setup() {
  size(1200, 900);
  background(240);
  g = new Grid();
  boxes = new ArrayList<TextBox>();
  for(int i = 0; i < 10; i++) {
    boxes.add(new TextBox(i));
  }
}

void draw() {
  for(TextBox b : boxes) {
    b.draw();
  }
  g.draw();
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  g.zoom(e);
}

void keyPressed() {
  for(TextBox b : boxes) {
    if (b.getStatus()) {
      if (key == BACKSPACE) b.remove();
      else b.add(key);
    }
  }
}

void mouseClicked() {
  for(TextBox b : boxes) {
    b.changeStatus();
  }
}
