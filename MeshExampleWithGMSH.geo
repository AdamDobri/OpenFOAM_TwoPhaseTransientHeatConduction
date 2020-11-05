// This geo file is used with gmsh to generate the mesh for a rectangle
// comprised of a matrix phase with cylinders/fibres embedded in it. The meshes
// are used for 2D OpenFOAM (v4 or v5) Simulations of two-phase heat transfer

// Author: Dr. Adam Dobri, Nazarbayev University, Kazakhstan

//         The general steps of the program are:
//    1) define all the circles that will form the bases of the cylinders. There
//       are three kinds of circles, completely inside the matrix, bisected by
//       the upper boundary and bisected by the lower boudarry
//    2) define the overall (matrix) domain, perform boolean operations to 
//       remove the appropriate parts of the matrix
//    3) perform extursion, as OpenFOAM requires a 3D mesh
//    4) Define the physical volumes and surfaces. This program makes use of the
//       order in which gmsh names surfaces. Other methods exist.
//    5) Export .msh file "version 2 ascii" and uncheck the save all elements (done manually after reviewing the mesh in gmsh)

// This work was carried out with support from Grant Award Number 090118FD5313 
// under the “Structure-Property Correlations in Multi-Scale Composites” 
// project at Nazarbayev University. In the context of this project, these codes
// are shared online.


SetFactory("OpenCASCADE");

//------------------------------ Geometric Parameters -------------------------

N = 70;        // number of cylinders inside the domain
Nt = 2;       // number of cylinders centered from Y-R to Y
Nb = 7;       // number of cylinders centered from 0 to R
Nr = 1;      // number on right side
R = 10e-6;    // cylinder radius


X = 0.005;       // size of domain in x-direction
Y = 100e-6;       // size of domain in y-direction
ZDepth = 200e-6;  // depth of simulation in z-direction (single mesh layer)

//------------------------------ Mesh Characteristics -------------------------
LC          =   20e-6;           // Characterisitc length (along out box)
LCmin       =   R/3;          // Characterisitc length in cylinders
DecayStart  =   1.5*R;   // Distance where mesh size starts increasing
DecayEnd    =   3*R;       // Distance where mesh size reaches CL

//------------------------------ Positions ------------------------------------

// the X and Y co-ordinates of the cylinders contained entirely within domain
x = {0.0025	,
0.001	,
0.001597	,
0.001923	,
0.001689	,
0.00291	,
0.002671	,
0.004605	,
0.004401	,
0.003684	,
0.000685	,
0.001197	,
0.002161	,
0.003755	,
0.002549	,
0.004049	,
0.001438	,
0.002224	,
0.001945	,
0.000438	,
0.004615	,
0.003084	,
0.004912	,
0.004794	,
0.003828	,
0.000293	,
0.002376	,
0.001873	,
0.00154	,
0.001088	,
0.003193	,
5.10E-05	,
0.001776	,
0.000637	,
0.002615	,
0.004146	,
0.00052	,
0.003715	,
0.003998	,
0.00316	,
0.00148	,
0.002791	,
0.004242	,
0.002762	,
0.001633	,
0.000917	,
0.0045	,
0.002558	,
0.00432	,
0.000741	,
0.000981	,
0.001321	,
0.003625	,
0.002863	,
0.001847	,
0.001642	,
0.00105	,
0.000387	,
0.002714	,
0.001734	,
0.000108	,
0.002994	,
0.004065	,
0.001256	,
0.001267	,
0.00326	,
0.004202	,
0.003327	,
0.001531	,
0.004437
};

y = {5.00E-05	,
5.00E-05	,
2.50E-05	,
2.90E-05	,
4.10E-05	,
5.00E-05	,
2.00E-05	,
7.50E-05	,
4.70E-05	,
2.90E-05	,
8.60E-05	,
8.10E-05	,
4.20E-05	,
8.10E-05	,
3.30E-05	,
8.50E-05	,
1.10E-05	,
7.10E-05	,
7.80E-05	,
5.70E-05	,
1.60E-05	,
3.70E-05	,
6.50E-05	,
8.60E-05	,
5.70E-05	,
7.90E-05	,
4.40E-05	,
2.10E-05	,
1.20E-05	,
3.40E-05	,
6.10E-05	,
1.80E-05	,
2.80E-05	,
4.70E-05	,
3.50E-05	,
8.50E-05	,
5.70E-05	,
6.80E-05	,
1.10E-05	,
8.70E-05	,
2.70E-05	,
8.20E-05	,
6.90E-05	,
5.30E-05	,
7.20E-05	,
8.30E-05	,
5.20E-05	,
7.20E-05	,
6.50E-05	,
6.40E-05	,
8.80E-05	,
4.50E-05	,
4.00E-05	,
3.80E-05	,
7.20E-05	,
2.40E-05	,
7.30E-05	,
2.20E-05	,
4.70E-05	,
5.40E-05	,
7.60E-05	,
3.40E-05	,
4.00E-05	,
8.10E-05	,
4.10E-05	,
8.80E-05	,
5.90E-05	,
3.90E-05	,
5.50E-05	,
8.60E-05};
    
// the X and Y co-ordinates to define all the cylinders cut by the top boundary
xT = {0.002384,
0.003364};

yT = {9.30E-05,
9.40E-05};

// the X and Y co-ordinates to define all the cylinders cut by the bottom boundary
xB = {0.001728,
0.003201,
0.000783,
0.001316,
0.004377,
0.003447,
0.002059
};

yB = {6.00E-06,
5.00E-06,
5.00E-06,
5.00E-06,
5.00E-06,
8.00E-06,
8.00E-06
};

      
// Define the index lists for all the surfaces and points
PointIndex[] = {};
CircleIndex[] = {};       // completely in the X-Y simulation domain
PointIndex_T[] = {};      
CircleIndex_T[] = {};     // lower part of the cylinders along the top
PointIndex_Ts[] = {};
CircleIndex_Ts[] = {};    // upper part of the top cylinders, entering from Y = 0
PointIndex_B[] = {};
CircleIndex_B[] = {};     // upper part of the cylinders alond the bottom
PointIndex_Bs[] = {};
CircleIndex_Bs[] = {};    // lower part of the bottom culinders, entering from Y = Y
PointIndex_R[] = {};
CircleIndex_R[] = {};    // right side


//------------------------- Defining the 2D Geometry---------------------------

// Loop to define all the cylinders completely inside the domain
For t In {1:N}
  L  = newl;
  Circle(L) = {x[t-1], y[t-1], 0, R, 0, 2*Pi}; // Defines the circle
  Curve Loop(L) = {L};
  Plane Surface(L) = {L};
  CircleIndex[] += L;
  p  = newp;
  Point(p) = {x[t-1], y[t-1], 0}; // Defines the circle
  PointIndex[] += p;
  p  = newp;
  Point(p) = {x[t-1], y[t-1]+Y, 0}; // Defines the circle
  PointIndex[] += p;
  p  = newp;
  Point(p) = {x[t-1], y[t-1]-Y, 0}; // Defines the circle
  PointIndex[] += p;
EndFor

// Loop to define all the cylinders cut by the top boundary
For t In {1:Nt}
  L  = newl;
  Circle(L) = {xT[t-1], yT[t-1], 0, R, 0, 2*Pi}; // Defines the circle
  Curve Loop(L) = {L};
  Plane Surface(L) = {L};
  CircleIndex_T[] += L;
  p  = newp;
  Point(p) = {xT[t-1], yT[t-1], 0}; // Defines the circle
  PointIndex_T[] += p;
EndFor

// Loop to define all the top cylinders shifted downwards
For t In {1:Nt}
  L  = newl;
  Circle(L) = {xT[t-1], yT[t-1]-Y, 0, R, 0, 2*Pi}; // Defines the circle
  Curve Loop(L) = {L};
  Plane Surface(L) = {L};
  CircleIndex_Ts[] += L;
  p  = newp;
  Point(p) = {xT[t-1], yT[t-1]-Y, 0}; // Defines the circle
  PointIndex_Ts[] += p;
EndFor

// Loop to define all the cylinders cut by the bottom boundary
For t In {1:Nb}
  L  = newl;
  Circle(L) = {xB[t-1], yB[t-1], 0, R, 0, 2*Pi}; // Defines the circle
  Curve Loop(L) = {L};
  Plane Surface(L) = {L};
  CircleIndex_B[] += L;
  p  = newp;
  Point(p) = {xB[t-1], yB[t-1], 0}; // Defines the circle
  PointIndex_B[] += p;
EndFor

// Loop to define all the bottom cylinders shifted upwards
For t In {1:Nb}
  L  = newl;
  Circle(L) = {xB[t-1], yB[t-1]+Y, 0, R, 0, 2*Pi}; // Defines the circle
  Curve Loop(L) = {L};
  Plane Surface(L) = {L};
  CircleIndex_Bs[] += L;
  p  = newp;
  Point(p) = {xB[t-1], yB[t-1]+Y, 0}; // Defines the circle
  PointIndex_Bs[] += p;
EndFor

// cut on RHS
  L  = newl;
  Circle(L) = {X, Y/2, 0, R, 0, 2*Pi}; // Defines the circle
  Curve Loop(L) = {L};
  Plane Surface(L) = {L};
  CircleIndex_R[] += L;
  p  = newp;
  Point(p) = {X, Y/2, 0}; // Defines the circle
  PointIndex_R[] += p;

// Define the overall domain
BL = newp;
Point(BL) = {0, 0, 0, LC};
Point(BL+1) = {X, 0, 0, LC};
Point(BL+2) = {X, Y, 0, LC};
Point(BL+3) = {0, Y, 0, LC};

// simulation domain
L = newl;
Line(L) = {BL,BL+1};
Line(L+1) = {BL+1,BL+2};
Line(L+2) = {BL+2,BL+3};
Line(L+3) = {BL+3,BL};

Curve Loop (L) = {L:L+3};

Plane Surface(L) = {L};

BP = L; // Save Back Plane index

// Cut off the parts of the cylinders that extend past the boundaries
BooleanIntersection{ Surface{BP}; }
    {Surface{ CircleIndex_T[], CircleIndex_Ts[],
              CircleIndex_B[], CircleIndex_Bs[],CircleIndex_R}; Delete; }

// Subtract the cylinders from the matrix
BooleanFragments{ Surface{BP}; Delete; }
    {Surface{ CircleIndex[],
              CircleIndex_T[],CircleIndex_Ts[],
              CircleIndex_B[], CircleIndex_Bs[],CircleIndex_R};}

// Extrude all the layers (matrix and cyclinders) at once
Extrude {0, 0, ZDepth} {Surface{1:(N+2*Nt+2*Nb)+2};Layers{1};Recombine;}

//------------------------- 3D Meshing ----------------------------------------

// Define the meshing parameters
Field[1] = Distance;
Field[1].NodesList = {PointIndex[],PointIndex_Ts[],PointIndex_T[],
                      PointIndex_Bs[],PointIndex_B[],PointIndex_R[]};

Field[2] = Threshold;
Field[2].IField = 1;
Field[2].LcMin = LCmin;
Field[2].LcMax = LC;
Field[2].DistMin = DecayStart;
Field[2].DistMax = DecayEnd;

Background Field = 2;

Mesh 3;

//-------------- Naming Physical Volumes and Surfaces -------------------------

 // Defining the indexes that corrospond to physical surfaces
 // based on the order in which gmsh defines the surfaces
OB = BP+2*N+7*Nt+7*Nb+3;
MRear[]   ={BP};
MLeft[]   ={OB+1};
MTop[]    ={OB+2:OB+2+Nt+Nb};
MRight[]  ={OB+3+Nt+Nb,OB+3+Nt+Nb+1};
MBottom[] ={OB+Nt+Nb+5:OB+2*(Nt+Nb)+5};
MFront[]  ={OB+2*(Nt+Nb)+6};

FRear[]={CircleIndex[],CircleIndex_T[],CircleIndex_Ts[],CircleIndex_B[], CircleIndex_Bs[],CircleIndex_R[]};

FFront[]={};
FTop[]={};
FRight[]={};
FBottom[]={};

Interface[]={};

// Surface indicies for the complete fibres
For t In {1:N}
  Interface[] += BP + 2*t-1; 
  FFront[]    += BP + 2*t;
EndFor

// Surface indicies for the fibres cut by the top boundary
For t In {1:Nt}
  FTop[]      += BP + 2*N + 4*t-3; 
  Interface[] += BP + 2*N + 4*t-2; 
  Interface[] += BP + 2*N + 4*t-1;
  FFront[]    += BP + 2*N + 4*t;
EndFor

// Surface indicies for the top fibres, entering from Y = 0
For t In {1:Nt}
  FBottom[]   += BP + 2*N + 4*Nt + 3*t-1; 
  Interface[] += BP + 2*N + 4*Nt + 3*t-2; 
  FFront[]    += BP + 2*N + 4*Nt + 3*t; 
EndFor

// Surface indicies for the fibres cut by the bottom boundary
For t In {1:Nb}
  FBottom[]   += BP + 2*N + 7*Nt + 4*t-1;
  Interface[] += BP + 2*N + 7*Nt + 4*t-3 ;
  Interface[] += BP + 2*N + 7*Nt + 4*t-2 ;
  FFront[]    += BP + 2*N + 7*Nt + 4*t ;
EndFor

// Surface indicies for the bottom fibres, entering from the upper boundary
For t In {1:Nb}
  FTop[]      += BP + 2*N + 7*Nt + 4*Nb + 3*t-2; 
  Interface[] += BP + 2*N + 7*Nt + 4*Nb + 3*t-1; 
  FFront[]    += BP + 2*N + 7*Nt + 4*Nb + 3*t; 
EndFor

// Surface indicies for the right hand side

Interface[]   += BP + 2*N + 7*Nt + 4*Nb + 3*Nb + 1;
FRight[]      += BP + 2*N + 7*Nt + 4*Nb + 3*Nb + 2;
FFront[]      += BP + 2*N + 7*Nt + 4*Nb + 3*Nb + 3;

Printf("BackPlane = ",BP[]);
Printf("CircleIndex = ",CircleIndex[]);
Printf("CircleIndex_T= ",CircleIndex_T[]);
Printf("CircleIndex_Ts= ",CircleIndex_Ts[]);
Printf("CircleIndex_B= ",CircleIndex_B[]);
Printf("CircleIndex_Bs= ",CircleIndex_Bs[]);
Printf("FFront= ",FFront[]);


Printf("LC, um = ",1e6*LC[]);
Printf("LCmin , um = ",1e6*LCmin[]);

// Naming the physical surfaces

Physical Surface("matrixLeft") = MLeft[];
Physical Surface("matrixRight") = MRight[];
Physical Surface("matrixFront") = MFront[];
Physical Surface("matrixRear") = MRear[];
Physical Surface("matrixTop") = MTop[];
Physical Surface("matrixBottom") = MBottom[];

Physical Surface("fibresFront") = FFront[];
Physical Surface("fibresRear") = FRear[];
Physical Surface("fibresRight") = FRight[] ;
Physical Surface("fibresTop") = FTop[];
Physical Surface("fibresBottom") = FBottom[];

 
Physical Surface("interface") = Interface[];
  
Physical Volume("matrix")={L};
Physical Volume("fibres")={1:(N+2*Nt+2*Nb)+1};
