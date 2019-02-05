# Digital-Image-Processing
## **experiment 1 Noising & Filtering**
+ Preparation – adding noise to board-orig.bmp:
   + Noise 1: Salt&Pepper (25%)
   + Noise 2: Gauss(20%,m=20,viarance=400)

+ Methods to be developed and tested:
   + Alpha-trimmed mean filter 
   + Adaptive median filter
+ Evaluation of results

## **experiment 2 Canny Edge Detector**
+ Results of my detector
  
  (1) Lena

  ![Lena_origin](experiment2/Lena.jpg "Lena_origin")&emsp;&emsp;
  ![Lena_after](experiment2/Result1.bmp "Lena_after")

  (2) house

  <img src = "experiment2/house.bmp" width = "200" alt = "house_origin">&emsp;&emsp;
  <img src = "experiment2/Result2.bmp" width = "200" alt = "house_origin">

## **experiment 3 Texture Descriptors**
+ Co-occurrence matrix (共生矩阵)
+ 不变矩 $\psi_1$ ~ $\psi_7$

## **Project 1 BMP Loading and Interpolation**
+ Task1:
1) Read and display “Up or Down.bmp” file
2) Write “U” or “D” into this Bmp as your answer
3) Save 2) as an answer.bmp

<img src = "Project-1/answer.bmp" width = "400" alt = "house_origin">

+ Task2:
&emsp;For tsukuba-left.bmp(gray, 8bits/pixels, 384*288 pixels)
1) Bicubic interpolation into 1152*864 pixels
2) Rotate +35 degree

## **Project 3 Filtering in Frequency Domain**
+ Homomorphic Filtering (同态滤波器)
+ DFT and IDFT **myDFT2.m, myIDFT2.m** 
+ Histogram equalization (直方图均衡) **myhisteq.m**

<img src = "Project-3/delighting.bmp" width = "200" alt = "origin">&emsp;&emsp;
<img src = "Project-3/3.bmp" width = "200" alt = "origin">

## **Project 4 Constrained Least Squares Filtering**
+ Task
  
  (1)  Image blurring by Motion Model:
  
  Input：ImageOrg & H, a=0.1, b=0.1 and T=1
  
  Output：ImageBlur
  
  (2)  Constrained Least Squares Filtering
  
  Input：ImageBlur & H, a=0.1, b=0.1 and T=1, you may estimate $σ^2+μ^2$
  
  Output：ImageOrg

+ Result
  
  *Origin Picture*

  <img src = "Project-4/ImageOrg.bmp" width = "200" alt = "origin">

  *Blurred Picture*
  
  <img src = "Project-4/task1.bmp" width = "200" alt = "origin">

  *Recovered Picture*
  
  <img src = "Project-4/task2.bmp" width = "200" alt = "origin">