function varargout = PG_ON_OFF(varargin)
% PG_ON_OFF M-file for PG_ON_OFF.fig
%      PG_ON_OFF, by itself, creates a new PG_ON_OFF or raises the existing
%      singleton*.
%
%      H = PG_ON_OFF returns the handle to a new PG_ON_OFF or the handle to
%      the existing singleton*.
%
%      PG_ON_OFF('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PG_ON_OFF.M with the given input arguments.
%
%      PG_ON_OFF('Property','Value',...) creates a new PG_ON_OFF or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before PG_ON_OFF_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to PG_ON_OFF_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help PG_ON_OFF

% Last Modified by GUIDE v2.5 16-Jun-2016 19:40:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PG_ON_OFF_OpeningFcn, ...
                   'gui_OutputFcn',  @PG_ON_OFF_OutputFcn, ...
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


% --- Executes just before PG_ON_OFF is made visible.
function PG_ON_OFF_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to PG_ON_OFF (see VARARGIN)

% Choose default command line output for PG_ON_OFF
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes PG_ON_OFF wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = PG_ON_OFF_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Open_PG.
function Open_PG_Callback(hObject, eventdata, handles)
% hObject    handle to Open_PG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global g_33210A;
g_33210A=gpib('NI',0,10);
fopen(g_33210A);
set(hObject,'Foregroundcolor','r');  

% --- Executes on button press in Light_ON.
function Light_ON_Callback(hObject, eventdata, handles)
% hObject    handle to Light_ON (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global g_33210A;
fprintf(g_33210A,'OUTP ON');
set(hObject,'Foregroundcolor','r');  

% --- Executes on button press in Light_OFF.
function Light_OFF_Callback(hObject, eventdata, handles)
% hObject    handle to Light_OFF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global g_33210A;
fprintf(g_33210A,'OUTP OFF');
set(handles.Light_ON,'Foregroundcolor','k');  


% --- Executes on button press in Close_PG.
function Close_PG_Callback(hObject, eventdata, handles)
% hObject    handle to Close_PG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
g_K=instrfind('Type', 'gpib');
try
   fclose(g_K); 
end
set(handles.Open_PG,'Foregroundcolor','k');  
