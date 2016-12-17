function varargout = image_processing(varargin)

% IMAGE_PROCESSING MATLAB code for image_processing.fig
%      IMAGE_PROCESSING, by itself, creates a new IMAGE_PROCESSING or raises the existing
%      singleton*.
%
%      H = IMAGE_PROCESSING returns the handle to a new IMAGE_PROCESSING or the handle to
%      the existing singleton*.
%
%      IMAGE_PROCESSING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IMAGE_PROCESSING.M with the given input arguments.
%
%      IMAGE_PROCESSING('Property','Value',...) creates a new IMAGE_PROCESSING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before image_processing_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to image_processing_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help image_processing

% Last Modified by GUIDE v2.5 17-Dec-2016 22:08:00

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @image_processing_OpeningFcn, ...
                   'gui_OutputFcn',  @image_processing_OutputFcn, ...
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


% --- Executes just before image_processing is made visible.
function Pre_Processing()
global check img img1 img2 cam HSV H S V imgTh imgTh1 imgTh2 slide compare
   se = strel('disk', 9);
   img = snapshot(cam);
   img1 = imgaussfilt(img,4);
   img2 = imsharpen(img1);
   HSV = rgb2hsv(img2);
   H = HSV(:,:,1);
   S = HSV(:,:,2);
   V = HSV(:,:,3);
   imgth = abs(H - slide(1)) < compare(1) & abs(S - slide(2)) < compare(2) & abs(V - slide(3)) < compare(3);
   imgth1 = abs(H - slide(4)) < compare(4) & abs(S - slide(5)) < compare(5) & abs(V - slide(6)) < compare(6);
   imgth2 = abs(H - slide(7)) < compare(7) & abs(S - slide(8)) < compare(8) & abs(V - slide(9)) < compare(9);
   erode1 = imerode(imgth,se);
   imgth = imdilate(erode1,se);
   dilate1 = imdilate(imgth,se);
   imgTh = imerode(dilate1,se);
   erode2 = imerode(imgth1,se);
   imgth1 = imdilate(erode2,se);
   dilate2 = imdilate(imgth1,se);
   imgTh1 = imerode(dilate2,se);
   erode3 = imerode(imgth2,se);
   imgth2 = imdilate(erode3,se);
   dilate3 = imdilate(imgth2,se);
   imgTh2 = imerode(dilate3,se);

function image_processing_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to image_processing (see VARARGIN)

% Choose default command line output for image_processing
global slide check compare
slide = [0 0 0 0 0 0 0 0 0];
check = 0;
compare = [0 0 0 0 0 0 0 0 0];
handles.output = hObject;
set(handles.cp1, 'String', num2str(0));
set(handles.cp2, 'String', num2str(0));
set(handles.cp3, 'String', num2str(0));
set(handles.cp4, 'String', num2str(0));
set(handles.cp5, 'String', num2str(0));
set(handles.cp6, 'String', num2str(0));
set(handles.cp7, 'String', num2str(0));
set(handles.cp8, 'String', num2str(0));
set(handles.cp9, 'String', num2str(0));
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes image_processing wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = image_processing_OutputFcn(hObject, eventdata, handles) 
global check
check = 1;
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
global check img img1 img2 cam HSV H S V imgTh imgTh1 imgTh2
%mypi = raspi('169.254.0.2','pi','raspberry');
%cam = cameraboard(mypi, 'Resolution', '320x240', 'FrameRate', 30);
cam = webcam(1);
while (check==0)
   Pre_Processing();
   axes(handles.axes1);
   imagesc(img2);
   axes(handles.axes2);
   imagesc(H);
   axes(handles.axes3);
   imagesc(S);
   axes(handles.axes4);
   imagesc(V);
   axes(handles.axes5);
   imagesc(imgTh);
   axes(handles.axes6);
   imagesc(imgTh1);
   axes(handles.axes7);
   imagesc(imgTh2);
   drawnow; 
end
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
global check
check = 1;
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global compare slide
fileID = fopen('all_value.txt','w');
for i = 1:9
    fprintf(fileID,'%.4f ',compare(i));
end
fprintf(fileID,'\n');
for i = 1:9
    fprintf(fileID,'%.4f ',slide(i));
end
fclose(fileID);

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
global compare slide
fileID = fopen('all_value.txt','r');

[compare(1) ,compare(2) ,compare(3) ,compare(4), compare(5) ,compare(6), compare(7) ,compare(8) ,compare(9), slide(1) ,slide(2), slide(3), slide(4), slide(5), slide(6), slide(7), slide(8), slide(9)] = textread('all_value.txt','%f %f %f %f %f %f %f %f %f\n%f %f %f %f %f %f %f %f %f',1);

fclose(fileID);
set(handles.slider1, 'Value', slide(1));
set(handles.slider2, 'Value', slide(2));
set(handles.slider3, 'Value', slide(3));
set(handles.slider4, 'Value', slide(4));
set(handles.slider5, 'Value', slide(5));
set(handles.slider6, 'Value', slide(6));
set(handles.slider7, 'Value', slide(7));
set(handles.slider8, 'Value', slide(8));
set(handles.slider9, 'Value', slide(9));
set(handles.Edit1, 'String', num2str(slide(1)));
set(handles.Edit2, 'String', num2str(slide(2)));
set(handles.Edit3, 'String', num2str(slide(3)));
set(handles.Edit4, 'String', num2str(slide(4)));
set(handles.Edit5, 'String', num2str(slide(5)));
set(handles.Edit6, 'String', num2str(slide(6)));
set(handles.Edit7, 'String', num2str(slide(7)));
set(handles.Edit8, 'String', num2str(slide(8)));
set(handles.Edit9, 'String', num2str(slide(9)));
set(handles.cp1, 'String', num2str(compare(1)));
set(handles.cp2, 'String', num2str(compare(2)));
set(handles.cp3, 'String', num2str(compare(3)));
set(handles.cp4, 'String', num2str(compare(4)));
set(handles.cp5, 'String', num2str(compare(5)));
set(handles.cp6, 'String', num2str(compare(6)));
set(handles.cp7, 'String', num2str(compare(7)));
set(handles.cp8, 'String', num2str(compare(8)));
set(handles.cp9, 'String', num2str(compare(9)));
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global check img img1 img2 cam HSV H S V imgTh slide imgTh1 imgTh2
check = 0;
slide(1) = get(hObject,'Value');
set(handles.Edit1, 'String', num2str(slide(1)));
while (check==0)
   Pre_Processing();
   axes(handles.axes1);
   imagesc(img2);
   axes(handles.axes2);
   imagesc(H);
   axes(handles.axes3);
   imagesc(S);
   axes(handles.axes4);
   imagesc(V);
   axes(handles.axes5);
   imagesc(imgTh);
   axes(handles.axes6);
   imagesc(imgTh1);
   axes(handles.axes7);
   imagesc(imgTh2);
   drawnow; 
end
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


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
global check img img1 img2 cam HSV H S V imgTh slide imgTh1 imgTh2
check = 0;
slide(2) = get(hObject,'Value');
set(handles.Edit2, 'String', num2str(slide(2)));
while (check==0)
   Pre_Processing();
   axes(handles.axes1);
   imagesc(img2);
   axes(handles.axes2);
   imagesc(H);
   axes(handles.axes3);
   imagesc(S);
   axes(handles.axes4);
   imagesc(V);
   axes(handles.axes5);
   imagesc(imgTh);
   axes(handles.axes6);
   imagesc(imgTh1);
   axes(handles.axes7);
   imagesc(imgTh2);
   drawnow; 
end
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider3_Callback(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global check img img1 img2 cam HSV H S V imgTh slide imgTh1 imgTh2
check = 0;
slide(3) = get(hObject,'Value');
set(handles.Edit3, 'String', num2str(slide(3)));
while (check==0)
   Pre_Processing();
   axes(handles.axes1);
   imagesc(img2);
   axes(handles.axes2);
   imagesc(H);
   axes(handles.axes3);
   imagesc(S);
   axes(handles.axes4);
   imagesc(V);
   axes(handles.axes5);
   imagesc(imgTh);
   axes(handles.axes6);
   imagesc(imgTh1);
   axes(handles.axes7);
   imagesc(imgTh2);
   drawnow; 
end
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Edit1_Callback(hObject, eventdata, handles)
% hObject    handle to Edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Edit1 as text
%        str2double(get(hObject,'String')) returns contents of Edit1 as a double


% --- Executes during object creation, after setting all properties.
function Edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Edit2_Callback(hObject, eventdata, handles)
% hObject    handle to Edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Edit2 as text
%        str2double(get(hObject,'String')) returns contents of Edit2 as a double


% --- Executes during object creation, after setting all properties.
function Edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Edit3_Callback(hObject, eventdata, handles)
% hObject    handle to Edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Edit3 as text
%        str2double(get(hObject,'String')) returns contents of Edit3 as a double


% --- Executes during object creation, after setting all properties.
function Edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider4_Callback(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global check img img1 img2 cam HSV H S V imgTh slide imgTh1 imgTh2
check = 0;
slide(4) = get(hObject,'Value');
set(handles.Edit4, 'String', num2str(slide(4)));
while (check==0)
   Pre_Processing();
   axes(handles.axes1);
   imagesc(img2);
   axes(handles.axes2);
   imagesc(H);
   axes(handles.axes3);
   imagesc(S);
   axes(handles.axes4);
   imagesc(V);
   axes(handles.axes5);
   imagesc(imgTh);
   axes(handles.axes6);
   imagesc(imgTh1);
   axes(handles.axes7);
   imagesc(imgTh2);
   drawnow; 
end
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider5_Callback(hObject, eventdata, handles)
% hObject    handle to slider5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global check img img1 img2 cam HSV H S V imgTh slide imgTh1 imgTh2
check = 0;
slide(5) = get(hObject,'Value');
set(handles.Edit5, 'String', num2str(slide(5)));
while (check==0)
   Pre_Processing();
   axes(handles.axes1);
   imagesc(img2);
   axes(handles.axes2);
   imagesc(H);
   axes(handles.axes3);
   imagesc(S);
   axes(handles.axes4);
   imagesc(V);
   axes(handles.axes5);
   imagesc(imgTh);
   axes(handles.axes6);
   imagesc(imgTh1);
   axes(handles.axes7);
   imagesc(imgTh2);
   drawnow; 
end
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider6_Callback(hObject, eventdata, handles)
% hObject    handle to slider6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global check img img1 img2 cam HSV H S V imgTh slide imgTh1 imgTh2
check = 0;
slide(6) = get(hObject,'Value');
set(handles.Edit6, 'String', num2str(slide(6)));
while (check==0)
   Pre_Processing();
   axes(handles.axes1);
   imagesc(img2);
   axes(handles.axes2);
   imagesc(H);
   axes(handles.axes3);
   imagesc(S);
   axes(handles.axes4);
   imagesc(V);
   axes(handles.axes5);
   imagesc(imgTh);
   axes(handles.axes6);
   imagesc(imgTh1);
   axes(handles.axes7);
   imagesc(imgTh2);
   drawnow; 
end
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function Edit4_Callback(hObject, eventdata, handles)
% hObject    handle to Edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Edit4 as text
%        str2double(get(hObject,'String')) returns contents of Edit4 as a double


% --- Executes during object creation, after setting all properties.
function Edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Edit5_Callback(hObject, eventdata, handles)
% hObject    handle to Edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Edit5 as text
%        str2double(get(hObject,'String')) returns contents of Edit5 as a double


% --- Executes during object creation, after setting all properties.
function Edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Edit6_Callback(hObject, eventdata, handles)
% hObject    handle to Edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Edit6 as text
%        str2double(get(hObject,'String')) returns contents of Edit6 as a double


% --- Executes during object creation, after setting all properties.
function Edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider7_Callback(hObject, eventdata, handles)
% hObject    handle to slider7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global check img img1 img2 cam HSV H S V imgTh slide imgTh1 imgTh2
check = 0;
slide(7) = get(hObject,'Value');
set(handles.Edit7, 'String', num2str(slide(7)));
while (check==0)
   Pre_Processing();
   axes(handles.axes1);
   imagesc(img2);
   axes(handles.axes2);
   imagesc(H);
   axes(handles.axes3);
   imagesc(S);
   axes(handles.axes4);
   imagesc(V);
   axes(handles.axes5);
   imagesc(imgTh);
   axes(handles.axes6);
   imagesc(imgTh1);
   axes(handles.axes7);
   imagesc(imgTh2);
   drawnow; 
end
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider8_Callback(hObject, eventdata, handles)
% hObject    handle to slider8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global check img img1 img2 cam HSV H S V imgTh slide imgTh1 imgTh2
check = 0;
slide(8) = get(hObject,'Value');
set(handles.Edit8, 'String', num2str(slide(8)));
while (check==0)
   Pre_Processing();
   axes(handles.axes1);
   imagesc(img2);
   axes(handles.axes2);
   imagesc(H);
   axes(handles.axes3);
   imagesc(S);
   axes(handles.axes4);
   imagesc(V);
   axes(handles.axes5);
   imagesc(imgTh);
   axes(handles.axes6);
   imagesc(imgTh1);
   axes(handles.axes7);
   imagesc(imgTh2);
   drawnow; 
end
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider9_Callback(hObject, eventdata, handles)
% hObject    handle to slider9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global check img img1 img2 cam HSV H S V imgTh slide imgTh1 imgTh2
check = 0;
slide(9)= get(hObject,'Value');
set(handles.Edit9, 'String', num2str(slide(9)));
while (check==0)
   Pre_Processing();
   axes(handles.axes1);
   imagesc(img2);
   axes(handles.axes2);
   imagesc(H);
   axes(handles.axes3);
   imagesc(S);
   axes(handles.axes4);
   imagesc(V);
   axes(handles.axes5);
   imagesc(imgTh);
   axes(handles.axes6);
   imagesc(imgTh1);
   axes(handles.axes7);
   imagesc(imgTh2);
   drawnow; 
end
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function Edit7_Callback(hObject, eventdata, handles)
% hObject    handle to Edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Edit7 as text
%        str2double(get(hObject,'String')) returns contents of Edit7 as a double


% --- Executes during object creation, after setting all properties.
function Edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Edit8_Callback(hObject, eventdata, handles)
% hObject    handle to Edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Edit8 as text
%        str2double(get(hObject,'String')) returns contents of Edit8 as a double


% --- Executes during object creation, after setting all properties.
function Edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Edit9_Callback(hObject, eventdata, handles)
% hObject    handle to Edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Edit9 as text
%        str2double(get(hObject,'String')) returns contents of Edit9 as a double


% --- Executes during object creation, after setting all properties.
function Edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key release with focus on figure1 or any of its controls.
function figure1_WindowKeyReleaseFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.FIGURE)
%	Key: name of the key that was released, in lower case
%	Character: character interpretation of the key(s) that was released
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) released
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object deletion, before destroying properties.
function figure1_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global check
check = 1;
clear all


% --- Executes during object creation, after setting all properties.
function axes2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes2



function cp1_Callback(hObject, eventdata, handles)
% hObject    handle to cp1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global compare
compare(1) = str2double(get(hObject,'String'));
% Hints: get(hObject,'String') returns contents of cp1 as text
%        str2double(get(hObject,'String')) returns contents of cp1 as a double


% --- Executes during object creation, after setting all properties.
function cp1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cp1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cp2_Callback(hObject, eventdata, handles)
% hObject    handle to cp2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global compare
compare(2) = str2double(get(hObject,'String'));
% Hints: get(hObject,'String') returns contents of cp2 as text
%        str2double(get(hObject,'String')) returns contents of cp2 as a double


% --- Executes during object creation, after setting all properties.
function cp2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cp2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cp3_Callback(hObject, eventdata, handles)
% hObject    handle to cp3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global compare
compare(3) = str2double(get(hObject,'String'));
% Hints: get(hObject,'String') returns contents of cp3 as text
%        str2double(get(hObject,'String')) returns contents of cp3 as a double


% --- Executes during object creation, after setting all properties.
function cp3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cp3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cp4_Callback(hObject, eventdata, handles)
% hObject    handle to cp4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global compare
compare(4) = str2double(get(hObject,'String'));
% Hints: get(hObject,'String') returns contents of cp4 as text
%        str2double(get(hObject,'String')) returns contents of cp4 as a double


% --- Executes during object creation, after setting all properties.
function cp4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cp4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cp5_Callback(hObject, eventdata, handles)
% hObject    handle to cp5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global compare
compare(5) = str2double(get(hObject,'String'));
% Hints: get(hObject,'String') returns contents of cp5 as text
%        str2double(get(hObject,'String')) returns contents of cp5 as a double


% --- Executes during object creation, after setting all properties.
function cp5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cp5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cp6_Callback(hObject, eventdata, handles)
% hObject    handle to cp6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global compare
compare(6) = str2double(get(hObject,'String'));
% Hints: get(hObject,'String') returns contents of cp6 as text
%        str2double(get(hObject,'String')) returns contents of cp6 as a double


% --- Executes during object creation, after setting all properties.
function cp6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cp6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cp7_Callback(hObject, eventdata, handles)
% hObject    handle to cp7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global compare
compare(7) = str2double(get(hObject,'String'));
% Hints: get(hObject,'String') returns contents of cp7 as text
%        str2double(get(hObject,'String')) returns contents of cp7 as a double


% --- Executes during object creation, after setting all properties.
function cp7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cp7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cp8_Callback(hObject, eventdata, handles)
% hObject    handle to cp8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global compare
compare(8) = str2double(get(hObject,'String'));
% Hints: get(hObject,'String') returns contents of cp8 as text
%        str2double(get(hObject,'String')) returns contents of cp8 as a double


% --- Executes during object creation, after setting all properties.
function cp8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cp8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cp9_Callback(hObject, eventdata, handles)
% hObject    handle to cp9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global compare
compare(9) = str2double(get(hObject,'String'));
% Hints: get(hObject,'String') returns contents of cp9 as text
%        str2double(get(hObject,'String')) returns contents of cp9 as a double


% --- Executes during object creation, after setting all properties.
function cp9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cp9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
