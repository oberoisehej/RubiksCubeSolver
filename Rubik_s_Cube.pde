import processing.video.*;
import static javax.swing.JOptionPane.*;

Capture cam;

PImage cubeBack;
PImage r;
PImage b;
PImage g;
PImage o;
PImage y;
PImage w;

static int[][] whiteLoc;
static int[][] orangeLoc;
static int[][] greenLoc;
static int[][] redLoc;
static int[][] blueLoc;
static int[][] yellowLoc;

static int[][][] loc;

static int[][] colorPos;

static double[][][] colorRanges;
//range = {{{rg h, rg l}, {rb h, rb l}, {bg g, bg l}}} in cube order

PieceCube cube;
int[][][] inputCube;
Solver s;

static char[] order = {'w', 'o', 'g', 'r', 'b', 'y'};
static PImage[] imageOrder;

int[][][] curImage;

boolean confirmed;
boolean covered;
int section = 1;

void setup() {
  size(1000, 700);
  background(230);
  colorMode(HSB, 100);
  cubeBack = loadImage("cube.png");
  r = loadImage("red.png");
  b = loadImage("blue.png");
  g = loadImage("green.png");
  o = loadImage("orange.png");
  y = loadImage("yellow.png");
  w = loadImage("white.png");
  
  imageOrder = new PImage[] {w, o, g, r, b, y};
  curImage = new int[6][3][3];
  confirmed = false;
  covered = false;
  
  cube = new PieceCube();
  //cube.addCorner(new Corner(0, 4, 1), 0);
  //cube.addCorner(new Corner(0, 3, 4), 1);
  //cube.addCorner(new Corner(0, 2, 3), 2);
  //cube.addCorner(new Corner(0, 1, 2), 3);
  //cube.addCorner(new Corner(5, 1, 4), 4);
  //cube.addCorner(new Corner(5, 4, 3), 5);
  //cube.addCorner(new Corner(5, 3, 2), 6);
  //cube.addCorner(new Corner(5, 2, 1), 7);

  //cube.addEdge(new Edge(0, 4), 0);
  //cube.addEdge(new Edge(0, 3), 1);
  //cube.addEdge(new Edge(0, 2), 2);
  //cube.addEdge(new Edge(0, 1), 3);
  //cube.addEdge(new Edge(4, 1), 4);
  //cube.addEdge(new Edge(4, 3), 5);
  //cube.addEdge(new Edge(2, 3), 6);
  //cube.addEdge(new Edge(2, 1), 7);
  //cube.addEdge(new Edge(5, 4), 8);
  //cube.addEdge(new Edge(5, 3), 9);
  //cube.addEdge(new Edge(5, 2), 10);
  //cube.addEdge(new Edge(5, 1), 11);
  
  inputCube = new int[6][3][3];
  
  whiteLoc = new int[][]{{300, 50},{366, 50},{432, 50},{300, 116},{366, 116},{432, 116},{300, 182},{366, 182},{432, 182}};
  orangeLoc = new int[][]{{100, 250},{166, 250},{232, 250},{100, 316},{166, 316},{232, 316},{100, 382},{166, 382},{232, 382}};
  greenLoc = new int[][]{{300, 250},{366, 250},{432, 250},{300, 316},{366, 316},{432, 316},{300, 382},{366, 382},{432, 382}};
  redLoc = new int[][]{{500, 250},{566, 250},{632, 250},{500, 316},{566, 316},{632, 316},{500, 382},{566, 382},{632, 382}};
  blueLoc = new int[][]{{700, 250},{766, 250},{832, 250},{700, 316},{766, 316},{832, 316},{700, 382},{766, 382},{832, 382}};
  yellowLoc = new int[][]{{300, 450},{366, 450},{432, 450},{300, 516},{366, 516},{432, 516},{300, 582},{366, 582},{432, 582}};
  
  loc = new int[][][]{whiteLoc, orangeLoc, greenLoc, redLoc, blueLoc, yellowLoc};
  
  colorPos = new int[][] {{774, 54},{841, 54},{907, 54},{774, 121},{841, 121},{907, 121},{774, 187},{841, 187},{907, 187}};
  
  colorRanges = new double[][][]{{{1.25, 0.75}, {1.25, 0.75}, {1.25, 0.75}}, 
                                  {{2, 1.3}, {6, 1.2}, {1.2, 0.3}}, 
                                  {{0.8, 0}, {1, 0}, {1.3, 0.3}}, 
                                  {{15, 2.01}, {8, 1.3}, {1.8, 0.4}}, 
                                  {{0.7, 0}, {0.5, 0}, {3, 1.6}}, 
                                  {{2, 0.9}, {4.8, 1.201}, {0.8, 0}}};
  
  //print(cube);
  //showCube();
  image(cubeBack, whiteLoc[0][0], whiteLoc[0][1], 198, 198);
  image(cubeBack, orangeLoc[0][0], orangeLoc[0][1], 198, 198);
  image(cubeBack, greenLoc[0][0], greenLoc[0][1], 198, 198);
  image(cubeBack, redLoc[0][0], redLoc[0][1], 198, 198);
  image(cubeBack, blueLoc[0][0], blueLoc[0][1], 198, 198);
  image(cubeBack, yellowLoc[0][0], yellowLoc[0][1], 198, 198);
  
  //cam = new Capture(this, 320, 240, 30);
  //cam.start();
  
}

void draw() {
  //if(cam.available()) {
  //  cam.read();
  //  image(cam, 680, 0);
  //  image(cubeBack, 740, 20, 200, 200);
  //} else if (confirmed && !covered) {
    image(loadImage("grey.png"), 600, 0, 400, 240);
    covered = true;
  //}
  
}

void mousePressed() {
  
  if (!confirmed){
    for (int i = 0; i < 6; i++) {
      for (int j = 0; j < 9; j++){
        if ((mouseX >= loc[i][j][0] && mouseX <= loc[i][j][0] + 66) && 
        (mouseY >= loc[i][j][1] && mouseY <= loc[i][j][1] + 66)){
          inputCube[i][j/3][j%3]++;
          inputCube[i][j/3][j%3] %= 6;
          image(imageOrder[inputCube[i][j/3][j%3]], loc[i][j][0], loc[i][j][1], 66, 66);
        }
      }
    }
  } if (confirmed) {
    if (section == 1) {
      println("Top Cross Moves");
      topCross();
      showCube();
      section++;
      return;
    }
    //delay(100);
    if (section == 2) {
      println("\n\nTop Corners Moves");
      topCorners();
      showCube();
      section++;
      return;
    }
    //delay(100);
    if (section == 3) {
      println("\n\nMiddle Layer Moves");
      middleLayer();
      showCube();
      section++;
      return;
    }
    //delay(100);
    if (section == 4) {
      println("\n\nBottom Cross Moves");
      bottomCross();
      showCube();
      section++;
      return;
    }
    //delay(100);
    if (section == 5) {
      println("\n\nBottom Corners Moves");
      bottomCorners();
      showCube();
      section = 1;
      return;
    }
    //delay(100);
  }
}



void keyPressed() {
  if (key == 'c') {
    color[] c = new color[9];
    int[][] input = new int[3][3];
    for (int i = 0; i < 9; i++) {
      c[i] = get(colorPos[i][0], colorPos[i][1]);
      for (int j = 0; j < 6; j++) {
        if ((red(c[i])/(green(c[i]) * 1.0) <= colorRanges[j][0][0] && red(c[i])/(green(c[i]) * 1.0) >= colorRanges[j][0][1]) &&
            (red(c[i])/(blue(c[i]) * 1.0) <= colorRanges[j][1][0] && red(c[i])/(blue(c[i]) * 1.0) >= colorRanges[j][1][1]) &&
            (blue(c[i])/(green(c[i]) * 1.0) <= colorRanges[j][2][0] && blue(c[i])/(green(c[i]) * 1.0) >= colorRanges[j][2][1])) {
          //println(order[j]);
          input[i/3][i%3] = j;
          break;
        }
        if (j == 5) {
          println("None");
          print("Red/Green:" + red(c[i])/(green(c[i]) * 1.0));
          print("  Red/Blue:" + red(c[i])/(blue(c[i]) * 1.0));
          println("  Blue/Green:" + blue(c[i])/(green(c[i]) * 1.0));
        }
      }
        
    }
    for (int i = 0; i < 9; i++) {
      inputCube[input[1][1]][i/3][i%3] = input[i/3][i%3];
      image(imageOrder[input[i/3][i%3]], loc[input[1][1]][i][0], loc[input[1][1]][i][1], 66, 66);
    }
    //println("Max RG:" + max(rg) + " Min RG:" + min(rg));
    //println("Max RB:" + max(rb) + " Min RB:" + min(rb));
    //println("Max BG:" + max(bg) + " Min BG:" + min(bg) + "\n\n");
  }
  if (keyCode == 10 && !confirmed) {
    int ans = showConfirmDialog(null, "Do you want to confirm the cube?", "Confirm Cube", YES_NO_OPTION);
    if (ans == YES_OPTION) {
      int[][] pieceCount = new int[6][3];
      for (int i = 0; i < 6; i++) {
        for (int j = 0; j < 9; j++) {
          if (j % 2 == 0){
            if (j == 4) {
              pieceCount[inputCube[i][j/3][j%3]][2]++;
            } else {
              pieceCount[inputCube[i][j/3][j%3]][0]++;
            }
          } else {
            pieceCount[inputCube[i][j/3][j%3]][1]++;
          }
        }
      }
      for (int i = 0; i < 6; i++) {
        if (pieceCount[i][0] != 4 || pieceCount[i][1] != 4 || pieceCount[i][2] != 1) {
          showMessageDialog(null, "This cube is not a valid cube orientation. Please Try Again");
          return;
        }
      }
      //int[][] corners = {{0, 4, 1}, {0, 3, 4}, {0, 2, 3}, {0, 1, 2}, {5, 1, 4}, {5, 4, 3}, {5, 3, 2}, {5, 2, 1}};
      //for (int i = 0; i < 8; i++) {
      //  if (findCorner(cube.corners, new Corner(corners[i][0], corners[i][1], corners[i][2])) == -1) {
      //    showMessageDialog(null, "This cube is not a valid cube orientation. Please Try Again");
      //    return;
      //  }
      //}
      //int[][] edges = {{0, 1}, {0, 2}, {0, 3}, {0, 4}, {1, 4}, {4, 3}, {3, 2}, {2, 1}, {5, 1}, {5, 2}, {5, 3}, {5, 4}};
      //for (int i = 0; i < 12; i++) {
      //  if (findEdge(cube.edges, new Edge(edges[i][0], edges[i][1])) == -1) {
      //    showMessageDialog(null, "This cube is not a valid cube orientation. Please Try Again");
      //    return;
      //  }
      //}
      confirmed = true;
      //cam.stop();
      populateCube();
      showCube();
    }
  }
  if (keyCode == 9 && !confirmed) {
    int ans = showConfirmDialog(null, "Do you want to auto populate a solved cube?", "Confirm Cube", YES_NO_OPTION);
    if (ans == YES_OPTION) {
      for (int i = 0; i < 6; i++) {
        for (int j = 0; j < 3; j++) {
          for (int k = 0; k < 3; k++) {
            inputCube[i][j][k] = i;
          }
        }
      } 
    }
    populateCube();
    showCube();
  }
  if (confirmed) {
    switch (key) {
    case ' ' :
      int move = int(random(6));
      int option = int(random(3));
      char op = ' ';
      cube.turn(move);
      switch (option) {
        case 0: op = '\'';
        cube.turn(move);
        cube.turn(move);
        break;
        case 1: op = '2';
        cube.turn(move);
      }
      showCube();
      //print(order[move] +""+ op + "\n");
      break;
    case 'u':
      cube.turn(0);
      break;
    case 'd':
      cube.turn(5);
      break;
    case 'f':
      cube.turn(2);
      break;
    case 'b':
      cube.turn(4);
      break;
    case 'r':
      cube.turn(3);
      break;
    case 'l':
      cube.turn(1);
      break;
    }
    showCube();
  }
}

void populateCube() {
  cube.addCorner(new Corner(inputCube[0][0][0], inputCube[4][0][2], inputCube[1][0][0]), 0);
  cube.addCorner(new Corner(inputCube[0][0][2], inputCube[3][0][2], inputCube[4][0][0]), 1);
  cube.addCorner(new Corner(inputCube[0][2][2], inputCube[2][0][2], inputCube[3][0][0]), 2);
  cube.addCorner(new Corner(inputCube[0][2][0], inputCube[1][0][2], inputCube[2][0][0]), 3);
  cube.addCorner(new Corner(inputCube[5][2][0], inputCube[1][2][0], inputCube[4][2][2]), 4);
  cube.addCorner(new Corner(inputCube[5][2][2], inputCube[4][2][0], inputCube[3][2][2]), 5);
  cube.addCorner(new Corner(inputCube[5][0][2], inputCube[3][2][0], inputCube[2][2][2]), 6);
  cube.addCorner(new Corner(inputCube[5][0][0], inputCube[2][2][0], inputCube[1][2][2]), 7);
  
  cube.addEdge(new Edge(inputCube[0][0][1], inputCube[4][0][1]), 0);
  cube.addEdge(new Edge(inputCube[0][1][2], inputCube[3][0][1]), 1);
  cube.addEdge(new Edge(inputCube[0][2][1], inputCube[2][0][1]), 2);
  cube.addEdge(new Edge(inputCube[0][1][0], inputCube[1][0][1]), 3);
  cube.addEdge(new Edge(inputCube[4][1][2], inputCube[1][1][0]), 4);
  cube.addEdge(new Edge(inputCube[4][1][0], inputCube[3][1][2]), 5);
  cube.addEdge(new Edge(inputCube[2][1][2], inputCube[3][1][0]), 6);
  cube.addEdge(new Edge(inputCube[2][1][0], inputCube[1][1][2]), 7);
  cube.addEdge(new Edge(inputCube[5][2][1], inputCube[4][2][1]), 8);
  cube.addEdge(new Edge(inputCube[5][1][2], inputCube[3][2][1]), 9);
  cube.addEdge(new Edge(inputCube[5][0][1], inputCube[2][2][1]), 10);
  cube.addEdge(new Edge(inputCube[5][1][0], inputCube[1][2][1]), 11);
}

void showCube() {
  for (int i = 0; i < 9; i++) {
    image(imageOrder[Character.getNumericValue(cube.whiteFace()[i/3].charAt((i % 3) * 2))], whiteLoc[i][0], whiteLoc[i][1], 66, 66);
    curImage[0][i/3][i%3] = Character.getNumericValue(cube.whiteFace()[i/3].charAt((i % 3) * 2));
    image(imageOrder[Character.getNumericValue(cube.yellowFace()[i/3].charAt((i % 3) * 2))], yellowLoc[i][0], yellowLoc[i][1], 66, 66);
    curImage[5][i/3][i%3] = Character.getNumericValue(cube.yellowFace()[i/3].charAt((i % 3) * 2));
    image(imageOrder[Character.getNumericValue(cube.orangeFace()[i/3].charAt((i % 3) * 2))], orangeLoc[i][0], orangeLoc[i][1], 66, 66);
    curImage[1][i/3][i%3] = Character.getNumericValue(cube.orangeFace()[i/3].charAt((i % 3) * 2));
    image(imageOrder[Character.getNumericValue(cube.greenFace()[i/3].charAt((i % 3) * 2))], greenLoc[i][0], greenLoc[i][1], 66, 66);
    curImage[2][i/3][i%3] = Character.getNumericValue(cube.greenFace()[i/3].charAt((i % 3) * 2));
    image(imageOrder[Character.getNumericValue(cube.redFace()[i/3].charAt((i % 3) * 2))], redLoc[i][0], redLoc[i][1], 66, 66);
    curImage[3][i/3][i%3] = Character.getNumericValue(cube.redFace()[i/3].charAt((i % 3) * 2));
    image(imageOrder[Character.getNumericValue(cube.blueFace()[i/3].charAt((i % 3) * 2))], blueLoc[i][0], blueLoc[i][1], 66, 66);
    curImage[4][i/3][i%3] = Character.getNumericValue(cube.blueFace()[i/3].charAt((i % 3) * 2));
  }
}

double max(double[] a) {
  if (a == null) {
    return -1;
  }
  double max = a[0];
  for (int i = 1; i < a.length; i++) {
    if (a[i] > max) {
      max = a[i];
    }
  }
  return max;
}

double min(double[] a) {
  if (a == null) {
    return -1;
  }
  double min = a[0];
  for (int i = 1; i < a.length; i++) {
    if (a[i] < min) {
      min = a[i];
    }
  }
  return min;
}












public void topCross() {
  int[][] es = {{0, 1}, {0, 2}, {0, 3}, {0, 4}};
  for (int i = 0; i < 4; i++) {
    int id = findEdge(cube.edges, new Edge(0, es[i][1]));
    if (id < 4) {
      if (cube.edges[id].getFaces()[cube.edges[id].orient] == 0) {
        cube.turn(4 - id);
        cube.turn(4 - id);
        print("2" + order[4 - id] + ", ");
      } else {
        cube.turn(4 - id);
        print(order[4 - id]);
        cube.turn((4 - id)%4 + 1);
        cube.turn((4 - id)%4 + 1);
        cube.turn((4 - id)%4 + 1);
        print(order[(4 - id)%4 + 1] + "', ");
        cube.turn(5);
        print("y, ");
        cube.turn((4 - id)%4 + 1);
        print(order[(4 - id)%4 + 1] + "', ");
      }
    } else if (id < 8) {
      if (cube.edges[id].getFaces()[cube.edges[id].orient] == 0) {
        if (id == 4) {
          cube.turn(1);
          cube.turn(1);
          cube.turn(1);
          print("o', ");
          cube.turn(5);
          print("y, ");
          cube.turn(1);
          print("o, ");
        } else if (id == 7) {
          cube.turn(1);
          print("o, ");
          cube.turn(5);
          print("y, ");
          cube.turn(1);
          cube.turn(1);
          cube.turn(1);
          print("o', ");
        } else if (id == 6) {
          cube.turn(3);
          cube.turn(3);
          cube.turn(3);
          print("r', ");
          cube.turn(5);
          print("y, ");
          cube.turn(3);
          print("r, ");
        } else {
          cube.turn(3);
          print("r, ");
          cube.turn(5);
          print("y, ");
          cube.turn(3);
          cube.turn(3);
          cube.turn(3);
          print("r', ");
        }
      } else {
        if (id == 4) {
          cube.turn(4);
          print("b, ");
          cube.turn(5);
          print("y, ");
          cube.turn(4);
          cube.turn(4);
          cube.turn(4);
          print("b', ");
        } else if (id == 5) {
          cube.turn(4);
          cube.turn(4);
          cube.turn(4);
          print("b', ");
          cube.turn(5);
          print("y, ");
          cube.turn(4);
          print("b, ");
        } else if (id == 6) {
          cube.turn(2);
          print("g, ");
          cube.turn(5);
          print("y, ");
          cube.turn(2);
          cube.turn(2);
          cube.turn(2);
          print("g', ");
        } else {
          cube.turn(2);
          cube.turn(2);
          cube.turn(2);
          print("g', ");
          cube.turn(5);
          print("y, ");
          cube.turn(2);
          print("g, ");
        }
      }
    } else {
      if (cube.edges[id].getFaces()[cube.edges[id].orient] != 0) {
        cube.turn(12 - id);
        cube.turn(12 - id);
        cube.turn(12 - id);
        print(order[12 - id] + "', ");
        cube.turn((12 - id)% 4 + 1);
        cube.turn((12 - id)% 4 + 1);
        cube.turn((12 - id)% 4 + 1);
        print(order[(12 - id)% 4 + 1] + "', ");
        cube.turn(5);
        print("y, ");
        cube.turn((12 - id)% 4 + 1);
        print(order[(12 - id)% 4 + 1] + ", ");
        cube.turn(12 - id);
        print(order[12 - id] + ", ");
      }
    }
    for (int j = 0; j < 4; j++) {
      id = findEdge(cube.edges, new Edge(0, es[i][1]));
      if (12 - id == es[i][1]) {
        if (j == 1) {
          print("y, ");
        } else if (j == 2) {
          print("2y, ");
        } else if (j == 3) {
          print("'y, ");
        }
        cube.turn(12 - id);
        cube.turn(12 - id);
        print("2" + order[12 - id] + ", ");
        break;
      }
      cube.turn(5);
    }
  }
}
  
public void topCorners() {
  int[][] cs = {{0, 1, 4}, {0, 4, 3}, {0, 3, 2}, {0, 2, 1}};
  for (int i = 0; i < 4; i++) {
    int id = findCorner(cube.corners, new Corner(0, cs[i][1], cs[i][2]));
    if (id < 4) {
      cube.turn(4 - id);
      print(order[4 - id] + ", ");
      cube.turn(5);
      print("y, ");
      cube.turn(4 - id);
      cube.turn(4 - id);
      cube.turn(4 - id);
      print(order[4 - id] + "', ");
    }
    for (int j = 0; j < 4; j++) {
      id = findCorner(cube.corners, new Corner(0, cs[i][1], cs[i][2]));
      if (id == i + 4) {
        if (j == 1) {
          print("y, ");
        } else if (j == 2) {
          print("2y, ");
        } else if (j == 3) {
          print("'y, ");
        }
        if (cube.corners[id].getFaces()[cube.corners[id].orient] == 0) {
          cube.turn(cs[i][1]);
          cube.turn(cs[i][1]);
          cube.turn(cs[i][1]);
          print(order[cs[i][1]] + "', ");
          cube.turn(5);
          cube.turn(5);
          print("2y, ");
          cube.turn(cs[i][1]);
          print(order[cs[i][1]] + ", ");
          cube.turn(5);
          print("y, ");
          cube.turn(cs[i][1]);
          cube.turn(cs[i][1]);
          cube.turn(cs[i][1]);
          print(order[cs[i][1]] + "', ");
          cube.turn(5);
          cube.turn(5);
          cube.turn(5);
          print("y', ");
          cube.turn(cs[i][1]);
          print(order[cs[i][1]] + ", ");
        } else if (cube.corners[id].getFaces()[cube.corners[id].orient] == cs[i][1]) {
          cube.turn(cs[i][1]);
          cube.turn(cs[i][1]);
          cube.turn(cs[i][1]);
          print(order[cs[i][1]] + "', ");
          cube.turn(5);
          cube.turn(5);
          cube.turn(5);
          print("y', ");
          cube.turn(cs[i][1]);
          print(order[cs[i][1]] + ", ");
        } else {
          cube.turn(cs[i][2]);
          print(order[cs[i][2]] + ", ");
          cube.turn(5);
          print("y, ");
          cube.turn(cs[i][2]);
          cube.turn(cs[i][2]);
          cube.turn(cs[i][2]);
          print(order[cs[i][2]] + "', ");
        }
        break;
      }
      cube.turn(5);
    }
  }
}

public void middleLayer() {
  int[][] es = {{4, 1}, {3, 4}, {2, 3}, {1, 2}};
  for (int i = 0; i < 4; i++) {
    int id = findEdge(cube.edges, new Edge(es[i][0], es[i][1]));
    if (id < 8) {
      cube.turn(8 - id);
      print(order[8 - id] + ", ");
      cube.turn(5);
      print("y, ");
      cube.turn(8 - id);
      cube.turn(8 - id);
      cube.turn(8 - id);
      print(order[8 - id] + "', ");
      cube.turn(5);
      cube.turn(5);
      cube.turn(5);
      print("'y, ");
      cube.turn((8 - id) % 4 + 1);
      cube.turn((8 - id) % 4 + 1);
      cube.turn((8 - id) % 4 + 1);
      print(order[(8 - id) % 4 + 1] + "', ");
      cube.turn(5);
      cube.turn(5);
      cube.turn(5);
      print("'y, ");
      cube.turn((8 - id) % 4 + 1);
      print(order[(8 - id) % 4 + 1] + ", ");
    }
    for (int j = 0; j < 4; j++) {
      id = findEdge(cube.edges, new Edge(es[i][0], es[i][1]));
      if (cube.edges[id].getFaces()[(cube.edges[id].orient + 1) % 2] == 12 - id) {
        if (j == 1) {
          print("y, ");
        } else if (j == 2) {
          print("2y, ");
        } else if (j == 3) {
          print("'y, ");
        }
        int top = cube.edges[id].getFaces()[cube.edges[id].orient];
        if (12 - id == es[i][0]) {
          cube.turn(5);
          cube.turn(5);
          cube.turn(5);
          print("'y, ");
          cube.turn(top);
          cube.turn(top);
          cube.turn(top);
          print(order[top] + "', ");
          cube.turn(5);
          print("y, ");
          cube.turn(top);
          print(order[top] + ", ");
          cube.turn(5);
          print("y, ");
          cube.turn(12 - id);
          print(order[12 - id] + ", ");
          cube.turn(5);
          cube.turn(5);
          cube.turn(5);
          print("'y, ");
          cube.turn(12 - id);
          cube.turn(12 - id);
          cube.turn(12 - id);
          print(order[12 - id] + "', ");
        } else {
          cube.turn(5);
          print("y, ");
          cube.turn(top);
          print(order[top] + ", ");
          cube.turn(5);
          cube.turn(5);
          cube.turn(5);
          print("'y, ");
          cube.turn(top);
          cube.turn(top);
          cube.turn(top);
          print(order[top] + "', ");
          cube.turn(5);
          cube.turn(5);
          cube.turn(5);
          print("'y, ");
          cube.turn(12 - id);
          cube.turn(12 - id);
          cube.turn(12 - id);
          print(order[12 - id] + "', ");
          cube.turn(5);
          print("y, ");
          cube.turn(12 - id);  
          print(order[12 - id] + ", ");
        }
        break;
      }
      cube.turn(5);
    }
  }
}

public void bottomCross() {
  int p = pattern();
  String[] face = cube.yellowFace();
  while (p < 3){
    if (p == 1) {
      for (int i = 0; i < 4; i++) {
        face = cube.yellowFace();
        if (face[2].charAt(2) == '5' && face[1].charAt(4) == '5'){
          break;
        }
        cube.turn(5);
        print("y, ");
      }
    } else if (p == 2) {
      for (int i = 0; i < 4; i++) {
        face = cube.yellowFace();
        if (face[1].charAt(0) == '5' && face[1].charAt(4) == '5'){
          break;
        }
        cube.turn(5);
        print("y, ");
      }
    }
    cube.turn(2);
    cube.turn(1);
    cube.turn(5);
    cube.turn(1);
    cube.turn(1);
    cube.turn(1);
    cube.turn(5);
    cube.turn(5);
    cube.turn(5);
    cube.turn(2);
    cube.turn(2);
    cube.turn(2);
    print("g, o, y, o', y', g' ");
    p++;
  }
  
  int correctPos = 0;
  int[] pos = new int[4];
  for (int i = 0; i < 4; i++) {
    correctPos = 0;
    if (findEdge(cube.edges, new Edge(4, 5)) == 8) {
      pos[correctPos] = 8;
      correctPos++;
    }
    if (findEdge(cube.edges, new Edge(3, 5)) == 9) {
      pos[correctPos] = 9;
      correctPos++;
    }
    if (findEdge(cube.edges, new Edge(2, 5)) == 10) {
      pos[correctPos] = 10;
      correctPos++;
    }
    if (findEdge(cube.edges, new Edge(1, 5)) == 11) {
      pos[correctPos] = 11;
      correctPos++;
    }
    if (correctPos >= 2) {
      break;
    }
    cube.turn(5);
    print("y, ");
  }
  if (correctPos == 2) {
    if ((pos[0] + pos[1]) % 2 == 0) {
      cube.turn(2);
      cube.turn(5);
      cube.turn(2);
      cube.turn(2);
      cube.turn(2);
      cube.turn(5);
      cube.turn(2);
      cube.turn(5);
      cube.turn(5);
      cube.turn(2);
      cube.turn(2);
      cube.turn(2);
      print("g, y, g', y, g, 2y, g' ");
    }
    while ((cube.edges[11].getFaces()[(cube.edges[11].orient + 1) %2]) % 4 + 1 != cube.edges[10].getFaces()[(cube.edges[10].orient + 1) %2]) {
      cube.turn(5);
    }
    cube.turn(2);
    cube.turn(5);
    cube.turn(2);
    cube.turn(2);
    cube.turn(2);
    cube.turn(5);
    cube.turn(2);
    cube.turn(5);
    cube.turn(5);
    cube.turn(2);
    cube.turn(2);
    cube.turn(2);
    print("g, y, g', y, g, 2y, g' ");
  }
  while (findEdge(cube.edges, new Edge(4, 5)) != 8) {
    cube.turn(5);
    print("y, ");
  }
}

public void bottomCorners() {
  int[] correctCorner = new int[4];
  int count = 0;
  while (count != 4) {
    count = 0;
    if (findCorner(cube.corners, new Corner (5, 1, 4)) == 4) {
      correctCorner[count] = 4;
      count++;
    }
    if (findCorner(cube.corners, new Corner (5, 4, 3)) == 5) {
      correctCorner[count] = 5;
      count++;
    }
    if (findCorner(cube.corners, new Corner (5, 3, 2)) == 6) {
      correctCorner[count] = 6;
      count++;
    }
    if (findCorner(cube.corners, new Corner (5, 2, 1)) == 7) {
      correctCorner[count] = 7;
      count++;
    }

    if (count == 0) {
      correctCorner[count] = 4;
    }
    if (count != 4) {
      cube.turn(5);
      print("y, ");
      cube.turn(8 - correctCorner[0]);
      print(order[8 - correctCorner[0]] + ", ");
      cube.turn(5);
      cube.turn(5);
      cube.turn(5);
      print("y', ");
      cube.turn(((8 - correctCorner[0]) % 4 + 1) % 4 + 1);
      cube.turn(((8 - correctCorner[0]) % 4 + 1) % 4 + 1);
      cube.turn(((8 - correctCorner[0]) % 4 + 1) % 4 + 1);
      print(order[((8 - correctCorner[0]) % 4 + 1) % 4 + 1] + "', ");
      cube.turn(5);
      print("y, ");
      cube.turn(8 - correctCorner[0]);
      cube.turn(8 - correctCorner[0]);
      cube.turn(8 - correctCorner[0]);
      print(order[8 - correctCorner[0]] + "', ");
      cube.turn(5);
      cube.turn(5);
      cube.turn(5);
      print("y', ");
      cube.turn(((8 - correctCorner[0]) % 4 + 1) % 4 + 1);
      print(order[((8 - correctCorner[0]) % 4 + 1) % 4 + 1] + ", ");
    }
  }
  
  for (int i = 0; i < 4; i++) {
    while (cube.corners[6].getFaces()[cube.corners[6].getOrient()] != 5) {
      cube.turn(2);
      cube.turn(2);
      cube.turn(2);
      cube.turn(0);
      cube.turn(0);
      cube.turn(0);
      cube.turn(2);
      cube.turn(0);
      print("g', w', g, w, ");
    }
    cube.turn(5);
    print("y, ");
  }
}
  
  
public int findCorner(Corner[] cs, Corner c) {
  int[] fs = c.getFaces();
  fs = sort(fs);
  for (int i = 0; i < 8; i++) {
    int[] temp = sort(cs[i].getFaces());
    for (int j = 0; j < 3; j++) {
      if (temp[j] != fs[j]) {
        break;
      }
      if (j == 2) {
        return i;
      }
    }
  }  
  return -1;
}

public int findEdge(Edge[] es, Edge e) {
  int[] fs = e.getFaces();
  fs = sort(fs);
  for (int i = 0; i < 12; i++) {
    int[] temp = sort(es[i].getFaces());
    for (int j = 0; j < 2; j++) {
      if (temp[j] != fs[j]) {
        break;
      }
      if (j ==  1) {
        return i;
      }
    }
  }
  return -1;
}

public int pattern() {
  // 0 = only middle, 1 = L, 2 = line, 3 = cross
  String[] face = cube.yellowFace();
  int count = 0;
  int[][] pos = {{0, 2}, {1, 0}, {1, 4}, {2, 2}};
  
  for (int i = 0; i < 4; i++) {
    if (face[pos[i][0]].charAt(pos[i][1]) == '5') {
      count++;
    }
  }
  if (count == 0) {
    return 0;
  }
  if (count == 2) {
    if ((face[1].charAt(0) == '5' && face[1].charAt(4) == '5') ||
    (face[1].charAt(0) != '5' && face[1].charAt(4) != '5')) {
      return 2;
    }
    return 1;
  }
  return 3;
}
