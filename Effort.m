function varargout = Effort(varargin)
% EFFORT MATLAB code for Effort.fig
%      EFFORT, by itself, creates a new EFFORT or raises the existing
%      singleton*.
%
%      H = EFFORT returns the handle to a new EFFORT or the handle to
%      the existing singleton*.
%
%      EFFORT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EFFORT.M with the given input arguments.
%
%      EFFORT('Property','Value',...) creates a new EFFORT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Effort_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Effort_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Effort

% Last Modified by GUIDE v2.5 18-Mar-2016 21:11:51

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Effort_OpeningFcn, ...
                   'gui_OutputFcn',  @Effort_OutputFcn, ...
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


% --- Executes just before Effort is made visible.
function Effort_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Effort (see VARARGIN)

% Choose default command line output for Effort
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Effort wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Effort_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Analyze.
function Analyze_Callback(hObject, eventdata, handles)
% hObject    handle to Analyze (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% mu is width of the filter, approximat
clear;
[filename,filepath]=uigetfile();
result=zeros(1,12);
elevation=zeros(1,12);
load(filename);
for j=1:12
%j=3;
if j==4
    continue;
end;
original=val(j,:);



length=size(original);
    var=length(2);
    half=var/2;
    left=half-2000;
    right=half+2000;
    
    index=left:right;
    
n=10000;
mu = 5;
m = 101; % total size of the filter, odd number is better
h = build_gaussian_filter(m,mu/(4*n),n);
denoised = perform_convolution(original,h);
[B,A]=butter(2,0.05);
denoisedecg=filter(B,A,denoised);

s1=size(denoisedecg);
s2=s1(1);

peak = findrpeak(denoisedecg,index);
x=peak;
y=denoisedecg(peak);

   
n1=x-250;
n2=x+400;
if(n2>s2)
    n2=s2;
end
if(n1<1)
    n1=1;
end

indexnew=n1:n2;
ecgnew=denoisedecg(indexnew);
snew=size(ecgnew);
for i=1:snew(1)
    if(ecgnew(i)==y)
        x1=i;
        break;
    end
end

klength=snew(1);
isoline=isoelectric(ecgnew,klength);
ecgnew=ecgnew-isoline;
y1=y-isoline;
if j==2 || j==3 || j==6
    elevation(j)=stelevation_inferior(x1,y1,ecgnew,0);
else
    if j==9 || j==10 
        elevation(j) = stelevation_anterior(x1,y1,ecgnew,0);
    else
        if j==7 || j==8
            elevation(j) = stelevation_septal(x1,y1,ecgnew,0);
        else
            elevation(j)=stelevation_new(x1,y1,ecgnew,0);
        end
    end
end
%elevation=1;
%result(j)=elevation;
subplot(3,4,j);
hold on;
plot(ecgnew);
hold on;
plot(x1,y1,'*');
hold on;
xiso=[1:651];
yiso=zeros(1,651);
plot(xiso,yiso);
if(j==1)
    title(['lead i ',int2str(elevation(j))]);
end
if(j==2)
    title(['lead ii',int2str(elevation(j))]);
end
if(j==3)
    title(['lead iii',int2str(elevation(j))]);
end
if(j==4)
    title(['lead avR',int2str(elevation(j))]);
end
if(j==5)
    title(['lead avL',int2str(elevation(j))]);
end
if(j==6)
    title(['lead avF',int2str(elevation(j))]);
end
if(j==7)
    title(['lead V1',int2str(elevation(j))]);
end
if(j==8)
    title(['lead V2',int2str(elevation(j))]);
end
if(j==9)
    title(['lead V3',int2str(elevation(j))]);
end
if(j==10)
    title(['lead V4',int2str(elevation(j))]);
end
if(j==11)
    title(['lead V5',int2str(elevation(j))]);
end
if(j==12)
    title(['lead V6',int2str(elevation(j))]);
end
%grid on;
end
sti=elevation(2)+elevation(3)+elevation(6);
stl=elevation(1)+elevation(5)+elevation(11)+elevation(12);
flag=0;
if sti>=2 && stl>=3
    r1='Infero-Lateral';
    flag=1;
else
if sti>=2
    r1='Inferior';
    flag=1;
end
if stl>=3
   r1='Lateral';
   flag=1;    
end
end
if elevation(7)==1 && elevation(8)==1 && elevation(9)==1 && elevation(10)==1;
   r1='Antero-septal';
   flag=1;
else
    sta=elevation(9)+elevation(10);
    if sta>=1
       r1='Anterior';
       flag=1;
    end
end
if flag==0
   r1='Healthy Control'; 
end
set(findobj('Tag','rr'),'String',r1);
    

