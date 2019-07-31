void setup() {
  size(360, 360, P2D);
  background(255);
}

int[][] wireframe = {
  { -18, 0, 40 }, //  0
  { 18, 0, 40 }, //  1
  { 30, 0, -24 }, //  2
  { 30, 0, -40 }, //  3
  { 18, -7, -40 }, //  4
  { -18, -7, -40 }, //  5
  { -30, 0, -40 }, //  6
  { -30, 0, -24 }, //  7
  { -18, 7, -40 }, //  8
  { 18, 7, -40 }, //  9
  { -18, 7, 13 }, //  10
  { 18, 7, 13 }, //  11
  { -18, -7, 13 }, //  12
  { 18, -7, 13 }, //  13
  { -11, 3, 29 }, //  14
  { 11, 3, 29 }, //  15
  { 11, 4, 24 }, //  16
  { -11, 4, 24 },  //  17
  { 11, 4, 24 }, //  18
  { -11, 4, 24 }  //  19
};

int ship_vertices_cnt = 20;
int ship_scale = 2;
int[][] ship_vertices = {
  { 32, -48, 48 }, //  0
  { 32, -68, 0 }, //  1
  { 32, -48, -48 }, //  2
  { 32, 0, -68 }, //  3
  { 32, 48, -48 }, //  4
  { 32, 68, 0 }, //  5
  { 32, 48, 48 }, //  6
  { 32, 0, 68 }, //  7
  { -24, -116, 116 }, //  8
  { -24, -164, 0 }, //  9
  { -24, -116, -116 }, //  10
  { -24, 0, -164 }, //  11
  { -24, 116, -116 }, //  12
  { -24, 164, 0 }, //  13
  { -24, 116, 116 }, //  14
  { -24, 0, 164 }, //  15
  { -24, 64, 80 }, //  16
  { -24, 64, -80 }, //  17
  { -24, -64, -80 }, //  18
  { -24, -64, 80 }  //  19
};

int ship_faces_cnt = 10;
int[][] ship_faces = {
{ 4, 9, 8, 0, 1, 0, 0, 0, 0 },  //  0
{ 4, 10, 9, 1, 2, 0, 0, 0, 0 },  //  1
{ 4, 11, 10, 2, 3, 0, 0, 0, 0 },  //  2
{ 4, 12, 11, 3, 4, 0, 0, 0, 0 },  //  3
{ 8, 7, 6, 5, 4, 3, 2, 1, 0 },  //  4
{ 4, 13, 12, 4, 5, 0, 0, 0, 0 },  //  5
{ 4, 14, 13, 5, 6, 0, 0, 0, 0 },  //  6
{ 4, 15, 14, 6, 7, 0, 0, 0, 0 },  //  7
{ 4, 15, 7, 0, 8, 0, 0, 0, 0 },  //  8
{ 8, 8, 9, 10, 11, 12, 13, 14, 15 }  //  9
};

float rot, rotx, roty, rotz, rotxx, rotyy, rotzz, rotxxx, rotyyy, rotzzz;
int i; //0 to 360
int fl, scale; //focal length

int originx = 180;
int originy = 180;
int angle =0 ;
int front_depth = 20;
int back_depth = -20;

float vector;

int fd = 0; //0=orthographic

float scalefactor = 0;

void draw_wireframe_ship()
{

  int face, f_line, wf_f_1, wf_f_2;
  stroke(255);
  noFill();
  for ( face = 0; face < ship_faces_cnt; face++) {
    vector = 0;
    for ( f_line = 1; f_line < ship_faces[face][0]; f_line++) {
      wf_f_1 = ship_faces[face][f_line];
      wf_f_2 = ship_faces[face][f_line + 1];
      vector += wireframe[wf_f_1][0] * wireframe[wf_f_2][1] - wireframe[wf_f_1][1] * wireframe[wf_f_2][0];
    };
    wf_f_1 = ship_faces[face][f_line];
    wf_f_2 = ship_faces[face][1];
    vector += wireframe[wf_f_1][0] * wireframe[wf_f_2][1] - wireframe[wf_f_1][1] * wireframe[wf_f_2][0];
    //vector = 1;
    noFill();
    if ( vector >= 0 /* && face == 1 */ ) {
      if (face == 8) {
        fill(128);
      }

      beginShape();
      for ( f_line = 1; f_line <= ship_faces[face][0]; f_line++) {
        //wf_f_1 = ship_faces[face][f_line];
        //wf_f_2 = ship_faces[face][f_line + 1];
        //line(wireframe[wf_f_1][0], wireframe[wf_f_1][1], wireframe[wf_f_2][0], wireframe[wf_f_2][1]);
        vertex(wireframe[ship_faces[face][f_line]][0], wireframe[ship_faces[face][f_line]][1]);
      }
      vertex(wireframe[ship_faces[face][1]][0], wireframe[ship_faces[face][1]][1]);
      endShape();
    }
    //wf_f_1 = ship_faces[face][f_line];
    //wf_f_2 = ship_faces[face][1];
    //line(wireframe[wf_f_1][0], wireframe[wf_f_1][1], wireframe[wf_f_2][0], wireframe[wf_f_2][1]);
  }
};

void draw() {
  scalefactor = 1;
  scale = 2 ;
  //for (int angle = 0; angle <= 360; angle = angle + 3) {

  angle = mouseX;
  //angleY= mouseY;
  for (int i = 0; i < ship_vertices_cnt; i++) {
    rot = angle * 0.0174532; //0.0174532 = one degree
    //rotateY
    rotz = ship_vertices[i][2] / scale * cos(rot) - ship_vertices[i][0] / scale * sin(rot);
    rotx = ship_vertices[i][2] / scale * sin(rot) + ship_vertices[i][0] / scale * cos(rot);
    roty = ship_vertices[i][1] / scale;
    //rotateX
    rotyy = roty * cos(rot) - rotz * sin(rot);
    rotzz = roty * sin(rot) + rotz * cos(rot);
    rotxx = rotx;
    //rotateZ
    rotxxx = rotxx * cos(rot) - rotyy * sin(rot);
    rotyyy = rotxx * sin(rot) + rotyy * cos(rot);
    rotzzz = rotzz;

    //orthographic projection
    rotxxx = rotxxx + originx;
    rotyyy = rotyyy + originy;
    //rotxxx = rotxxx * scalefactor + originx;
    //rotyyy = rotyyy * scalefactor + originy;

    //store new vertices values for wireframe drawing
    wireframe[i][0] = int(rotxxx);
    wireframe[i][1] = int(rotyyy);
    wireframe[i][2] = int(rotzzz);
  }
  background(0);

  draw_wireframe_ship();
  if (scalefactor < 1) scalefactor = scalefactor + 0.02;
  delay(100);
  //}
}
