 
%% Eddie195 计算参数
%%破碎锤的原点位置为body下端面和钎杆的相切面
clc;
time_step=0.01;  %计算步长

%% %%%%%%%%%%%%%%%%% 液压参数
Q_nom = 300;     %流量（lpm）
P_nom = 210;     %工作压力（bar）
P_relief=330;    %溢流压力（bar）
P_back=15;       %背压（bar）

%% %%%%%%%%%%%%%%%%% 蓄能器参数

P_acc=70;        %蓄能器初始压力（bar）
V_accmin=2;      %蓄能器最小容积（L）
V_accmax=5;      %蓄能器最大容积（L）
V_acc=3;         %蓄能器初始容积（L）

%% %%%%%%%%%%%%%%%%% 氮气室参数
%%氮气室在活塞上方，为后腔，活塞上行 → 氮气被压缩 → 容积减小
%%预充位置时活塞最靠下，预充容积=最大容积
P_n=30;          %氮气室预充压力（bar）
V_n=24;          %氮气室预充容积（L）
V_nmin=12;       %氮气室最小容积（L）
V_nmax=24;       %氮气室最大容积（L）

%% %%%%%%%%%%%%%%%%% 活塞piston参数
m_piston =315;          %活塞质量(kg)
D=208;                  %活塞中部直径(最大)(mm)
D1=190;                 %活塞下端直径(前腔)(mm)
D2=185;                 %活塞上端直径(后腔)(mm)
D4=146;                 %活塞打击头直径(mm)
Ar=3.1416*(D^2-D2^2)/4; %活塞后腔面积(mm2)
Af=3.1416*(D^2-D1^2)/4; %活塞前腔面积(mm2)
An=3.1416*D2^2/4;       %活塞氮气腔面积(mm2)

%%%%%%%%%%%%活塞运动参数
start=200;              %活塞初始行程(向上为正,mm)
point_switch=100;       %活塞换向位置监测点

%%活塞处于最下位置时，行程为0
%%活塞3D原点在活塞最下方
strk_p=205;              %活塞全行程(mm)
x0_p=595;                %活塞行程=0mm的时候离原点的距离
ip_p=x0_p+start;         %活塞下端面初始位置(距body底面,向上为正,mm)

%% %%%%%%%%%%%%%%%%% 活塞换向阀
stroke3w2pValve= 1;                  % Maximum spool travel between closed and open orifice [mm]
minPos3w2pValve= -stroke3w2pValve;   % Position of 3-way 2-position valve for flow from P to A (& B to T) [mm]
maxPos3w2pValve= stroke3w2pValve;    % Position of 3-way 2-position valve for flow from P to B (& A to T) [mm]
areaMax3w2pValve= 400;               % Maximum opening area of 3-way 2-position valve [mm^2]

%% %%%%%%%%%%%%%%%% 钎杆tool参数
%%钎杆3D原点在钎杆最上方
m_tool=90;     %钎杆质量(kg)
D3=125;        %钎杆尾部直径(mm)
leng_t=1500;   %钎杆长度(mm)
x0_t=250;      %钎杆行程=0mm的时候离原点的距离
start_t=10;    %钎杆初始行程(向上为正,mm)
strk_t=100;    %钎杆总行程
%ip_t=x0_t+start_t;     %钎杆上端面初始位置(距body底面,向上为正,mm)
ip_t=ip_p;

%% %%%%%%%%%%%%%%%%% 物料位置
th_m=100;                 %物料厚度(mm)
ip_m=ip_t-leng_t-th_m/2-300;  %物料位置(向上为正,mm)

%% %%%%%%%%%%%%%%%%% 物料接触特性
%%rock
k_mat = 2e9;   % N/m
c_mat = 30000; % Ns/m