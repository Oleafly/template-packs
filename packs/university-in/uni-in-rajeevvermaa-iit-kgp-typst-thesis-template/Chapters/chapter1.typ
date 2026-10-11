= Introduction

This chapter introduces the research problem and establishes the context for the thesis work. The focus of this research is the performance improvement and optimization of Type-4 composite pressure vessels through the integration of metaheuristic optimization techniques with a robust computational framework.

== Background

The global shift towards clean energy has positioned hydrogen as a key energy carrier. For mobile applications, storing hydrogen efficiently and safely is paramount. Compressed hydrogen gas storage is currently the most mature technology, and Type-4 composite pressure vessels are the state-of-the-art solution for this purpose. These vessels, which consist of a non-load-bearing polymeric liner fully overwrapped with a carbon-fiber composite, offer a significantly higher strength-to-weight ratio compared to traditional metallic cylinders, enabling higher storage pressures (up to 70 MPa) and thus a longer driving range for vehicles.

However, the design of Type-4 vessels is a complex engineering challenge. Performance is highly dependent on the composite design, which includes parameters like winding angles, layer sequencing, and overall thickness. Furthermore, for hydrogen applications, the choice of liner material is critical to mitigate gas permeation and meet stringent safety standards like ISO 19881.

== Objectives

The specific objectives of this research are:

1.  To develop a robust computational framework for the structural analysis of Type-4 composite pressure vessels using Classical Lamination Theory (CLT).
2.  To implement and compare multiple metaheuristic optimization algorithms—specifically Genetic Algorithm (GA), Particle Swarm Optimization (PSO), Simulated Annealing (SA), and Hybrid PSO-SA—to solve the laminate stacking sequence problem.
3.  To determine the theoretical performance limits of the vessel by conducting both *Discrete* (manufacturable) and *Continuous* (theoretical) optimization studies.
4.  To perform a *Topological Weight Minimization* study to identify the minimum number of plies required to meet a specific safety factor.
5.  To develop a comprehensive *Software Platform (GUI)* that automates the design, analysis, and optimization workflow, making advanced laminate design accessible.
6.  To establish a theoretical understanding of standard *Experimental Characterization* protocols (e.g., NOL Ring Test) to validate the material properties used in the simulation.
