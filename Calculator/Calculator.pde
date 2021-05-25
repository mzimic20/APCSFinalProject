Grid g;

void setup() {
  size(1200, 900);
  background(240);
  g = new Grid();
}

void draw() {
  g.draw();
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  g.zoom(e);
}
