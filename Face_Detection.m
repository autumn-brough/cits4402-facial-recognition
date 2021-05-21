% CITS4402 - Group 34
% Autumn Brough (21970498)
% Michael Stone (17638566)
% Jason Veljanoski (21980294) 

% GUI to demonstrate the facial recognition algorithm defined in "Linear
% Regression for Face Recognition". Full dataset should be added to
% FaceDataset folder before running. 

% Usage:
% 1. Choose a data partition (50/50, 70/30, lightweight) from the dropdown menu
% 2. Click "Train On Image Gallery" to produce a trained model
% 3. Click "Load Image" and navigate to an image to be tested. Image must
% be a 92*112 black-and-white pgm image
% 4. Click "Test face" and the detector will compare the test image to all
% classes, and make a prediction of nearest match


function varargout = Face_Detection(varargin)
% FACE_DETECTION MATLAB code for Face_Detection.fig
%      FACE_DETECTION, by itself, creates a new FACE_DETECTION or raises the existing
%      singleton*.
%
%      H = FACE_DETECTION returns the handle to a new FACE_DETECTION or the handle to
%      the existing singleton*.
%
%      FACE_DETECTION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FACE_DETECTION.M with the given input arguments.
%
%      FACE_DETECTION('Property','Value',...) creates a new FACE_DETECTION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Face_Detection_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Face_Detection_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Face_Detection

% Last Modified by GUIDE v2.5 25-Apr-2021 15:24:29

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Face_Detection_OpeningFcn, ...
                   'gui_OutputFcn',  @Face_Detection_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before Face_Detection is made visible.
function Face_Detection_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Face_Detection (see VARARGIN)

% Choose default command line output for Face_Detection
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Face_Detection wait for user response (see UIRESUME)
% uiwait(handles.figure1);

%Source working directory containing s1 to s40 subdirectories where the source pgm image files
%are stored
FaceDataset = 'FaceDataset';
%Destination working direction containing person1 to person40 subdirectories where test image
%set are stored
TestingDataset = 'TestingDataset';
%Destination working direction containing person1 to person40 subdirectories where training image
%set are stored
TrainingDataset= 'TrainingDataset';

%Width and height of downscaled images
ResizedImageWidth = 20;

%Save our filepaths to handles
handles.FaceDataset = FaceDataset;
handles.TestingDataset = TestingDataset;
handles.TrainingDataset= TrainingDataset;
handles.ResizedImageWidth = ResizedImageWidth;
guidata(hObject,handles);




% --- Outputs from this function are returned to the command line.

%Function that delete image pgm files in the \TestingDataset'
%and the '\TrainingDataset' Person
%subfolders from directories passed to it from Select_Image_Partitions
function delete_files_in_training_and_test_sets(TestingDataset,TrainingDataset)

%Getting the indexed directories in particular representing the subfolders Person1 to
%Person40 in ‘C:\UWA\Computer Vison\Project\TestingDataset’.  
SubDirInTestingDataset= dir(TestingDataset);
idxSubDir = [SubDirInTestingDataset.isdir] & ~strcmp({SubDirInTestingDataset.name},'.') & ~strcmp({SubDirInTestingDataset.name},'..');
TestingDatasetFolders = {SubDirInTestingDataset(idxSubDir).name};

%Getting the indexed directories in particular repesenting the subfolders Person1 to
%Person40 in ‘C:\UWA\Computer Vison\Project\TrainingDataset’
SubDirInTrainingDataset= dir(TrainingDataset);
idxSubDir = [SubDirInTrainingDataset.isdir] & ~strcmp({SubDirInTrainingDataset.name},'.') & ~strcmp({SubDirInTrainingDataset.name},'..');
TrainingDatasetFolders = {SubDirInTrainingDataset(idxSubDir).name};

%Looping through the numbers of elements in TestingDatasetFolders which is the same as
%number of elements in TrainingDatasetFolders and deleting
%all pgm files within each of the indexed folders corresponding the folders
%Person1 to Person40 within '\TestingDataset' and
%\TrainingDataset
for i= 1:numel(TestingDatasetFolders)
  %FaceDatasetSubDir{i} = fullfile(FaceDataset,FaceDatasetFolders{i});
  delete(fullfile(TestingDataset,TestingDatasetFolders{i},'*.pgm'));   %dir
  delete(fullfile(TrainingDataset,TrainingDatasetFolders{i},'*.pgm'));
end


function split_split(FaceDataset, TestingDataset, TrainingDataset, split_definition)

%example use: split definition = ["train, "train", "train", "train", "train", "test", "test", "test", "test", "test"]

%Get the source directory of the image files 
SubDirInFaceDataset= dir(FaceDataset);
idxSubDir = [SubDirInFaceDataset.isdir] & ~strcmp({SubDirInFaceDataset.name},'.') & ~strcmp({SubDirInFaceDataset.name},'..');
% folders in FaceDataset

%Get all the s1 to s40 subdirectories in the '\FaceDataset'
%image source directory
FaceDatasetFolders = {SubDirInFaceDataset(idxSubDir).name};
FaceDatasetSubDir = cell(1,numel(FaceDatasetFolders));

SubDirInTestingDataset= dir(TestingDataset);
idxSubDir = [SubDirInTestingDataset.isdir] & ~strcmp({SubDirInTestingDataset.name},'.') & ~strcmp({SubDirInTestingDataset.name},'..');
%Folders in TestingDataset
%Get all the Person1 to Person40 folders in '\TestingDataset'
TestingDatasetFolders = {SubDirInTestingDataset(idxSubDir).name};
%TestingDatasetSubDir = cell(1,numel(TestingDatasetFolders));

SubDirInTrainingDataset= dir(TrainingDataset);
idxSubDir = [SubDirInTrainingDataset.isdir] & ~strcmp({SubDirInTrainingDataset.name},'.') & ~strcmp({SubDirInTrainingDataset.name},'..');
%Get all the Person1 to Person40 folders in '\TrainingDataset'
TrainingDatasetFolders = {SubDirInTrainingDataset(idxSubDir).name};
TrainingDatasetSubDir = cell(1,numel(TrainingDatasetFolders));

%Loop through the indexed folders corresponding all the s1 to s40 subfolders in
%'\FaceDataset'
for i= 1:numel(FaceDatasetFolders)
  FaceDatasetSubDir{i} = fullfile(FaceDataset,FaceDatasetFolders{i});
  
  %Get all the pgm files in the source based indexed folder and index them 
  ImageFiles = dir(fullfile(FaceDataset,FaceDatasetFolders{i},'*.pgm'));   %dir
  %SizeImageFiles = cell(size(ImageFiles));
  
  %Get the indexed subfolders corresponding to Person1 to Person40 subdirectories in
  %'\TrainingDataset' that have a one to one correspondence
  %with those 'in '\FaceDataset 
  TrainingDatasetSubDir{i} = fullfile(TrainingDataset,TrainingDatasetFolders{i});
  %disp(TrainingDatasetSubDir{i})
  
  %Get the indexed subfolders corresponding to Person1 to Person40 subdirectories in
  %'\TestingDataset' that have a one to one correspondence
  %match with those %'in '\FaceDataset 
  TestingDatasetSubDir{i} =  fullfile(TestingDataset,TestingDatasetFolders{i});
  %disp(TestingDatasetSubDir{i})
  
  %Loop through all the indexed pmg images in each the s1 to s40 subfolders in
  %'\FaceDataset'
  for j = 1:numel(ImageFiles)
    image = ImageFiles(j).name;  
    %source = strcat(FaceDatasetSubDir{i},image);
    source = fullfile(FaceDataset,FaceDatasetFolders{i},image);
    destTrain = fullfile(TrainingDataset,TrainingDatasetFolders{i},image);
    destTest= fullfile(TestingDataset,TestingDatasetFolders{i},image);
    %If index is less than 5 copy pgm file to a person folder in 
    %'\TrainingDataset'
    if split_definition(j) == "train"
        copyfile(source,destTrain)        
    elseif split_definition(j) == "test" %Else if index is more than 5 copy pgm file to a Person folder in '\TestingDataset'
        copyfile(source,destTest)       
        
    end    
  end
end


function varargout = Face_Detection_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in Select_Image_Partitions.
function Select_Image_Partitions_Callback(hObject, eventdata, handles)
% hObject    handle to Select_Image_Partitions (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
str = get(hObject, 'String');
val = get(hObject,'Value');
% Set current data to the selected data set.

%read in a value from the dropdown box 
split_def = ["train", "train", "train", "train", "train", "test", "test", "test", "test", "test"];
handles.num_training_set = 5;

disp(str{val})
switch str{val}
case 'Middle Split' % User selects middle split
   split_def = ["train", "train", "train", "train", "train", "test", "test", "test", "test", "test"];
    handles.num_training_set = 5;
case 'Interleave' % User selects interleave
   split_def = ["train", "test", "train", "test", "train", "test", "train", "test", "train", "test"];
    handles.num_training_set = 5;
case  '70/30'
   split_def = ["train", "train", "train", "train", "train", "train", "train", "test", "test", "test"];
    handles.num_training_set = 7;
case  '30/70'
   split_def = ["test", "test", "test", "train", "train", "train", "train", "train", "train", "train"];
    handles.num_training_set = 7;
case  'Lightweight'
   split_def = ["train", "train", "test", "test", "test", "test", "test", "test", "test", "test",];
    handles.num_training_set = 2;
        
end


delete_files_in_training_and_test_sets(handles.TestingDataset,handles.TrainingDataset)
split_split(handles.FaceDataset, handles.TestingDataset, handles.TrainingDataset, split_def);

msgbox("Files partitioned!");

% Save the handles structure.
guidata(hObject,handles)
% Hints: contents = cellstr(get(hObject,'String')) returns Select_Image_Partitions contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Select_Image_Partitions


% --- Executes during object creation, after setting all properties.
function Select_Image_Partitions_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Select_Image_Partitions (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

%Remove ticks and make the axes invisible in the image box
set(gca, 'XTick',[])
set(gca, 'YTick',[])
set(gca,'box','off')
%set(gca,'visible','off')
% Hint: place code in OpeningFcn to populate axes1


% --- Executes during object creation, after setting all properties.
function axes2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
%Remove ticks and make the axes invisible in the image box
set(gca, 'XTick',[])
set(gca, 'YTick',[])
set(gca,'box','off')
%set(gca,'visible','off')
% Hint: place code in OpeningFcn to populate axes2


% --- Executes on button press in Load_image.
%Loads the test image into the left hand image box  
function Load_image_Callback(hObject, eventdata, handles)
% hObject    handle to Load_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Get file path and file to where the MATLAB program is located   
[file,path] = uigetfile('*.pgm');
if isequal(file,0)
   disp('User selected Cancel');
else
   disp(['User selected ', fullfile(path,file)]);
   path_file = fullfile(path,file);
   file_in = imread(path_file);    %read in the file    
   %Retrieve GUI data
   handles = guidata(hObject);
   %Get a handle for the files so it can be accessed in the other uis
   handles.image_opened = file_in;
   axes(handles.axes1);    %Set axes1 as the display box
   imshow(handles.image_opened);  %display the image
   %Update handles structure 
   guidata(hObject, handles); %Update the handle so that handles.image_opened is accessable
                              %by the other UI interface components
end

%Function that does the training
% --- Executes on button press in Train_On_Image_Gallery.
function Train_On_Image_Gallery_Callback(hObject, eventdata, handles)
% hObject    handle to Train_On_Image_Gallery (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%where the training set is located

TrainingDataset = handles.TrainingDataset;
SubDirInTrainingDataset= dir(TrainingDataset);
idxSubDir = [SubDirInTrainingDataset.isdir] & ~strcmp({SubDirInTrainingDataset.name},'.') & ~strcmp({SubDirInTrainingDataset.name},'..');
%Folders for each face in TrainingDataset
TrainingDatasetFolders = {SubDirInTrainingDataset(idxSubDir).name};
NumTrainingDatasetFolders = size(TrainingDatasetFolders, 2);
handles.TrainingDatasetFolders= TrainingDatasetFolders;

%Allocation of zeros for a 4 dimensional matrix representing all the training class specific
%models of the images. The first index is the number of row which in this case is the height
%of the column vector created from the images.5 is the number of images in the Person director
%NumTrainingDatasetFolders is the number of the class specific models
X= zeros(10304, handles.num_training_set ,NumTrainingDatasetFolders);
%X_resized = zeros(handles.ResizedImageWidth * handles.ResizedImageWidth, 5, NumTrainingDatasetFolders);
%Give the whose set of class specific models so it can be access in all of the gui*
handles.X = X;
%handles.X_resized = X_resized;

handles.NumTrainingDatasetFolders = numel(TrainingDatasetFolders);

%Loop through Training face subdirectories
for i= 1:numel(TrainingDatasetFolders) 
 P = fullfile(TrainingDataset,TrainingDatasetFolders{i});
 %Image files in TrainingDataset/TrainingDatasetFolders
 D = dir(fullfile(TrainingDataset,TrainingDatasetFolders{i},'*.pgm'));   %dir
 C= cell(size(D));
 
 %Set up a storage matrix which will have column image vectors appended to it 
 X_i = [];
 %X_i_resized = [];
 
 
 %Loop through images in Person subdirecties in directory 
 for j = 1:numel(D)
     
    %read the image file in the directory  
    C{j} = imread(fullfile(P,D(j).name));
    
    %Create a column vector from the image read
    imgVector = C{j}(:);
    %Normalize the vector by converting it to double and dividing by its norm
    imgVector = double(imgVector);
    imgVector= imgVector/norm(imgVector);
    
    %imgVector_resized = C{j}(:);
    %imgVector_resized = imresize(imgVector_resized, [handles.ResizedImageWidth handles.ResizedImageWidth], "bilinear");
    %imgVector_resized = double(imgVector_resized);
    %imgVector_resized = imgVector_resized/norm(imgVector_resized);
    
    %Append the image column vector to the storage matrix
    X_i= [X_i imgVector];
    %X_i_resized = [X_i_resized imgVector_resized];
    
 end
    
     
     %If the number of images in the subdirectory is not equal to 0
      if numel(D) ~= 0
      
         %Assign the ith class specific model the dummy matrix     
         X(:,:,i) = X_i;
         %Assign the ith class specific model with a handle the dummy matrix
         handles.X(:,:,i) = X_i;
              
         %X_resized(:,:,i) = X_i_resized;
         %handles.X_resized(:,:,i) = X_i_resized;
      end
      
end

msgbox("Model trained!");

%After having gone through the image trim off the first two columns of the container of the class 
%specific model so it is if the format X(10304, 5,40) required for the computation of the Euclidean
%distance between a chosen test image and the model matrix of the images in the training set;
handles.X(:,1,:) = [];
handles.X(:,1,:) = [];
guidata(hObject, handles);


% --- Executes on button press in Test_for_face_with_nearest_match.
function Test_for_face_with_nearest_match_Callback(hObject, eventdata, handles)
% hObject    handle to Test_for_face_with_nearest_match (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = guidata(hObject);

%Get image selected
image_opened= handles.image_opened;
%Convert to a column vector 
imgVectorTest = image_opened(:);
%Convert to a double vector 
imgVectorTest = double(imgVectorTest);
%Norm The vector
imgVectorTest = imgVectorTest/norm(imgVectorTest);

%Get the number of Person Trained dataset folders
num_trained_faces= handles.NumTrainingDatasetFolders;

TrainingDataset= handles.TrainingDataset;
minDist = Inf;
TrainFaceFolder = handles.TrainingDatasetFolders;
%Loop through all Person subfolders ignoring . and ..
axes(handles.axes2);
for i= 1:num_trained_faces
  P = fullfile(TrainingDataset,handles.TrainingDatasetFolders{i});
  D = dir(fullfile(TrainingDataset,TrainFaceFolder{i},'*.pgm'));
  %Display a representative image from the training set corresponding to class specific model
  %being tested for
  C = imread(fullfile(P,D(1).name));
  axes(handles.axes2);
  imshow(C);
  
  %summon up the ith class specific model 
  Xi= handles.X(:,:,i);
  
  %Do the computaions on the it specific model and and column vector of the image chosen
  %to get a Euclidian measure of distance from the image chosen 
  yi = Xi/(Xi.'*Xi)*Xi.'*imgVectorTest;
  distances = sqrt((yi - imgVectorTest).^2);
  dist = sum(distances);
  
  %If distance is less then store i as index of nearest face
  if dist < minDist
    minDist = dist;
    indexNearestFace = i;
  end  
end
TrainFaceFolder = handles.TrainingDatasetFolders;

%Get directory where nearest face is held 
P = fullfile(TrainingDataset,handles.TrainingDatasetFolders{indexNearestFace});
D = dir(fullfile(TrainingDataset,TrainFaceFolder{indexNearestFace},'*.pgm'));

%Display nearest face
axes(handles.axes2);
C = imread(fullfile(P,D(1).name));
imshow(C);
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
