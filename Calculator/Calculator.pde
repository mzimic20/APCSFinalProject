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
  for(TextBox t : boxes) {
    t.draw();
  }
  g.draw();
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  g.zoom(e);
}
