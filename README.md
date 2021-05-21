# cits4402-facial-recognition


####CITS4402 - Group 34
- Autumn Brough (21970498)
- Michael Stone (17638566)
- Jason Veljanoski (21980294) 

GUI to demonstrate the facial recognition algorithm defined in "Linear
Regression for Face Recognition". Full dataset should be added to
FaceDataset folder before running. 

# 1. Approach followed and data partition

# 2. GUI Display

<img src="/img/gui.png" alt="gui" style="zoom:50%;" />


1. Input image display
2. Predicted match display
3. Select partition method (Middle Split, Interleave, 70/30, 30/70, Lightweight)
4. Load Image
5. Train
6. Test



# 3. What is in the GIT

- Face_Detection.m and Face_Detection.fig are the MATLAB code and GUI file that implement the project.
- FaceDataset/, containing the full dataset of face images
- TestingDataset/ and TrainingDataset/ hold the test and train datasets, populated with copies from FaceDataset by Face_Detection.m

- README.md is this explanatory readme!
- img/ holds source images
- project-description/ includes a reference of all files provided as part of the project definition

- Face_Detection_Accuracy.m is a supplementary script that was used run the face detection algorithm against every file in TestingDataset, for accuracy calculations
- accuracy_testing.txt contains output of accuracy testing



#  4. How to run code

Usage:
1. Choose a data partition from the dropdown menu. There are two 50/50 splits, two 70/30 splits, and one 20/80 split.
2. Click "Train On Image Gallery" to produce a trained model
3. Click "Load Image" and navigate to an image to be tested. Image must be a 92*112 black-and-white pgm image
4. Click "Test face" and the detector will compare the test image to all classes, and make a prediction of nearest match


#  5. Result Discussion 








___

# cits4402-facial-recognition
Submission for cits4402

By Autumn Brough, Michael Stone, Jason Veljanoski


Algorithm outline:

Linear Regression for Face Recognition (non modular):

- start with a set of classes, each with a set of training images, and a probe (test) image to classify (y)

- downsample (!! how?) every image down, e.g. to 10*5 or 15*15 pixels, and represent as a single-column vector

- for each class, represent the training set as a matrix of all training images (X)

- that matrix (the set of training image vectors) represents a subspace of the total image space

- we want to find the point in that subspace that is closest to our probe image

- i.e. we want to find a combination of the training vectors that is almost identical to our test image (y hat)

- use the vector math formula to find y hat: y hat = X . ( X transpose . X )^-1 . X transpose . y

- use the sum of squares distance metric to find the class X that gives y hat closest to y

Modular approach:

- *very* similar to above approach, but every image is subdivided into smaller images

- produce a training subspace matrix for every subdivision, for every class

- for each class, find the absolute best distance ||y hat - y|| across all the subdivisons

- final decision is the class that achieved the minimum distance (i.e. pick the class that had the most perfect tiny patch)
