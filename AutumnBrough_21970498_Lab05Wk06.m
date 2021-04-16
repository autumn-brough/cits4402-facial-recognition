% Autumn Brough 21974098
% Week 6 Lab 5

% GUI for the segmentation of images based on brightness, RGB, and HSV
% values. Select a segmentation method from the dropdown and input upper
% and lower thresholds (0 through 255) using the sliders. Thresholded image
% will appear on the right hand side.

% Method: From original image, the appropriate element is extracted. This
% is then thresholded to create a binary mask, and the mask is applied to
% the original image.

function varargout = AutumnBrough_21970498_Lab05Wk06(varargin)
% AutumnBrough_21970498_Lab05Wk06 MATLAB code for AutumnBrough_21970498_Lab05Wk06.fig
%      AutumnBrough_21970498_Lab05Wk06, by itself, creates a new AutumnBrough_21970498_Lab05Wk06 or raises the existing
%      singleton*.
%
%      H = AutumnBrough_21970498_Lab05Wk06 returns the handle to a new AutumnBrough_21970498_Lab05Wk06 or the handle to
%      the existing singleton*.
%
%      AutumnBrough_21970498_Lab05Wk06('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in AutumnBrough_21970498_Lab05Wk06.M with the given input arguments.
%
%      AutumnBrough_21970498_Lab05Wk06('Property','Value',...) creates a new AutumnBrough_21970498_Lab05Wk06 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before AutumnBrough_21970498_Lab05Wk06_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to AutumnBrough_21970498_Lab05Wk06_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help AutumnBrough_21970498_Lab05Wk06

% Last Modified by GUIDE v2.5 05-Apr-2021 16:25:49

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @AutumnBrough_21970498_Lab05Wk06_OpeningFcn, ...
                   'gui_OutputFcn',  @AutumnBrough_21970498_Lab05Wk06_OutputFcn, ...
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


% --- Executes just before AutumnBrough_21970498_Lab05Wk06 is made visible.
function AutumnBrough_21970498_Lab05Wk06_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to AutumnBrough_21970498_Lab05Wk06 (see VARARGIN)

handles.image_name = 'peppers.png';
handles.loaded_image = imread(handles.image_name);

handles.lower_threshold = 0;
handles.upper_threshold = 255;
handles.threshold_type = "Brightness";

% Update rendered image
handles.processed_image = handles.loaded_image .* get_threshold_mask(handles);

% Choose default command line output for AutumnBrough_21970498_Lab05Wk06
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes AutumnBrough_21970498_Lab05Wk06 wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% Display starting image in both panels
axes(handles.axes1);
imagesc(handles.loaded_image);
axes(handles.axes2);
imagesc(handles.processed_image);


% --- Outputs from this function are returned to the command line.
function varargout = AutumnBrough_21970498_Lab05Wk06_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in loadimagebutton.
function loadimagebutton_Callback(hObject, eventdata, handles)
% hObject    handle to loadimagebutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Read in image
handles.loaded_image = imread(uigetfile('*.png;*.jpg'));
handles.processed_image = handles.loaded_image .* get_threshold_mask(handles);

% Display in both panels
axes(handles.axes1);
imagesc(handles.loaded_image);
axes(handles.axes2);
imagesc(handles.processed_image);

guidata(hObject, handles);

% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

handles.lower_threshold = get(hObject, 'Value');

handles.processed_image = handles.loaded_image .* get_threshold_mask(handles);

% Update rendered image

axes(handles.axes2);
imagesc(handles.processed_image);

guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


handles.upper_threshold = get(hObject, 'Value');

handles.processed_image = handles.loaded_image .* get_threshold_mask(handles);

% Update rendered image

axes(handles.axes2);
imagesc(handles.processed_image);

guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2

contents = cellstr(get(hObject,'String'));
handles.threshold_type = contents{get(hObject,'Value')};

% Update rendered image
handles.processed_image = handles.loaded_image .* get_threshold_mask(handles);

axes(handles.axes2);
imagesc(handles.processed_image);

guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function binary_mask = get_threshold_mask(handles)

to_be_thresholded = zeros(size(handles.loaded_image));
hsv_image = uint8 (rgb2hsv(handles.loaded_image) * 255);

switch handles.threshold_type
    case "Brightness"
        to_be_thresholded = rgb2gray(handles.loaded_image);
    case "Red"
        to_be_thresholded = handles.loaded_image(:,:,1);
    case "Green"
        to_be_thresholded = handles.loaded_image(:,:,2);
    case "Blue"
        to_be_thresholded = handles.loaded_image(:,:,3);
    case "Hue"
        to_be_thresholded = hsv_image(:,:,1);
    case "Saturation"
        to_be_thresholded = hsv_image(:,:,2);
    case "Value"
        to_be_thresholded = hsv_image(:,:,3);
    otherwise
        "do nothing";
end

[handles.lower_threshold handles.upper_threshold]

binary_mask = uint8 ( (to_be_thresholded > handles.lower_threshold) & (to_be_thresholded < handles.upper_threshold) );
