function varargout = authenticate(varargin)
%AUTHENTICATE M-file for authenticate.fig
%      AUTHENTICATE, by itself, creates a new AUTHENTICATE or raises the existing
%      singleton*.
%
%      H = AUTHENTICATE returns the handle to a new AUTHENTICATE or the handle to
%      the existing singleton*.
%
%      AUTHENTICATE('Property','Value',...) creates a new AUTHENTICATE using the
%      given property value pairs. Unrecognized properties are passed via
% %      varargin to authenticate_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      AUTHENTICATE('CALLBACK') and AUTHENTICATE('CALLBACK',hObject,...) call the
%      local function named CALLBACK in AUTHENTICATE.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help authenticate

% Last Modified by GUIDE v2.5 13-Dec-2021 00:09:49

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @authenticate_OpeningFcn, ...
                   'gui_OutputFcn',  @authenticate_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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


% --- Executes just before authenticate is made visible.
function authenticate_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for authenticate
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes authenticate wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = authenticate_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function t_f_Callback(hObject, eventdata, handles)
% hObject    handle to t_f (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of t_f as text
%        str2double(get(hObject,'String')) returns contents of t_f as a double


% --- Executes during object creation, after setting all properties.
function t_f_CreateFcn(hObject, eventdata, handles)
% hObject    handle to t_f (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in b_f.
function b_f_Callback(hObject, eventdata, handles)
% hObject    handle to b_f (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[filename2, pathname2] = ...
    uigetfile('*.bmp','Select second fingerprint', ...
    'D:\College\S6\Mini Project\Databases\FVC 2002\DB1');
    Img = imread(fullfile(pathname2, filename2));
    axes(handles.axes2)
    imshow(Img);
set(handles.t_f, 'string', [pathname2, filename2]);

% --- Executes on button press in b_authenticate.
function b_authenticate_Callback(hObject, eventdata, handles)
% hObject    handle to b_authenticate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Melakukan enchancement pada sample
% memunculkan kalimat dibawah ini pada command window
delete data_testing.mat
fprintf(['>> Melakukan Proses Thresholding\n']);
% menampilkan tulisan dibawah ini ketika authentication  di klik
set(hObject, 'string', 'Proses Thresholding...');
    path = get(handles.t_f, 'string');
    img = imread(path);
    axes(handles.axes3)
    biner = Enhancement(img);
    imshow(biner); title('Tresholding');
    
set(hObject, 'string', 'Thinning...');
% Mengambil citra Threshold untuk di Thinning
    %thin_image=bwmorph(biner,'thin',inf);
    thinning = thining(biner);
    axes(handles.axes4)
    imshow(thinning); title('Thinning');

% Melakukan ekstraksi minutiae pada sample
% memunculkan kalimat dibawah ini pada command window
fprintf(['>> Melakukan Proses Ekstraksi\n']);
% menampilkan tulisan dibawah ini ketika authentication  di klik
set(hObject, 'string', 'Ekstraksi minutiae...');
drawnow();
axes(handles.axes1)
inp_minutiae = ext_finger(img, 1);

save data_testing.mat inp_minutiae
M1_1=inp_minutiae(inp_minutiae(:,3)<5,:);
M1_2=M1_1(:,1:3);
set(handles.uitable5, 'data', M1_2);

% memunculkan kalimat dibawah ini pada command window
fprintf(['>> Membandingkan dengan database... ']);
% menampilkan tulisan dibawah ini setelah tulisan extracting minutiae
set(hObject, 'string', 'Membandingkan dengan database... ');
drawnow();

% proses sistem cerdas
load database person minutiae

uniq_1 = unique(minutiae(:, 1)); %memanggil value (jika angka sama cukup dipanggil satu kali) pada matriks kolom pertama
r = size(uniq_1(:, :)); %memanggil semua baris dan kolom pada matriks
k = size(minutiae(:, :)); %memanggil semua baris dan kolom pada matriks
uniq_2 = table2struct(uniq_1); %memanggil nama kolom pada variable uniq
uniq_3 = struct2cell(uniq_2);

first_1 = minutiae(:, 1); %memanggil matriks pada kolom pertama
first_2 = table2struct(first_1); %memanggil nama kolom pada variable first
first_3 = struct2cell(first_2); 
s = 0;

for i=1:r
    temp_struct_1 = struct('X', [], 'Y', [], 'Type', []); %struct berfungsi membuat baris dengan berisikan himpunan kosong []
    for j=1:k
        % build temporary structure of minutiae pertaining to a fingerprint
        if strcmp(uniq_3(i), first_3(j)) %strcmp berfungsi untuk membandingkan antara value dari variable uniq dan first, jika sama maka nilai 1 jika tidak sama maka nilai 0
            p = size(temp_struct_1);
            if p==0
                temp_struct_1 = table2struct(minutiae(j, 2:4));
            else
                temp_struct_1 = [temp_struct_1; table2struct(minutiae(j, 2:4))];
            end;
        end;
    end;
        
    % mendapatkan score kecocokan
    temp_struct_2 = transpose(cell2mat(struct2cell(temp_struct_1)));
    if s==0 
        M1=inp_minutiae(inp_minutiae(:,3)<5,:);
        M2=temp_struct_2(temp_struct_2(:,3)<5,:);  
                        
                        Count1=size(M1,1); Count2=size(M2,1); n=0;
                        K=15; %sumber dari jurnal
                        for i=1:Count1
                            for j=1:Count2
                                %Euclidean Distance
                                d=sqrt((M2(j,1)-M1(i,1))^2+(M2(j,2)-M1(i,2))^2);
                                if d<K
                                    if n<Count1
                                        if (M1(i,3))==(M2(j,3))
                                            n=n+1;        %Increase Score
                                        end
                                    end
                                end
                            end
                        end
                        sm=sqrt(n^2/(Count1*Count2));       %Similarity Index
                            
        s = sm;
    else
        M3=inp_minutiae(inp_minutiae(:,3)<5,:);
        M4=temp_struct_2(temp_struct_2(:,3)<5,:);  
        
                        Count1=size(M3,1); Count2=size(M4,1); n=0;
                        K=15;
                        for i=1:Count1
                            for j=1:Count2
                                %Euclidean Distance
                                d=sqrt((M4(j,1)-M3(i,1))^2+(M4(j,2)-M3(i,2))^2);
                                if d<K
                                    if n<Count1
                                        if (M3(i,3))==(M4(j,3))
                                            n=n+1;        %Increase Score
                                        end
                                    end
                                end
                            end
                        end
                        sm=sqrt(n^2/(Count1*Count2));       %Similarity Index
                        
        s = horzcat(s, sm);
    end;    
end;

% s berisi hasil-hasil dari tingkat kecocokan dari data training dgn data testing
maxim = max(s); %mengambil data s yang terbesar
len = length(s); %menghitung total jumlah data yang ada
for i=1:len
    if s(i)==maxim
        break;
    end;
end;

if (maxim<0.4) 
    fprintf(['>> Sidik Jari tidak Dikenali.\n']);
    set(handles.t_header, 'string', 'Sidik Jari tidak Dikenali.');
    %drawnow();
else
    x = round(i/2); %round untuk memberikan pembulatan pada hasil pembagian
    name = char(struct2cell(table2struct(person(x, 1))));
    fprintf(['selesai!\n>> sidik jari ditemukan! Selamat Datang ' name '!\n']);
    set(handles.t_header, 'string', ['Sidik Jari Dikenali, Hello ' name '!']);
    %drawnow();
end;

set(hObject, 'string', 'Selesai');


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close()
enrol


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox2.
function listbox2_Callback(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox2


% --- Executes during object creation, after setting all properties.
function listbox2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
