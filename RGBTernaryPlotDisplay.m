% RGBTernaryPlotDisplay

% Acknoledgments: this function is inspired by Ternplot package written by
% Carl Sandrock
% (http://www.mathworks.com/matlabcentral/fileexchange/2299-ternplot)

function RGBTernaryPlotDisplay(RGBdata,DataMin,DataMax)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Warnings
if size(RGBdata,1)<2
    msgbox('Not enough objects!');
    return;
end
if size(RGBdata,2)~=3
    msgbox('Please use 3-color data!');
    return;
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Data handle
RGBdata=double((RGBdata));

% Data normalization
RGBdata(:,1)=(RGBdata(:,1)-DataMin(1))/(DataMax(1)-DataMin(1));
RGBdata(:,2)=(RGBdata(:,2)-DataMin(2))/(DataMax(2)-DataMin(2));
RGBdata(:,3)=(RGBdata(:,3)-DataMin(3))/(DataMax(3)-DataMin(3));

R=RGBdata(:,1)./(RGBdata(:,1)+RGBdata(:,2)+RGBdata(:,3));
G=RGBdata(:,2)./(RGBdata(:,1)+RGBdata(:,2)+RGBdata(:,3));
B=RGBdata(:,3)./(RGBdata(:,1)+RGBdata(:,2)+RGBdata(:,3));

% Generate 2D ternary graph coordinates 
y = G*sin(pi/3); % y=0.866G
x = R + y*cot(pi/3);% X=0.5G+R

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Display ternary plot
set(gcf,'Position',[300 0 1000 1000]);
% scrsz = get(0,'ScreenSize');set(gcf,'Position',scrsz);%scrsz=[1,1,1920,1080]
% Plot triangle frame
patch('xdata', [0 1 0.5 0], 'ydata', [0 0 sin(pi/3) 0], 'edgecolor','k','linewidth',3,'facecolor','w','handlevisibility','on');hold on;
plot ([0 1],[-0.001 -0.001], 'color', 'k', 'linewidth',3,'handlevisibility','off');
set(gca, 'visible', 'off');

% Labels
Nticks=16; %number of major ticks
ticks=0:1/(Nticks-1):1;%刻度值
% labels = num2str(ticks'*100);% 16×3 char 数组
labels=num2str(round(ticks'*100,2));% 留2位小数再转为字符串
labelsleft = [labels repmat('   ', length(labels), 1)];% repmat重复数组副本
labelsright = [repmat('  ', length(labels), 1) labels];

% Plot labels
%right labels
lyc=ticks*sin(pi/3);lxc=1-ticks+lyc*cot(pi/3);%sin=√3/2=0.866   cot=1/√3=0.577
text(lxc, lyc, labelsright,'FontSize',10,'FontWeight','bold','color',[0 1 0]);% labelsright指定为元胞数组，给向量lxc, lyc添加不同文本

%bottom labels
lyb = ticks*0;lxb = ticks + lyb*cot(pi/3);
text(lxb, lyb-0.01, labels,'FontSize',10,'FontWeight','bold','color',[1 0 0],'VerticalAlignment','top','HorizontalAlignment','center');

%left labels
lya = (1-ticks)*sin(pi/3);lxa = lya*cot(pi/3);
text(lxa, lya, labelsleft,'FontSize',10,'FontWeight','bold','color',[0 0 1],'HorizontalAlignment','right');% 相对于位置点靠右水平对齐文本

%% Plot grid
for i = 1:Nticks-2
    plot([lxa(i+1) lxb(Nticks - i)], [lya(i+1) lyb(Nticks - i)],':k','linewidth',1,'handlevisibility','off');
    plot([lxb(i+1) lxc(Nticks - i)], [lyb(i+1) lyc(Nticks - i)],':k','linewidth',1,'handlevisibility','off');
    plot([lxc(i+1) lxa(Nticks - i)], [lyc(i+1) lya(Nticks - i)],':k','linewidth',1,'handlevisibility','off');
end;
%'handlevisibility','off'表示隐藏句柄，不显示在图例中

%% Axes labels
text(0.5, -0.06,'% Red', 'horizontalalignment', 'center','FontSize',12,'FontWeight','bold','color',[1 0 0]);
text(1-0.45*sin(pi/6)+0.07, 0.4,'% Green', 'rotation', -60, 'horizontalalignment', 'center','FontSize',12,'FontWeight','bold','color',[0 1 0]);
text(0.45*sin(pi/6)-0.07, 0.4, '% Blue', 'rotation', 60, 'horizontalalignment', 'center','FontSize',12,'FontWeight','bold','color',[0 0 1]);
set(gca,'dataaspectratio',[1 1 1]);

%% Plot RGB data points
for i=1:size(x,1)
    if ~isnan(R(i)*G(i)*B(i))
        colorm=[R(i) G(i) B(i)];
        q(i) = plot(x(i), y(i),  'o','LineWidth',2,'MarkerFaceColor',colorm,'MarkerEdgeColor',colorm);
    end
end









