

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


% --- Outputs from this function are returned to the command line.

%Function that delete image pgm files in the C:\UWA\Computer Vision\Project\TestFaceDataset'
%and the 'C:\UWA\Computer Vision\Project\TrainingFaceDataset' Person
%subfolders from directories passed to it from Select_Image_Partitions
function delete_files_in_training_and_test_sets(TestFaceDataset,TrainingFaceDataset)
%TestFaceDataset = 'E:\UWA\Computer Vision\Project\TestFaceDataset';
%TrainingFaceDataset= 'E:\UWA\Computer Vision\Project\TrainingFaceDataset';

%Getting the indexed directories in particular representing the subfolders Person1 to
%Person40 in ‘C:\UWA\Computer Vison\Project\TestFaceDataSet’.  
SubDirInTestFaceDataset= dir(TestFaceDataset);
idxSubDir = [SubDirInTestFaceDataset.isdir];
TestFaceDatasetfolders = {SubDirInTestFaceDataset(idxSubDir).name};
%TestFaceDatasetsubdir = cell(1,numel(TestFaceDatasetfolders));

%Getting the indexed directories in particular repesenting the subfolders Person1 to
%Person40 in ‘C:\UWA\Computer Vison\Project\TrainingFaceDataSet’
SubDirInTrainFaceDataset= dir(TrainingFaceDataset);
idxSubDir = [SubDirInTrainFaceDataset.isdir];
TrainFaceDatasetfolders = {SubDirInTrainFaceDataset(idxSubDir).name};
%TrainFaceDatasetsubdir = cell(1,numel(TrainFaceDatasetfolders));

%Looping through the numbers of elements in TestFaceDatasetfolders which is the same as
%number of elements in TrainFaceDatasetfolders and deleting
%all pgm files within each of the indexed folders corresponding the folders
%Person1 to Person40 within 'C:\UWA\Computer Vision\Project\TestFaceDataset' and
%C:\UWA\Computer Vision\Project\TrainingFaceDataset
for i= 1:numel(TestFaceDatasetfolders)
  %FaceDatasetsubdir{i} = fullfile(FaceDataset,FaceDatasetfolders{i});
  delete(fullfile(TestFaceDataset,TestFaceDatasetfolders{i},'*.pgm'));   %dir
  delete(fullfile(TrainingFaceDataset,TrainFaceDatasetfolders{i},'*.pgm'))
end

%Function to move pgm vision files in 50/50 split into the Person1 to
%Person40 subfolders in 'C:\UWA\Computer Vision\Project\TestFaceDataset' and
%in 'C:\UWA\Computer Vision\Project\TrainingFaceDataset';
function middle_split(FaceDataset, TestFaceDataset,TrainingFaceDataset)
%FaceDataset = 'E:\UWA\Computer Vision\Project\FaceDataset';
%TestFaceDataset = 'E:\UWA\Computer Vision\Project\TestFaceDataset';
%TrainingFaceDataset= 'E:\UWA\Computer Vision\Project\TrainingFaceDataset';

%Get the source directory of the image files 
SubDirInFaceDataset= dir(FaceDataset);
idxSubDir = [SubDirInFaceDataset.isdir];
% folders in FaceDataset

%Get all the s1 to s40 subdirectories in the 'C:\UWA\Computer Vision\Project\FaceDataset'
%image source directory
FaceDatasetfolders = {SubDirInFaceDataset(idxSubDir).name};
%FaceDatasetsubdir = cell(1,numel(FaceDatasetfolders));


SubDirInTestFaceDataset= dir(TestFaceDataset);
idxSubDir = [SubDirInTestFaceDataset.isdir];
%Folders in TestFaceDataset
%Get all the Person1 to Person40 folders in 'C:\UWA\Computer Vision\Project\TestFaceDataset'
TestFaceDatasetfolders = {SubDirInTestFaceDataset(idxSubDir).name};
%TestFaceDatasetsubdir = cell(1,numel(TestFaceDatasetfolders));

SubDirInTrainFaceDataset= dir(TrainingFaceDataset);
idxSubDir = [SubDirInTrainFaceDataset.isdir];
%Get all the Person1 to Person40 folders in 'C:\UWA\Computer Vision\Project\TrainingFaceDataset'
TrainFaceDatasetfolders = {SubDirInTrainFaceDataset(idxSubDir).name};
TrainFaceDatasetsubdir = cell(1,numel(TrainFaceDatasetfolders));

%Loop through the indexed folders corresponding all the s1 to s40 subfolders in
%'C:\UWA\Computer Vision\Project\FaceDataset'
for i= 1:numel(FaceDatasetfolders)
  FaceDatasetsubdir{i} = fullfile(FaceDataset,FaceDatasetfolders{i});
  
  %Get all the pgm files in the source based indexed folder and index them 
  ImageFiles = dir(fullfile(FaceDataset,FaceDatasetfolders{i},'*.pgm'));   %dir
  %SizeImageFiles = cell(size(ImageFiles));
  
  %Get the indexed subfolders corresponding to Person1 to Person40 subdirectories in
  %'C:\UWA\Computer Vision\Project\TrainingFaceDataset' that have a one to one correspondence
  %with those 'in 'C:\UWA\Computer Vision\Project\FaceDataset 
  TrainFaceDatasetsubdir{i} = fullfile(TrainingFaceDataset,TrainFaceDatasetfolders{i});
  disp(TrainFaceDatasetsubdir{i})
  
  %Get the indexed subfolders corresponding to Person1 to Person40 subdirectories in
  %'C:\UWA\Computer Vision\Project\TestFaceDataset' that have a one to one correspondence
  %match with those %'in 'C:\UWA\Computer Vision\Project\FaceDataset 
  TestFaceDatasetsubdir{i} =  fullfile(TestFaceDataset,TestFaceDatasetfolders{i});
  disp(TestFaceDatasetsubdir{i})
  
  %Loop through all the indexed pmg images in each the s1 to s40 subfolders in
  %'C:\UWA\Computer Vision\Project\FaceDataset'
  for j = 1:numel(ImageFiles)
    image = ImageFiles(j).name;  
    %source = strcat(FaceDatasetsubdir{i},image);
    source = fullfile(FaceDataset,FaceDatasetfolders{i},image);
    destTrain = fullfile(TrainingFaceDataset,TrainFaceDatasetfolders{i},image);
    destTest= fullfile(TestFaceDataset,TestFaceDatasetfolders{i},image);
    %If index is less than 5 copy pgm file to a person folder in 
    %'C:\UWA\Computer Vision\Project\TrainingFaceDataset'
    if j <=5
        copyfile(source,destTrain)        
    elseif j>5 %Else if index is more than 5 copy pgm file to a Person folder in 'C:\UWA\Computer Vision\Project\TestFaceDataset'
        copyfile(source,destTest)       
        
    end    
  end
end 
%Function to move pgm vision files in an interleaved 50/50 split into the Person1 to
%Person40 subfolders in 'C:\UWA\Computer Vision\Project\TestFaceDataset' and
%in 'C:\UWA\Computer Vision\Project\TrainingFaceDataset';
function interleave(FaceDataset, TestFaceDataset,TrainingFaceDataset)
%FaceDataset = 'E:\UWA\Computer Vision\Project\FaceDataset';
%TestFaceDataset = 'E:\UWA\Computer Vision\Project\TestFaceDataset';
%TrainingFaceDataset= 'E:\UWA\Computer Vision\Project\TrainingFaceDataset';

SubDirInFaceDataset= dir(FaceDataset);
idxSubDir = [SubDirInFaceDataset.isdir];
%Get all the indexed s1 to s40 subdirectories in the 'C:\UWA\Computer Vision\Project\FaceDataset'
%image source directory
FaceDatasetfolders = {SubDirInFaceDataset(idxSubDir).name};
FaceDatasetsubdir = cell(1,numel(FaceDatasetfolders));


SubDirInTestFaceDataset= dir(TestFaceDataset);
idxSubDir = [SubDirInTestFaceDataset.isdir];
%Get all the indexed  person1 to person40 subdirectories in the 'C:\UWA\Computer Vision\Project\TestFaceDataset'
%image source directory
TestFaceDatasetfolders = {SubDirInTestFaceDataset(idxSubDir).name};
TestFaceDatasetsubdir = cell(1,numel(TestFaceDatasetfolders));

SubDirInTrainFaceDataset= dir(TrainingFaceDataset);
idxSubDir = [SubDirInTrainFaceDataset.isdir];
%Get all the indexed  person1 to person40 subdirectories in the 'C:\UWA\Computer Vision\Project\TrainingFaceDataset'
%image source directory
TrainFaceDatasetfolders = {SubDirInTrainFaceDataset(idxSubDir).name};
TrainFaceDatasetsubdir = cell(1,numel(TrainFaceDatasetfolders));

%Loop through all the indexed pmg images in each the s1 to s40 subfolders in
%'C:\UWA\Computer Vision\Project\FaceDataset'
for i= 1:numel(FaceDatasetfolders)
  FaceDatasetsubdir{i} = fullfile(FaceDataset,FaceDatasetfolders{i});
  ImageFiles = dir(fullfile(FaceDataset,FaceDatasetfolders{i},'*.pgm'));   %dir
  SizeImageFiles = cell(size(ImageFiles));
  TrainFaceDatasetsubdir{i} = fullfile(TrainingFaceDataset,TrainFaceDatasetfolders{i});
  disp(TrainFaceDatasetsubdir{i})
  TestFaceDatasetsubdir{i} =  fullfile(TestFaceDataset,TestFaceDatasetfolders{i});
  disp(TestFaceDatasetsubdir{i})
  %Loop through all the indexed pmg images in each the s1 to s40 subfolders in
  %'C:\UWA\Computer Vision\Project\FaceDataset'
  for j = 1:numel(ImageFiles)
    %Remainder after index is divided by two   
    rem = mod(j,2)  
    image = ImageFiles(j).name;  
    %source = strcat(FaceDatasetsubdir{i},image);
    source = fullfile(FaceDataset,FaceDatasetfolders{i},image);
    destTrain = fullfile(TrainingFaceDataset,TrainFaceDatasetfolders{i},image);
    destTest= fullfile(TestFaceDataset,TestFaceDatasetfolders{i},image);
    if rem == 0
        % If remainder is zero copy image to subfolders a person directory
        % in 'C:\UWA\Computer Vision\Project\TrainingFaceDataset
        copyfile(source,destTrain)        
    elseif rem ~= 0
        % If remainder is not equal to zero copy image to subfolders a person directory
        % in 'C:\UWA\Computer Vision\Project\TestFaceDataset
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

%Source working directory containing s1 to s40 subdirectories where the source pgm image files
%are stored
FaceDataset = 'C:\UWA\Computer Vision\Project\FaceDataset';
%Destination working direction containing person1 to person40 subdirectories where test image
%set are stored
TestFaceDataset = 'C:\UWA\Computer Vision\Project\TestFaceDataset';
%Destination working direction containing person1 to person40 subdirectories where training image
%set are stored
TrainingFaceDataset= 'C:\UWA\Computer Vision\Project\TrainingFaceDataset';

%FaceDataset = 'I:\UWA\Computer Vision\Project\FaceDataset';
%TestFaceDataset = 'I:\UWA\Computer Vision\Project\TestFaceDataset';
%TrainingFaceDataset= 'I:\UWA\Computer Vision\Project\TrainingFaceDataset';
handles = guidata(hObject);
%Give the testFaceDataSet a handle so it can be accessed in other guis
handles.TestFaceDataSet = TestFaceDataset;
%Give the testFaceDataSet a handle so it can be accessed in other guis
handles.TrainingFaceDataset= TrainingFaceDataset;
%read in a value from the dropdown box 
switch str{val}
case 'Middle Split' % User selects middle split
   disp('middle split')
   %Clear any pgm image files in the TestFaceDataset and TrainingFaceDataset  
   delete_files_in_training_and_test_sets(TestFaceDataset,TrainingFaceDataset)
   %Allocate image pgm files to the TestFaceDataset and TrainingFaceDataset according to middle split
   %operation
   middle_split(FaceDataset, TestFaceDataset,TrainingFaceDataset)
case 'Interleave' % User selects interleave
   %Clear any pgm image files in the TestFaceDataset and TrainingFaceDataset   
   delete_files_in_training_and_test_sets(TestFaceDataset,TrainingFaceDataset)
    %Allocate image pgm files to the TestFaceDataset and TrainingFaceDataset according to interleave
    %operation
   interleave(FaceDataset, TestFaceDataset,TrainingFaceDataset)
end
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
[file,path] = uigetfile('*.m');
if isequal(file,0)
   disp('User selected Cancel');
else
   disp(['User selected ', fullfile(path,file)]);
   path_file = fullfile(path,file)
   file2 = imread(path_file);    %read in the file    
   %Retrieve GUI data
   handles = guidata(hObject);
   %handles.image_opened = ind2rgb(X1, map1);
   %handles.image_opened = file2;
   %Get a handle for the files so it can be accessed in the other uis
   handles.image_opened = file2;                      %rgb2gray(file2); %Convert image to greyscale
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
handles = guidata(hObject);
%FaceDataset = 'E:\UWA\Computer Vision\Project\FaceDataset';
%TestFaceDataset = 'E:\UWA\Computer Vision\Project\TestFaceDataset';
%TrainingFaceDataset= 'E:\UWA\Computer Vision\Project\TrainingFaceDataset';

%where the training set is located
TrainingFaceDataset= 'C:\UWA\Computer Vision\Project\TrainingFaceDataset';
TrainFaceDataset = TrainingFaceDataset;
SubDirInTrainFaceDataset= dir(TrainFaceDataset);
idxSubDir = [SubDirInTrainFaceDataset.isdir];
%Folders for each face in TrainFaceDataset
TrainFaceDatasetfolders = {SubDirInTrainFaceDataset(idxSubDir).name};
handles.TrainFaceDatasetfolders= TrainFaceDatasetfolders;
TrainFaceDatasetsubdir = cell(1,numel(TrainFaceDatasetfolders));

%Allocation of zeros for a 4 dimensional matrix representing all the training class specific
%models of the images. The first index is the number of row which in this case is the height
%of the column vector created from the images.5 is the number of images in the Person director
%42 is the number of the class specific models where directories . and .. are also included 
X= zeros(10304, 5,42);
%Give the whose set of class specific models so it can be access in all of the gui*
handles.X = X;

handles.NumTrainFaceDatsetfolders = numel(TrainFaceDatasetfolders);

%Loop through Training face subdirectories
for i= 3:numel(TrainFaceDatasetfolders) 
 %TrainFaceDatasetsubdir{i}
 P = fullfile(TrainFaceDataset,TrainFaceDatasetfolders{i});
 %Image files in TrainFaceDataset/TrainFaceDatasetfolders
 D = dir(fullfile(TrainFaceDataset,TrainFaceDatasetfolders{i},'*.pgm'));   %dir
 C= cell(size(D));
 %SizeImageFiles = cell(size(ImageFiles));
 %TrainFaceDatasetsubdir{i} = fullfile(TrainingFaceDataset,TrainFaceDatasetfolders{i});
 %disp(TrainFaceDatasetsubdir{i})
 %disp('folder i')
 %disp(i) 
 disp(TrainFaceDatasetfolders{i})
 %disp('number of elements in D');
 %disp(numel(D));
 
 %Set up a storage matrix which will have column image vectors appended to it 
 dummyMatrix = [];
 
 %disp('num elts D')
 %disp(numel(D))
 
 %Loop through images in Person subdirecties in directory 
 %'C:\UWA\Computer Vision\Project\TrainFaceDataset'
 for j = 1:numel(D)
     
    %read the image file in the directory  
    C{j} = imread(fullfile(P,D(j).name));
    
    %Create a column vector from the image read
    imgVector = C{j}(:)
    ;
    %Normalize the vector by converting it to double and dividing by its norm
    imgVector = double(imgVector);
    imgVector= imgVector/norm(imgVector);
    
    %imgVector = transpose(imgVector); 
    %disp('imgVector')
    %disp(imgVector)
    
    %Append the image column vector to the storage matrix
    dummyMatrix= [dummyMatrix imgVector];
    
    %disp('size of dummy matrix')
    %disp(size(dummyMatrix)); 
    %path_name = ImageFiles(j).name; 
    %Img = imread(fullfile(TrainFaceDatasetsubdir{i}path_name) 
    %image = ImageFiles(j).name;  
    %disp(j)
 end
    
     
     %If the number of images in the subdirectory is not equal to 0
      if numel(D) ~= 0
      
      %Assign the ith class specific model the dummy matrix     
         X(:,:,i) = dummyMatrix;
         %%Assign the ith class specific model with a handle the dummy matrix
         handles.X(:,:,i) = dummyMatrix;
      end
    %end 
end

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
disp(imgVectorTest);

%Get the number of Person Trained dataset folders
num_trained_faces= handles.NumTrainFaceDatsetfolders;
%Xi= zeros(10304, 5,40);
disp('no trained faces')
disp(num_trained_faces)

TrainFaceDataset= 'C:\UWA\Computer Vision\Project\TrainingFaceDataset';
%TrainFaceDataset= 'I:\UWA\Computer Vision\Project\TrainingFaceDataset';
minDist = Inf;
TrainFaceFolder = handles.TrainFaceDatasetfolders;
%Loop through all Person subfolders ignoring . and ..
for i= 3:num_trained_faces
  P = fullfile(TrainFaceDataset,handles.TrainFaceDatasetfolders{i});
  D = dir(fullfile(TrainFaceDataset,TrainFaceFolder{i},'*.pgm'));
  %Display a representative image from the training set corresponding to class specific model
  %being tested for
  axes(handles.axes2);
  C = imread(fullfile(P,D(1).name));
  imshow(C)
  
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
TrainFaceFolder = handles.TrainFaceDatasetfolders;

%Get directory where nearest face is held 
P = fullfile(TrainFaceDataset,handles.TrainFaceDatasetfolders{indexNearestFace});
D = dir(fullfile(TrainFaceDataset,TrainFaceFolder{indexNearestFace},'*.pgm'));

%Display nearest face
axes(handles.axes2);
C = imread(fullfile(P,D(1).name));
imshow(C)
guidata(hObject, handles)


% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
