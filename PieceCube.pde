class PieceCube {
    public Corner[] corners;
    public Edge[] edges;

    public PieceCube() {
        corners = new Corner[8];
        edges = new Edge[12];
    }

    //corners = {(w, b, o), (w, r, b), (w, g, r), (w, o, g), (y, o, b), (y, b, r), (y, r, g), (y, g, o)}
    //edges = {(w, b), (w, r), (w, g), (w, o), (b, o), (b, r), (g, r), (g, o), (y, b), (y, r), (y, g), (y, o)}


    public void addCorner(Corner corner, int pos) {
        corners[pos] = corner;
    }

    public void addEdge(Edge edge, int pos) {
        edges[pos] = edge;
    }

    public String[] whiteFace() {
        String[] rows = new String[3];
        String face = "";
        face += corners[0].faces[corners[0].orient] + " ";
        face += edges[0].faces[edges[0].orient] + " ";
        face += corners[1].faces[corners[1].orient];
        rows[0] = face;
        face = "";
        face += edges[3].faces[edges[3].orient] + " ";
        face += "0 ";
        face += edges[1].faces[edges[1].orient];
        rows[1] = face;
        face = "";
        face += corners[3].faces[corners[3].orient] + " ";
        face += edges[2].faces[edges[2].orient] + " ";
        face += corners[2].faces[corners[2].orient];
        rows[2] = face;
        return rows;
    }

    public String[] yellowFace() {
        String[] rows = new String[3];
        String face = "";
        face += corners[7].faces[corners[7].orient] + " ";
        face += edges[10].faces[edges[10].orient] + " ";
        face += corners[6].faces[corners[6].orient];
        rows[0] = face;
        face = "";
        face += edges[11].faces[edges[11].orient] + " ";
        face += "5 ";
        face += edges[9].faces[edges[9].orient];
        rows[1] = face;
        face = "";
        face += corners[4].faces[corners[4].orient] + " ";
        face += edges[8].faces[edges[8].orient] + " ";
        face += corners[5].faces[corners[5].orient];
        rows[2] = face;
        return rows;
    }

    public String[] redFace() {
        String[] rows = new String[3];
        String face = "";
        face += corners[2].faces[(corners[2].orient + 2) % 3] + " ";
        face += edges[1].faces[(edges[1].orient + 1) % 2] + " ";
        face += corners[1].faces[(corners[1].orient + 1) % 3];
        rows[0] = face;
        face = "";
        face += edges[6].faces[(edges[6].orient + 1) % 2] + " ";
        face += "3 ";
        face += edges[5].faces[(edges[5].orient + 1) % 2];
        rows[1] = face;
        face = "";
        face += corners[6].faces[(corners[6].orient + 1) % 3] + " ";
        face += edges[9].faces[(edges[9].orient + 1) % 2] + " ";
        face += corners[5].faces[(corners[5].orient + 2) % 3];
        rows[2] = face;
        return rows;
    }

    public String[] orangeFace() {
        String[] rows = new String[3];
        String face = "";
        face += corners[0].faces[(corners[0].orient + 2) % 3] + " ";
        face += edges[3].faces[(edges[3].orient + 1) % 2] + " ";
        face += corners[3].faces[(corners[3].orient + 1) % 3];
        rows[0] = face;
        face = "";
        face += edges[4].faces[(edges[4].orient + 1) % 2] + " ";
        face += "1 ";
        face += edges[7].faces[(edges[7].orient + 1) % 2];
        rows[1] = face;
        face = "";
        face += corners[4].faces[(corners[4].orient + 1) % 3] + " ";
        face += edges[11].faces[(edges[11].orient + 1) % 2] + " ";
        face += corners[7].faces[(corners[7].orient + 2) % 3];
        rows[2] = face;
        return rows;
    }

    public String[] blueFace() {
        String[] rows = new String[3];
        String face = "";
        face += corners[1].faces[(corners[1].orient + 2) % 3] + " ";
        face += edges[0].faces[(edges[0].orient + 1) % 2] + " ";
        face += corners[0].faces[(corners[0].orient + 1) % 3];
        rows[0] = face;
        face = "";
        face += edges[5].faces[edges[5].orient] + " ";
        face += "4 ";
        face += edges[4].faces[edges[4].orient];
        rows[1] = face;
        face = "";
        face += corners[5].faces[(corners[5].orient + 1) % 3] + " ";
        face += edges[8].faces[(edges[8].orient + 1) % 2] + " ";
        face += corners[4].faces[(corners[4].orient + 2) % 3];
        rows[2] = face;
        return rows;
    }

    public String[] greenFace() {
        String[] rows = new String[3];
        String face = "";
        face += corners[3].faces[(corners[3].orient + 2) % 3] + " ";
        face += edges[2].faces[(edges[2].orient + 1) % 2] + " ";
        face += corners[2].faces[(corners[2].orient + 1) % 3];
        rows[0] = face;
        face = "";
        face += edges[7].faces[edges[7].orient] + " ";
        face += "2 ";
        face += edges[6].faces[edges[6].orient];
        rows[1] = face;
        face = "";
        face += corners[7].faces[(corners[7].orient + 1) % 3] + " ";
        face += edges[10].faces[(edges[10].orient + 1) % 2] + " ";
        face += corners[6].faces[(corners[6].orient + 2) % 3];
        rows[2] = face;
        return rows;
    }

    @Override
    public String toString() {
        String cube = "";
        String[] w = whiteFace();
        String[] g = greenFace();
        String[] r = redFace();
        String[] o = orangeFace();
        String[] b = blueFace();
        String[] y = yellowFace();

        cube += "       " + w[0] + "\n       " + w[1] + "\n       " + w[2] + "\n\n";
        cube += o[0] + "  " + g[0] + "  " + r[0] + "  " + b[0] + "\n";
        cube += o[1] + "  " + g[1] + "  " + r[1] + "  " + b[1] + "\n";
        cube += o[2] + "  " + g[2] + "  " + r[2] + "  " + b[2] + "\n\n";
        cube += "       " + y[0] + "\n       " + y[1] + "\n       " + y[2];
        return cube;
    }

    public void turn(int face) {
        Edge tempE;
        Corner tempC;
        switch (face) {
            case 0: tempC = new Corner(corners[0]);
                corners[0] = new Corner(corners[3]);
                corners[3] = new Corner(corners[2]);
                corners[2] = new Corner(corners[1]);
                corners[1] = new Corner(tempC);
                tempE = new Edge(edges[0]);
                edges[0] = new Edge(edges[3]);
                edges[3] = new Edge(edges[2]);
                edges[2] = new Edge(edges[1]);
                edges[1] = new Edge(tempE);
                break;
            case 5: tempC = new Corner(corners[4]);
                corners[4] = new Corner(corners[5]);
                corners[5] = new Corner(corners[6]);
                corners[6] = new Corner(corners[7]);
                corners[7] = new Corner(tempC);
                tempE = new Edge(edges[8]);
                edges[8] = new Edge(edges[9]);
                edges[9] = new Edge(edges[10]);
                edges[10] = new Edge(edges[11]);
                edges[11] = new Edge(tempE);
                break;
            case 4:
                tempC = new Corner(corners[0]);
                corners[0] = new Corner(corners[1]);
                corners[0].incOrient(1);
                corners[1] = new Corner(corners[5]);
                corners[1].incOrient(2);
                corners[5] = new Corner(corners[4]);
                corners[5].incOrient(1);
                corners[4] = new Corner(tempC);
                corners[4].incOrient(2);
                tempE = new Edge(edges[0]);
                edges[0] = new Edge(edges[5]);
                edges[0].incOrient();
                edges[5] = new Edge(edges[8]);
                edges[5].incOrient();
                edges[8] = new Edge(edges[4]);
                edges[8].incOrient();
                edges[4] = new Edge(tempE);
                edges[4].incOrient();
                break;
            case 2:
                tempC = new Corner(corners[3]);
                corners[3] = new Corner(corners[7]);
                corners[3].incOrient(2);
                corners[7] = new Corner(corners[6]);
                corners[7].incOrient(1);
                corners[6] = new Corner(corners[2]);
                corners[6].incOrient(2);
                corners[2] = new Corner(tempC);
                corners[2].incOrient(1);
                tempE = new Edge(edges[2]);
                edges[2] = new Edge(edges[7]);
                edges[2].incOrient();
                edges[7] = new Edge(edges[10]);
                edges[7].incOrient();
                edges[10] = new Edge(edges[6]);
                edges[10].incOrient();
                edges[6] = new Edge(tempE);
                edges[6].incOrient();
                break;
            case 3:
                tempC = new Corner(corners[2]);
                corners[2] = new Corner(corners[6]);
                corners[2].incOrient(2);
                corners[6] = new Corner(corners[5]);
                corners[6].incOrient(1);
                corners[5] = new Corner(corners[1]);
                corners[5].incOrient(2);
                corners[1] = new Corner(tempC);
                corners[1].incOrient(1);
                tempE = new Edge(edges[1]);
                edges[1] = new Edge(edges[6]);
                edges[6] = new Edge(edges[9]);
                edges[9] = new Edge(edges[5]);
                edges[5] = new Edge(tempE);
                break;
            case 1:
                tempC = new Corner(corners[0]);
                corners[0] = new Corner(corners[4]);
                corners[0].incOrient(2);
                corners[4] = new Corner(corners[7]);
                corners[4].incOrient(1);
                corners[7] = new Corner(corners[3]);
                corners[7].incOrient(2);
                corners[3] = new Corner(tempC);
                corners[3].incOrient(1);
                tempE = new Edge(edges[3]);
                edges[3] = new Edge(edges[4]);
                edges[4] = new Edge(edges[11]);
                edges[11] = new Edge(edges[7]);
                edges[7] = new Edge(tempE);
                break;
        }
    }
}
