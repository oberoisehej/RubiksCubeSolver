class Edge {
    public int orient;
    public int[] faces;

    Edge () {
        orient = 0;
        faces = new int[2];
    }

    public Edge (int c1, int c2) {
        orient = 0;
        faces = new int[] {c1, c2};
    }

    public Edge (Edge e) {
        faces = new int[2];
        this.setFaces(e.getFaces());
        this.setOrient(e.getOrient());
    }

    public int getOrient() {
        return orient;
    }

    public void setOrient(int orient) {
        this.orient = orient;
    }

    public int[] getFaces() {
        return faces;
    }

    public void setFaces(int[] faces) {
        this.faces[0] = faces[0];
        this.faces[1] = faces[1];
    }

    public void incOrient() {
        orient++;
        orient = orient % 2;
    }
}
