function varargout = cits4402(varargin)
% CITS4402 MATLAB code for cits4402.fig
%      CITS4402, by itself, creates a new CITS4402 or raises the existing
%      singleton*.
%
%      H = CITS4402 returns the handle to a new CITS4402 or the handle to
%      the existing singleton*.
%
%      CITS4402('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CITS4402.M with the given input arguments.
%
%      CITS4402('Property','Value',...) creates a new CITS4402 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before cits4402_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to cits4402_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help cits4402

% Last Modified by GUIDE v2.5 12-May-2019 20:46:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @cits4402_OpeningFcn, ...
                   'gui_OutputFcn',  @cits4402_OutputFcn, ...
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



% -------------------------- HELPER FUNCTIONS -----------------------------

%%
% FUNCTION 4.
%
%
 function columns = processImageSet(imageSet, handles)
    
    % Preallocate memory for 50x5x40 array
    columns = zeros(prod(handles.downSample), handles.numImagesToProcess, handles.numClasses);
    
    k = 1;
    % For the 40 classes
    for i = 1 : handles.numClasses
        % For the 5 images in each class
        for j = 1 : handles.numImagesToProcess
            % Pass in kth image, increase 1 each run, as all training images are together
            img = columniseImage(handles, readimage(imageSet, k));
            columns(:, j, i) = img;
            k = k + 1;
        end
    end   

    
    
    
    
%%
% Image processing
% ---
%
function img = columniseImage(handles, img)
    % If RGB, make greyscale
    if ndims(img) == 3
        img = rgb2gray(img);
    end

    % Resize to 10x5
    img = imresize(img, handles.downSample);

    % Reshape to column.
    img = double(img(:));

    % Normalize
    img = img / max(img);

    
    
    
%%
% Distance calculation
% ---
%
function [dist, index] = distanceCalc(handles, y)
    
    % Preallocate memory to fit classes
    dist = zeros(length(handles.classes),1);
    
    % get all dist calculations
    for i = 1 : handles.numClasses
        x = handles.trainingColumns(:,:,i);
        dist(i) = sum((y - x*(x\y)) .^ 2);
    end
    
    % return minima
    [dist,index] = min(dist);

% ------------------------------ END --------------------------------------



% -------------------------- MAIN FUNCTIONS -------------------------------

%%
% Setup functioned called before cits4402 is visible
% ---
% hObject:      handle to figure
% eventdata:    reserved (for later MATLAB version)
% handles:      struct with user data and handles
% varargin:     command line args to cits4402 (see VARARGIN)
%
function cits4402_OpeningFcn(hObject, eventdata, handles, varargin)

    % Select default output for cits4402
    handles.output = hObject;

    % Update handles struct
    guidata(hObject, handles);
    
    % Wait for user interaction
    % [error] -- note, this program only works if the user selects the image
    % folder from the initial pop up. If the user closes this window and
    % attempts to select an image folder by pressing `Load Folder`, the
    % program will BREAK :(
    
    % uiwait(handles.figure1);



%%
% Outputs returned to the command line
% ---
% hObject:      handle to figure
% eventdata:    reserved (for later MATLAB version)
% handles:      struct with user data and handles
%
function varargout = cits4402_OutputFcn(hObject, eventdata, handles) 
    
    % Get default command line output from handles struct
    varargout{1} = handles.output;
    
    % Globals
    handles.maxNumImages = 10;
    handles.downSample = [10 5];
    handles.numImagesToProcess = 5;
    
    % Automatically popup folder selector when program starts (user exp.)
    % ImageDatastore object to manage a collection of image files, where each individual image fits in memory, but the entire collection of images does not necessarily fit.
    % https://au.mathworks.com/help/matlab/ref/matlab.io.datastore.imagedatastore.html
    handles.imds = imageDatastore(uigetdir(), 'includesubfolders',true,'LabelSource','foldernames');
    
    % Update handles struct
    guidata(hObject, handles);

 
    
    
%%
% Load Folder Button Callback
% ---
% Popup window selector widget and update handles
%
function btnLoad_Callback(hObject, eventdata, handles)
    
    % ImageDatastore object to manage a collection of image files, where each individual image fits in memory, but the entire collection of images does not necessarily fit.
    % https://au.mathworks.com/help/matlab/ref/matlab.io.datastore.imagedatastore.html
    handles.imds = imageDatastore(uigetdir(), 'includesubfolders',true,'LabelSource','foldernames');
    
    % Save handles
    guidata(hObject, handles);
    
  
    
    
    
%%
% FUNCTION 3.
% Run Button Callback
% ---
% LRC algorithm excecution and results
%
function btnRun_Callback(hObject, eventdata, handles)
    
    % Create test and training sets
    splitratio = 0.5;
    [handles.trainingSet, handles.testSet] = splitEachLabel(handles.imds, splitratio, 'randomize');
    
    % Folder Name. e.g. S4
    handles.classes = unique(handles.imds.Labels);
    
    % Counts
    handles.numImages = length(handles.imds.Files);
    handles.numTrainingImages = length(handles.trainingSet.Files);
    handles.numTestImages = length(handles.testSet.Files);
    handles.numClasses = length(handles.classes);
    
    % Read in training images
    handles.trainingColumns = processImageSet(handles.trainingSet, handles); 
    
    % for each image
    k = 1;
    correct = 0;
   
        
    for j = 1 : handles.numImagesToProcess
            
            % next image
            [img, info] = readimage(handles.testSet, k);
            imshow(img, 'parent', handles.imgTest);
            set(handles.lblTestClass, 'String', strcat('Class: ', string(info.Label)));
            
            % distance calculation
            [dist, index] = distanceCalc(handles, columniseImage(handles, img)); 
  
            % assuming ten images evenly split
            [predictedImg, predictedInfo] = readimage(handles.trainingSet,(index*5)-4);
            imshow(predictedImg, 'parent', handles.imgClass);
            set(handles.lblTrainingClass, 'String', strcat('Class: ', string(predictedInfo.Label)));
            
            % If correct class
            if index == 1
                set(handles.lblResult, 'String', 'Correct');
                set(handles.lblResult, 'ForegroundColor', 'green');
                correct = correct + 1;
            else
                set(handles.lblResult, 'String', 'Incorrect');
                set(handles.lblResult, 'ForegroundColor', 'red');
                pause(3);
            end
            
            % accuracy calculation and display
            acc = correct/(k-1);
            set(handles.lblAccuracy, 'String', strcat('Accuracy: ', num2str(acc, 4)));
            
            k = k + 1;
            pause(0.5);
            
    end
    
    
% ------------------------------ END --------------------------------------
