
function varargout = main_program(varargin)
% MAIN_PROGRAM MATLAB code for main_program.fig
%      MAIN_PROGRAM, by itself, creates a new MAIN_PROGRAM or raises the existing
%      singleton*.
%
%      H = MAIN_PROGRAM returns the handle to a new MAIN_PROGRAM or the handle to
%      the existing singleton*.
%
%      MAIN_PROGRAM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAIN_PROGRAM.M with the given input arguments.
%
%      MAIN_PROGRAM('Property','Value',...) creates a new MAIN_PROGRAM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before main_program_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to main_program_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help main_program

% Last Modified by GUIDE v2.5 03-Apr-2019 12:48:18

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @main_program_OpeningFcn, ...
    'gui_OutputFcn',  @main_program_OutputFcn, ...
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


% --- Executes just before main_program is made visible.
function main_program_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to main_program (see VARARGIN)

% Choose default command line output for main_program
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
movegui(hObject, 'center');

% UIWAIT makes main_program wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = main_program_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% menampilkan menu browse file
[filename,pathname] = uigetfile({'*.jpg'});

% jika ada file yg dipilih maka mengeksekusi perintah2 yg ada di bawahnya
if ~isequal(filename,0)
    % mereset button2
    axes(handles.axes1)
    cla reset
    set(gca,'XTick',[])
    set(gca,'YTick',[])
    
    axes(handles.axes2)
    cla reset
    set(gca,'XTick',[])
    set(gca,'YTick',[])
    
    axes(handles.axes3)
    cla reset
    set(gca,'XTick',[])
    set(gca,'YTick',[])
    
    axes(handles.axes4)
    cla reset
    set(gca,'XTick',[])
    set(gca,'YTick',[])
    
    set(handles.uitable1,'Data',[],'ForegroundColor',[0 0 0])
    set(handles.edit1,'String','')
    set(handles.edit2,'String','')
    set(handles.pushbutton2,'Enable','on')
    set(handles.pushbutton3,'Enable','off')
    set(handles.pushbutton4,'Enable','off')
    set(handles.pushbutton5,'Enable','off')
    
    % membaca file citra
    Img = imread(fullfile(pathname,filename));
    
    % menampilkan citra pada axes
    axes(handles.axes1)
    imshow(Img)
    title('Citra RGB')
    
    % menampilkan nama file citra pada edit text
    set(handles.edit1,'String',filename)
    
    % menyimpan variabel Img pada lokasi handles agar dapat dipanggil oleh
    % pushbutton yg lain
    handles.Img = Img;
    guidata(hObject, handles)
else
    return
end

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% mereset button2
axes(handles.axes2)
cla reset
set(gca,'XTick',[])
set(gca,'YTick',[])

axes(handles.axes3)
cla reset
set(gca,'XTick',[])
set(gca,'YTick',[])

axes(handles.axes4)
cla reset
set(gca,'XTick',[])
set(gca,'YTick',[])

set(handles.uitable1,'Data',[],'ForegroundColor',[0 0 0])
set(handles.edit2,'String','')
set(handles.pushbutton3,'Enable','on')
set(handles.pushbutton4,'Enable','off')
set(handles.pushbutton5,'Enable','off')

% memanggil variabel Img yang ada di lokasi handles
Img = handles.Img;
% mengkonversi ruang warna citra rgb menjadi L*a*b
cform = makecform('srgb2lab');
lab = applycform(Img,cform);
% menampilkan citra pada axes
axes(handles.axes2)
imshow(lab)
title('Citra L*a*b')

% menyimpan variabel lab pada lokasi handles agar dapat dipanggil oleh
% pushbutton yg lain
handles.lab = lab;
guidata(hObject, handles)

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% mereset button2
axes(handles.axes3)
cla reset
set(gca,'XTick',[])
set(gca,'YTick',[])

axes(handles.axes4)
cla reset
set(gca,'XTick',[])
set(gca,'YTick',[])

set(handles.uitable1,'Data',[],'ForegroundColor',[0 0 0])
set(handles.edit2,'String','')
set(handles.pushbutton4,'Enable','on')
set(handles.pushbutton5,'Enable','off')

% memanggil variabel lab yang ada di lokasi handles
%lab = handles.lab;
Img = handles.Img;
% mengekstrak komponen b dari citra L*a*b
%b = lab(:,:,2);
% melakukan thresholding terhadap komponen b
%bw = b>110; %edited
bw=im2bw(Img,0.80);
% melakukan operasi morfologi untuk menyempurnakan hasil segmentasi
%bw = imfill(bw,'holes'); %edited
bw = imfill(1-bw,'holes');
% menampilkan citra pada axes
axes(handles.axes3)
imshow(bw)
title('Citra Biner')

% menyimpan variabel bw pada lokasi handles agar dapat dipanggil oleh
% pushbutton yg lain
handles.bw = bw;
guidata(hObject, handles)

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% mereset button2
axes(handles.axes4)
cla reset
set(gca,'XTick',[])
set(gca,'YTick',[])

set(handles.uitable1,'Data',[],'ForegroundColor',[0 0 0])
set(handles.edit2,'String','')
set(handles.pushbutton5,'Enable','on')

% memanggil variabel Img dan bw yang ada di lokasi handles
Img = handles.Img;
bw = handles.bw;
% mengkonversi ruang warna citra rgb menjadi hsv
hsv = rgb2hsv(Img);
% mengekstrak komponen h, s, dan v
h = hsv(:,:,1);
s = hsv(:,:,2);
v = hsv(:,:,3);
% mengubah nilai background menjadi nol
h(~bw) = 0;
s(~bw) = 0;
v(~bw) = 0;
hsv = cat(3,h,s,v);
% menampilkan citra pada axes
axes(handles.axes4)
imshow(hsv)
title('Citra HSV')
% menghitung rata-rata nilai hue dan saturation
nilai_h = mean(mean(h));
nilai_s = mean(mean(s));
ciri = [nilai_h,nilai_s];
% menampilkan rata-rata nilai hue dan saturation pada tabel
data = cell(2,2);
data{1,1} = 'Hue';
data{2,1} = 'Saturation';
data{1,2} = nilai_h;
data{2,2} = nilai_s;
set(handles.uitable1,'Data',data,'RowName',1:2)
% menyimpan variabel ciri pada lokasi handles agar dapat dipanggil oleh
% pushbutton yg lain
handles.ciri = ciri;
guidata(hObject, handles)


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% mereset button2
set(handles.edit2,'String','')

% memanggil variabel ciri yang ada di lokasi handles
ciri = handles.ciri;

% load variabel obj
load obj
% mengujikan data uji sesuai dengan garis batas yang terbentuk
label = predict(obj,ciri);
% menampilkan hasil klasifikasi pada edit text
set(handles.edit2,'String',label)

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


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% mereset button2
axes(handles.axes1)
cla reset
set(gca,'XTick',[])
set(gca,'YTick',[])

axes(handles.axes2)
cla reset
set(gca,'XTick',[])
set(gca,'YTick',[])

axes(handles.axes3)
cla reset
set(gca,'XTick',[])
set(gca,'YTick',[])

axes(handles.axes4)
cla reset
set(gca,'XTick',[])
set(gca,'YTick',[])

set(handles.uitable1,'Data',[],'ForegroundColor',[0 0 0])
set(handles.edit1,'String','')
set(handles.edit2,'String','')
set(handles.pushbutton2,'Enable','off')
set(handles.pushbutton3,'Enable','off')
set(handles.pushbutton4,'Enable','off')
set(handles.pushbutton5,'Enable','off')
