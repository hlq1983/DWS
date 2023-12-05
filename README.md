# IRREGULAR OCEAN WAVES SIMULATIONS USING A DIRECTIONAL WAVE ENERGY SPECTRUM
DWS (Directional Wave Simulation) numerically simulates the time series of the irregular wave at different locations in the ocean based upon 
a directional wave energy spectrum. That is, based upon a 2-dimensional table with spectral variance versus frequencies and direction angles, 
we want to calculate the time series of the surface elevation, the horizontal velocity, the vertical velocity, the horizontal acceleration, 
the vertical acceleration, and the dynamic pressure at different locations (x-, y-, z- coordinates).

In obtaining the harmonic wave components, the Linear Wave Theory (LWT) is employed to calculate the properties of the regular waves. As we know, 
the linear wave theory can only be applied up to the Still Water Level (SWL). However, for structures at the free surface, the waves above the SWL 
may have a large influence on the response of the structure and may not be ignored. If linear theory is used, the theory is modified to account for 
the Free Surface Effect. There are several possible modifications that have been proposed, such as First-Order Stretching, Linear Extrapolation and 
so on. Wheeler’s Stretching (1970) is the most used First-Order Stretching technique in the offshore structure design.

In calculating the irregular waves, two different models for the wave directionality could be chosen to combine a variety of harmonic wave components, 
one is Single Summation Model (SSM) and the other is Double Summation Model (DSM). For SSM, wave components of different frequencies travel at different 
dictions, but at the same frequency, they travel in the same direction. For DSM, at the same frequency, wave components travel in different directions 
(energy spreading).

## R Package
A R package (“DWS”) has been developed for the purpose of irregular ocean wave simulations using a direction wave energy spectrum, and can be installed as follows:

devtools::install_github("hlq1983/DWS")

