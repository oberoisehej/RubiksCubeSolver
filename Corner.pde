class Corner {

    public int orient;
    public int[] faces;

    public Corner() {
        faces = new int[3];
        orient = 0;
    }

    public Corner(int c1, int c2, int c3) {
        faces = new int[] {c1, c2, c3};
        orient = 0;
    }

    public Corner(Corner c) {
        faces = new int[3];
        this.setFaces(c.getFaces());
        this.orient = c.getOrient();
    }

    public void setFaces (int[] faces) {
        this.faces[0] = faces[0];
        this.faces[1] = faces[1];
        this.faces[2] = faces[2];
    }

    public int[] getFaces() {
        return faces;
    }

    public void setOrient(int orient) {
        this.orient = orient;
    }

    public int getOrient() {
        return orient;
    }

    public void incOrient(int n) {
        orient += n;
        orient = orient % 3;
    }
}
