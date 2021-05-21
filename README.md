# cits4402-facial-recognition


#### CITS4402 - Group 34
- Autumn Brough (21970498)
- Michael Stone (17638566)
- Jason Veljanoski (21980294) 

GUI to demonstrate the facial recognition algorithm defined in "Linear Regression for Face Recognition". Full dataset should be added to FaceDataset folder before running. 

## 1. Approach followed and data partition

Algorithm outline:

1. Start with a set of face classes, each with a set of training images, and a probe (test) image to classify (y)
2. Downsample every image, e.g. to 10*5 or 15*15 pixels, and represent as a single-column vector
3. For each class, represent the training set as a matrix of all training images (X)
4. That matrix (the set of training image vectors) represents a subspace of the total image space. The goal is to find a point (y hat) within the subspace that is optimally close to y.
5. This is given by the formula: y hat = X . ( X transpose . X )^-1 . X transpose . y
6. For each class (and corresponding subspace), calculate y hat and use the sum of squares metric to find its distance from y. The class that minimises this distance is used as the prediction.

## 2. GUI Display

<img src="/img/gui.png" alt="gui" style="zoom:50%;" />


1. Input image display
2. Predicted match display
3. Select partition method (Middle Split, Interleave, 70/30, 30/70, Lightweight)
4. Load Image
5. Train
6. Test

## 3. Directory contents

- Face_Detection.m and Face_Detection.fig are the MATLAB code and GUI file that implement the project.
- FaceDataset/ contains the full dataset of face images
- TestingDataset/ and TrainingDataset/ hold the test and train datasets, populated with copies from FaceDataset by Face_Detection.m

- README.md is this explanatory readme!
- img/ holds source images
- project-description/ includes a reference of all files provided as part of the project definition

- Face_Detection_Accuracy.m is a supplementary script that was used run the face detection algorithm against every file in TestingDataset, for accuracy calculations
- accuracy_testing.txt contains output of accuracy testing



##  4. Usage

1. Choose a data partition from the dropdown menu. There are two 50/50 splits, two 70/30 splits, and one 20/80 split.
2. Click "Train On Image Gallery" to produce a trained model
3. Click "Load Image" and navigate to an image to be tested. Image must be a 92*112 black-and-white pgm image
4. Click "Test face" and the detector will compare the test image to all classes, and make a prediction of nearest match


##  5. Result Discussion 







