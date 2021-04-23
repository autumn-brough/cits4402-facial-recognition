

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

% Last Modified by GUIDE v2.5 21-Apr-2021 11:35:58

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
function delete_files_in_training_and_test_sets(TestFaceDataset,TrainingFaceDataset)
%TestFaceDataset = 'E:\UWA\Computer Vision\Project\TestFaceDataset';
%TrainingFaceDataset= 'E:\UWA\Computer Vision\Project\TrainingFaceDataset';

SubDirInTestFaceDataset= dir(TestFaceDataset);
idxSubDir = [SubDirInTestFaceDataset.isdir];
TestFaceDatasetfolders = {SubDirInTestFaceDataset(idxSubDir).name};
TestFaceDatasetsubdir = cell(1,numel(TestFaceDatasetfolders));

SubDirInTrainFaceDataset= dir(TrainingFaceDataset);
idxSubDir = [SubDirInTrainFaceDataset.isdir];
TrainFaceDatasetfolders = {SubDirInTrainFaceDataset(idxSubDir).name};
TrainFaceDatasetsubdir = cell(1,numel(TrainFaceDatasetfolders));

for i= 1:numel(TestFaceDatasetfolders)
  %FaceDatasetsubdir{i} = fullfile(FaceDataset,FaceDatasetfolders{i});
  delete(fullfile(TestFaceDataset,TestFaceDatasetfolders{i},'*.pgm'));   %dir
  delete(fullfile(TrainingFaceDataset,TrainFaceDatasetfolders{i},'*.pgm'))
end  


function middle_split(FaceDataset, TestFaceDataset,TrainingFaceDataset)
%FaceDataset = 'E:\UWA\Computer Vision\Project\FaceDataset';
%TestFaceDataset = 'E:\UWA\Computer Vision\Project\TestFaceDataset';
%TrainingFaceDataset= 'E:\UWA\Computer Vision\Project\TrainingFaceDataset';

SubDirInFaceDataset= dir(FaceDataset);
idxSubDir = [SubDirInFaceDataset.isdir];
% folders in FaceDataset 
FaceDatasetfolders = {SubDirInFaceDataset(idxSubDir).name};
FaceDatasetsubdir = cell(1,numel(FaceDatasetfolders));


SubDirInTestFaceDataset= dir(TestFaceDataset);
idxSubDir = [SubDirInTestFaceDataset.isdir];
%Folders in TestFaceDataset
TestFaceDatasetfolders = {SubDirInTestFaceDataset(idxSubDir).name};
TestFaceDatasetsubdir = cell(1,numel(TestFaceDatasetfolders));

SubDirInTrainFaceDataset= dir(TrainingFaceDataset);
idxSubDir = [SubDirInTrainFaceDataset.isdir];
%Folders in TrainFaceDataset
TrainFaceDatasetfolders = {SubDirInTrainFaceDataset(idxSubDir).name};
TrainFaceDatasetsubdir = cell(1,numel(TrainFaceDatasetfolders));

for i= 1:numel(FaceDatasetfolders)
  FaceDatasetsubdir{i} = fullfile(FaceDataset,FaceDatasetfolders{i});
  ImageFiles = dir(fullfile(FaceDataset,FaceDatasetfolders{i},'*.pgm'));   %dir
  SizeImageFiles = cell(size(ImageFiles));
  TrainFaceDatasetsubdir{i} = fullfile(TrainingFaceDataset,TrainFaceDatasetfolders{i});
  disp(TrainFaceDatasetsubdir{i})
  TestFaceDatasetsubdir{i} =  fullfile(TestFaceDataset,TestFaceDatasetfolders{i});
  disp(TestFaceDatasetsubdir{i})
  for j = 1:numel(ImageFiles)
    image = ImageFiles(j).name;  
    %source = strcat(FaceDatasetsubdir{i},image);
    source = fullfile(FaceDataset,FaceDatasetfolders{i},image);
    destTrain = fullfile(TrainingFaceDataset,TrainFaceDatasetfolders{i},image);
    destTest= fullfile(TestFaceDataset,TestFaceDatasetfolders{i},image);
    if j <=5
        copyfile(source,destTrain)        
    elseif j>5
        copyfile(source,destTest)       
        
    end    
  end
end 

function interleave(FaceDataset, TestFaceDataset,TrainingFaceDataset)
%FaceDataset = 'E:\UWA\Computer Vision\Project\FaceDataset';
%TestFaceDataset = 'E:\UWA\Computer Vision\Project\TestFaceDataset';
%TrainingFaceDataset= 'E:\UWA\Computer Vision\Project\TrainingFaceDataset';

SubDirInFaceDataset= dir(FaceDataset);
idxSubDir = [SubDirInFaceDataset.isdir];
FaceDatasetfolders = {SubDirInFaceDataset(idxSubDir).name};
FaceDatasetsubdir = cell(1,numel(FaceDatasetfolders));


SubDirInTestFaceDataset= dir(TestFaceDataset);
idxSubDir = [SubDirInTestFaceDataset.isdir];
TestFaceDatasetfolders = {SubDirInTestFaceDataset(idxSubDir).name};
TestFaceDatasetsubdir = cell(1,numel(TestFaceDatasetfolders));

SubDirInTrainFaceDataset= dir(TrainingFaceDataset);
idxSubDir = [SubDirInTrainFaceDataset.isdir];
TrainFaceDatasetfolders = {SubDirInTrainFaceDataset(idxSubDir).name};
TrainFaceDatasetsubdir = cell(1,numel(TrainFaceDatasetfolders));

for i= 1:numel(FaceDatasetfolders)
  FaceDatasetsubdir{i} = fullfile(FaceDataset,FaceDatasetfolders{i});
  ImageFiles = dir(fullfile(FaceDataset,FaceDatasetfolders{i},'*.pgm'));   %dir
  SizeImageFiles = cell(size(ImageFiles));
  TrainFaceDatasetsubdir{i} = fullfile(TrainingFaceDataset,TrainFaceDatasetfolders{i});
  disp(TrainFaceDatasetsubdir{i})
  TestFaceDatasetsubdir{i} =  fullfile(TestFaceDataset,TestFaceDatasetfolders{i});
  disp(TestFaceDatasetsubdir{i})
  for j = 1:numel(ImageFiles)
    rem = mod(j,2)  
    image = ImageFiles(j).name;  
    %source = strcat(FaceDatasetsubdir{i},image);
    source = fullfile(FaceDataset,FaceDatasetfolders{i},image);
    destTrain = fullfile(TrainingFaceDataset,TrainFaceDatasetfolders{i},image);
    destTest= fullfile(TestFaceDataset,TestFaceDatasetfolders{i},image);
    if rem == 0
        copyfile(source,destTrain)        
    elseif rem ~= 0
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
FaceDataset = 'E:\UWA\Computer Vision\Project\FaceDataset';
TestFaceDataset = 'E:\UWA\Computer Vision\Project\TestFaceDataset';
TrainingFaceDataset= 'E:\UWA\Computer Vision\Project\TrainingFaceDataset';
handles = guidata(hObject);
handles.TestFaceDataSet = TestFaceDataset;
handles.TrainingFaceDataset= TrainingFaceDataset;
switch str{val}
case 'Middle Split' % User selects middle split
   disp('middle split')
   delete_files_in_training_and_test_sets(TestFaceDataset,TrainingFaceDataset)
   middle_split(FaceDataset, TestFaceDataset,TrainingFaceDataset)
case 'Interleave' % User selects interleave
   delete_files_in_training_and_test_sets(TestFaceDataset,TrainingFaceDataset)
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
set(gca, 'XTick',[])
set(gca, 'YTick',[])
set(gca,'box','off')
%set(gca,'visible','off')
% Hint: place code in OpeningFcn to populate axes2


% --- Executes on button press in Load_image.
function Load_image_Callback(hObject, eventdata, handles)
% hObject    handle to Load_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
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
   handles.image_opened = file2;                      %rgb2gray(file2); %Convert image to greyscale
   axes(handles.axes1);    %Set axes1 as the display box
   imshow(handles.image_opened);  %display the image
   %Update handles structure 
   guidata(hObject, handles); %Update the handle so that handles.image_opened is accessable
                              %by the other UI interface components
end


% --- Executes on button press in Train_On_Image_Gallery.
function Train_On_Image_Gallery_Callback(hObject, eventdata, handles)
% hObject    handle to Train_On_Image_Gallery (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = guidata(hObject);
TrainFaceDataset = handles.TrainingFaceDataset;
SubDirInTrainFaceDataset= dir(TrainFaceDataset);
idxSubDir = [SubDirInTrainFaceDataset.isdir];
%Folders for each face in TrainFaceDataset
TrainFaceDatasetfolders = {SubDirInTrainFaceDataset(idxSubDir).name};
TrainFaceDatasetsubdir = cell(1,numel(TrainFaceDatasetfolders));
X= zeros(10304, 5,40);
handles.X = X;
handles.NumTrainFaceDatsetfolders = numel(TrainFaceDatasetfolders); 
%Loop through Training face subdirectories
for i= 1:numel(TrainFaceDatasetfolders) 
 %TrainFaceDatasetsubdir{i}
 P = fullfile(TrainFaceDataset,TrainFaceDatasetfolders{i});
 %Image files in TrainFaceDataset/TrainFaceDatasetfolders
 D = dir(fullfile(TrainFaceDataset,TrainFaceDatasetfolders{i},'*.pgm'));   %dir
 C= cell(size(D));
 %SizeImageFiles = cell(size(ImageFiles));
 %TrainFaceDatasetsubdir{i} = fullfile(TrainingFaceDataset,TrainFaceDatasetfolders{i});
 %disp(TrainFaceDatasetsubdir{i})
 disp('folder')
 disp(TrainFaceDatasetfolders{i})
 %disp('number of elements in D');
 %disp(numel(D));
 dummyMatrix = [];
 %Loop through images in subdirectory
 for j = 1:numel(D)
    C{j} = imread(fullfile(P,D(j).name));
    imgVector = C{j}(:);
    %Normalize vector
    imgVector = double(imgVector);
    imgVector= imgVector/norm(imgVector);
    %Get its transpose
    %imgVector = transpose(imgVector); 
    %disp('imgVector')
    %disp(imgVector)
    dummyMatrix= [dummyMatrix imgVector];
    %disp('size of dummy matrix')
    %disp(size(dummyMatrix)); 
    %path_name = ImageFiles(j).name; 
    %Img = imread(fullfile(TrainFaceDatasetsubdir{i}path_name) 
    %image = ImageFiles(j).name;  
    disp(j)
 end
    %disp('size of dummy matrix')
    %disp(size(dummyMatrix)); 
    %disp('size of X matrix')
    if i<= numel(TrainFaceDatasetfolders)-2
     %disp('numel(TrainFaceDatasetfolders)')
     %disp(numel(TrainFaceDatasetfolders));
     %disp(size(X(:,:,i)))
      if numel(D) ~= 0
         X(:,:,i) = dummyMatrix;
         handles.X(:,:,i) = dummyMatrix;
      end
    end  
end
guidata(hObject, handles);


% --- Executes on button press in Test_for_face_with_nearest_match.
function Test_for_face_with_nearest_match_Callback(hObject, eventdata, handles)
% hObject    handle to Test_for_face_with_nearest_match (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
num_individuals= handles.NumTrainFaceDatsetfolders;
for i= 1:num_individuals
end    
