function varargout = enrol(varargin)
% ENROL MATLAB code for enrol.fig
%      ENROL, by itself, creates a new ENROL or raises the existing
%      singleton*.
%
%      H = ENROL returns the handle to a new ENROL or the handle to
%      the existing singleton*.
%
%      ENROL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ENROL.M with the given input arguments.
%
%      ENROL('Property','Value',...) creates a new ENROL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before enrol_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to enrol_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help enrol

% Last Modified by GUIDE v2.5 01-Dec-2021 21:05:53

% Begin initialization code
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @enrol_OpeningFcn, ...
                   'gui_OutputFcn',  @enrol_OutputFcn, ...
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


% --- Executes just before enrol is made visible.
function enrol_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to enrol (see VARARGIN)

% Choose default command line output for enrol
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes enrol wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = enrol_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function t_name_Callback(hObject, eventdata, handles)
% hObject    handle to t_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of t_name as text
%        str2double(get(hObject,'String')) returns contents of t_name as a double


% --- Executes during object creation, after setting all properties.
function t_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to t_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function t_age_Callback(hObject, eventdata, handles)
% hObject    handle to t_age (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of t_age as text
%        str2double(get(hObject,'String')) returns contents of t_age as a double


% --- Executes during object creation, after setting all properties.
function t_age_CreateFcn(hObject, eventdata, handles)
% hObject    handle to t_age (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in b_enroltodb.
function b_enroltodb_Callback(hObject, eventdata, handles)
% hObject    handle to b_enroltodb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% getting the field values
name = get(handles.t_name, 'string');
age = get(handles.t_age, 'string');
path1 = get(handles.t_f1, 'string');
path2 = get(handles.t_f2, 'string');
set(hObject, 'String', 'Enrolling... ');
drawnow();

% inserting the values into database
fprintf(['>> Memasukkan Nilai ke Database... ']);
load database person minutiae

%proses menyimpan data person
ind = regexp(path1, '[0-9][0-9][0-9]_[0-9]');
id1 = path1(ind:ind+4);
ind = regexp(path2, '[0-9][0-9][0-9]_[0-9]');
id2 = path2(ind:ind+4);

rec1 = struct('Name', name, 'Age', age, 'FID1', id1, 'FID2', id2);

i = size(person);
temp_struct = table2struct(person);

if i == 0
    temp_struct = rec1;
else
    temp_struct = [temp_struct; rec1];
end;

person = struct2table(temp_struct);

save database person minutiae

%proses menyimpan data minutiae

set(hObject, 'String', 'Ekstraksi minutiae pada sidikjari pertama...');
drawnow();

minu1_1 = ext_finger(imread(path1));
minu1_2 = num2cell(minu1_1);
minu1_3 = struct('ID', id1, 'X', minu1_2(:, 1), 'Y', minu1_2(:, 2), 'Type', minu1_2(:, 3));

set(hObject, 'String', 'Ekstraksi minutiae pada sidikjari kedua...');
drawnow();

minu2_1 = ext_finger(imread(path2));
minu2_2 = num2cell(minu2_1);
minu2_3 = struct('ID', id2, 'X', minu2_2(:, 1), 'Y', minu2_2(:, 2), 'Type', minu2_2(:, 3));

j = size(minutiae);
temp_struct = table2struct(minutiae);

if j == 0
    temp_struct = [minu1_3; minu2_3];
else
    temp_struct = [temp_struct; minu1_3; minu2_3];
end;

minutiae = struct2table(temp_struct);

save database person minutiae

% for clearing the fields
set(handles.t_name, 'string', '');
set(handles.t_age, 'string', '');
set(handles.t_f1, 'string', '');
set(handles.t_f2, 'string', '');
set(hObject, 'String', 'Enrol ke database');
drawnow();


fprintf(['Selesai!\n']);


function t_f1_Callback(hObject, eventdata, handles)
% hObject    handle to t_f1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of t_f1 as text
%        str2double(get(hObject,'String')) returns contents of t_f1 as a double


% --- Executes during object creation, after setting all properties.
function t_f1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to t_f1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in b_f1.
function b_f1_Callback(hObject, eventdata, handles)
% hObject    handle to b_f1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename1, pathname1] = ...
    uigetfile('*.bmp','Pilih sidik jari pertama');
    Img = imread(fullfile(pathname1, filename1));
    axes(handles.axes1)
    imshow(Img);
set(handles.t_f1, 'string', [pathname1 filename1]);


function t_f2_Callback(hObject, eventdata, handles)
% hObject    handle to t_f2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of t_f2 as text
%        str2double(get(hObject,'String')) returns contents of t_f2 as a double


% --- Executes during object creation, after setting all properties.
function t_f2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to t_f2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in b_f2.
function b_f2_Callback(hObject, eventdata, handles)
% hObject    handle to b_f2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[filename2, pathname2] = ...
    uigetfile('*.bmp','Pilih sidik jari kedua');
    Img = imread(fullfile(pathname2, filename2));
    axes(handles.axes2)
    imshow(Img);
set(handles.t_f2, 'string', [pathname2 filename2]);


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_2_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close()
authenticate
