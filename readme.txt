This folder contains the examples of the type of OpenFOAM simulation conditions used in the numerical validation part of 
the paper "Transient heat transfer in fibrous multi-scale composites: A semi-analytical model and its
numerical validation", published in Numerical Heat Transfer, Part A: Applications. The associated MATLAB codes for the
semi-analytical model are available on the MATLAB Central File Exchange at:

https://www.mathworks.com/matlabcentral/fileexchange/82013-transient-heat-transfer-in-fibrous-multi-scale-composites

This work was carried out with support from Grant Award Number 090118FD5313 
under the “Structure-Property Correlations in Multi-Scale Composites” 
project at Nazarbayev University. In the context of this project, these codes
are shared online.



%%%%%%%%%%%%%% General Overview %%%%%%%%%%%%%
"MeshExampleWithGMSH.geo" is used to generate the mesh with the open source
meshing program "gmsh". This mesh is imported into OpenFOAM version 5 (blueCFD)
and the transient thermal response is simulated using the "chtMultiRegionFOAM" solver.
The 0/constant/system folders should be familiar to OpenFOAM users. The codes 
can be run in parallel, and the "probes" option allows the user
to track the thermal response in real-time.