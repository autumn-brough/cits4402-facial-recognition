# 1. Approach followed and data partition

# 2. GUI Display

<img src="/img/gui.png" alt="gui" style="zoom:50%;" />



1. Select partition method (middle split, interleave, 70/30, 30/70, Lightweight)
2. Load Image
3. Train
4. Test



# 3. What is in the GIT

- make sure the name of the folders reflect it contents



#  4. How to run code



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
