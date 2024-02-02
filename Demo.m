clear;close all
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Loading data
[filename,pathname]=uigetfile('*.xlsx*;*.xls*','选择文件');
if isequal(filename,0)
    msgbox('Users Selected Canceled!');
    return;
else
    str=[pathname filename];
end
RGBdata=xlsread(str);
RGBdata=RGBdata(:,1:3);
DataMin=min(RGBdata);
DataMax=max(RGBdata);

%% 确定聚类种数
 kopt=60;  %%������Ŀ 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Demo Ternary Graph Display
figure(1)
RGBTernaryPlotDisplay(RGBdata,DataMin,DataMax)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Demo Ternary Graph Display with automated k-means clustering
figure(2)
RGBTernaryPlotClustering_v1(RGBdata,DataMin,DataMax,kopt)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Demo 3d RGB Graph Display
figure(3)
RGB3dPlotDisplay(RGBdata,DataMin,DataMax)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Demo 2d HS Graph Display
figure(4)
HSclustering(RGBdata,DataMin,DataMax,kopt)
%% Save
% cd(pathname);mkdir image
% saveas(1,'image/rgb.tif')
% saveas(2,'image/rgbcluster.tif')
% saveas(3,'image/rgb-3d.tif')
% saveas(4,'image/hsvcluster.tif')
% saveas(5,'image/hsv.tif')