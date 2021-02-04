class Solver {
  public Corner[] corners;
  public Edge[] edges;
  
  public Solver() {
    corners = new Corner[8];
    edges = new Edge[12];
  }
  
  public Solver(Corner[] corners, Edge[] edges) {
    corners = new Corner[8];
    edges = new Edge[12];
    for (int i = 0; i < 8; i++) {
      //this.corners[i] = Corner(corners[i]);
    }
    for (int i = 0; i < 12; i++) {
      this.edges[i] = edges[i];
    }
  }
  
  public void topCross() {
    int[][] es = {{0, 1}, {0, 2}, {0, 3}, {0, 4}};
    for (int i = 0; i < 4; i++) {
      int id = findEdge(edges, new Edge(es[i][0], es[i][1]));
      if (id < 4) {
      } else if (id < 8) {
      } else {
      }
    }
  }
  
  public void topCorners() {
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
}
