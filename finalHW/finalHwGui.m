function varargout = finalHwGui(varargin)
% FINALHWGUI MATLAB code for finalHwGui.fig
%      FINALHWGUI, by itself, creates a new FINALHWGUI or raises the existing
%      singleton*.
%
%      H = FINALHWGUI returns the handle to a new FINALHWGUI or the handle to
%      the existing singleton*.
%
%      FINALHWGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FINALHWGUI.M with the given input arguments.
%
%      FINALHWGUI('Property','Value',...) creates a new FINALHWGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before finalHwGui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to finalHwGui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help finalHwGui

% Last Modified by GUIDE v2.5 02-Apr-2017 01:40:39

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @finalHwGui_OpeningFcn, ...
                   'gui_OutputFcn',  @finalHwGui_OutputFcn, ...
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


% --- Executes just before finalHwGui is made visible.
function finalHwGui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to finalHwGui (see VARARGIN)

% Choose default command line output for finalHwGui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);


% UIWAIT makes finalHwGui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = finalHwGui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in btnConnect.
function btnConnect_Callback(hObject, eventdata, handles)
% hObject    handle to btnConnect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
portName = get(handles.txtCom,'String');
contents = cellstr(get(handles.lstBR,'String'));
baudrate = str2num(contents{get(handles.lstBR,'Value')});
databits = str2num(get(handles.txtDataBits,'String'));
parity = get(handles.txtParity,'String');
stopbits = str2num(get(handles.txtStopbits,'String'));
allCom = instrfind;
for i = 1:length(allCom)
    if strcmp(allCom(i).Status,'open')
        fclose(allCom(i));
        
    end
    delete(allCom(i));
end
handles.MyPort = serial(portName,'baudrate',baudrate,'databits',databits, ...
        'parity',parity,'stopbits',stopbits);

fopen(handles.MyPort);
set(hObject,'Enable','off');
set(handles.btnDisConnect,'Enable','on');
guidata(hObject,handles);


% --- Executes on button press in btnDisConnect.
function btnDisConnect_Callback(hObject, eventdata, handles)
% hObject    handle to btnDisConnect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fclose(handles.MyPort);
delete(handles.MyPort);
set(hObject,'Enable','off');
set(handles.btnConnect,'Enable','on');


function txtCom_Callback(hObject, eventdata, handles)
% hObject    handle to txtCom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtCom as text
%        str2double(get(hObject,'String')) returns contents of txtCom as a double


% --- Executes during object creation, after setting all properties.
function txtCom_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtCom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1
contents = cellstr(get(hObject,'String'));
contents{get(hObject,'Value')};

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



function txtDataBits_Callback(hObject, eventdata, handles)
% hObject    handle to txtDataBits (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtDataBits as text
%        str2double(get(hObject,'String')) returns contents of txtDataBits as a double


% --- Executes during object creation, after setting all properties.
function txtDataBits_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtDataBits (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtParity_Callback(hObject, eventdata, handles)
% hObject    handle to txtParity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtParity as text
%        str2double(get(hObject,'String')) returns contents of txtParity as a double


% --- Executes during object creation, after setting all properties.
function txtParity_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtParity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtStopbits_Callback(hObject, eventdata, handles)
% hObject    handle to txtStopbits (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtStopbits as text
%        str2double(get(hObject,'String')) returns contents of txtStopbits as a double


% --- Executes during object creation, after setting all properties.
function txtStopbits_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtStopbits (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtDiameter_Callback(hObject, eventdata, handles)
% hObject    handle to txtDiameter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtDiameter as text
%        str2double(get(hObject,'String')) returns contents of txtDiameter as a double


% --- Executes during object creation, after setting all properties.
function txtDiameter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtDiameter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtDistance_Callback(hObject, eventdata, handles)
% hObject    handle to txtDistance (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtDistance as text
%        str2double(get(hObject,'String')) returns contents of txtDistance as a double


% --- Executes during object creation, after setting all properties.
function txtDistance_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtDistance (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit10_Callback(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit10 as text
%        str2double(get(hObject,'String')) returns contents of edit10 as a double


% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtCurDeg_Callback(hObject, eventdata, handles)
% hObject    handle to txtCurDeg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtCurDeg as text
%        str2double(get(hObject,'String')) returns contents of txtCurDeg as a double


% --- Executes during object creation, after setting all properties.
function txtCurDeg_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtCurDeg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtStep_Callback(hObject, eventdata, handles)
% hObject    handle to txtStep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtStep as text
%        str2double(get(hObject,'String')) returns contents of txtStep as a double


% --- Executes during object creation, after setting all properties.
function txtStep_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtStep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnRun.
function btnRun_Callback(hObject, eventdata, handles)
% hObject    handle to btnRun (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
conStatus = get(handles.radCon,'Value');
% if conStatus == 1
%     set(handles.radRun,'Value',1);
%     a = 0;
%     for i =0:5
%         if get(handles.radStop,'Value') == 1
%             break;
%         end
%         a = a+1
%         pause(1);
%     end
% end



r = str2num(get(handles.txtDiameter,'String'));
dist = str2num(get(handles.txtDistance,'String'));
%set imediate
if get(handles.radSingle,'Value') == 1
    ang = str2num(get(handles.txtCurDeg,'String'));
    cmdServo(handles.MyPort,ang,r,dist);
else
    if get(handles.radInc,'Value') == 1
        ang = str2num(get(handles.txtCurDeg,'String'));
        step = str2num(get(handles.txtStep,'String'));
        ang = ang + step;
        cmdServo(handles.MyPort,ang,r,dist);
        set(handles.txtCurDeg,'String',num2str(ang));
    else
        if get(handles.radDec,'Value') == 1
            ang = str2num(get(handles.txtCurDeg,'String'));
            step = str2num(get(handles.txtStep,'String'));
            ang = ang - step;
            cmdServo(handles.MyPort,ang,r,dist);
            set(handles.txtCurDeg,'String',num2str(ang));
        else
            if get(handles.radCon,'Value') == 1
                index = 1;
                step = 1;
                ang = -10:1:190;
                set(handles.radRun,'Value',1) 
                while get(handles.radRun,'Value') == 1
                     cmdServo(handles.MyPort,ang(index),r,dist);
                     set(handles.txtCurDeg,'String',num2str(ang(index)));
                     
                     if index > length(ang) -1
                         step = -1;
                     end
                     if index == 1
                        step = 1;
                     end
                     index =  index + step;
                     pause(0.02);
                end
            end
        end
    end
end



% --- Executes on selection change in lstBR.
function lstBR_Callback(hObject, eventdata, handles)
% hObject    handle to lstBR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns lstBR contents as cell array
%        contents{get(hObject,'Value')} returns selected item from lstBR


% --- Executes during object creation, after setting all properties.
function lstBR_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lstBR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
