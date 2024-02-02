% RGBTernaryPlotClustering
% RGBdata should be a Nx3 matrix 
% DataMin and DataMax should be 1x3 vectors (RGB min and max values used for normalization)
% kmax is the maximum number of clusters to consider

% Acknoledgments: part of this function is inspired by Ternplot package written by Carl Sandrock
% (http://www.mathworks.com/matlabcentral/fileexchange/2299-ternplot)


function RGBTernaryPlotClustering(RGBdata,DataMin,DataMax,kopt)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Warnings
% if size(RGBdata,1)<2
%     msgbox('Not enough objects!');
%     return;
% end
% if size(RGBdata,2)~=3
%     msgbox('Please use 3-color data!');
%     return;
% end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Data handle
% Data Normalization
RGBdata(:,1)=(RGBdata(:,1)-DataMin(1))/(DataMax(1)-DataMin(1));
RGBdata(:,2)=(RGBdata(:,2)-DataMin(2))/(DataMax(2)-DataMin(2));
RGBdata(:,3)=(RGBdata(:,3)-DataMin(3))/(DataMax(3)-DataMin(3));

R=RGBdata(:,1)./(RGBdata(:,1)+RGBdata(:,2)+RGBdata(:,3));
G=RGBdata(:,2)./(RGBdata(:,1)+RGBdata(:,2)+RGBdata(:,3));
B=RGBdata(:,3)./(RGBdata(:,1)+RGBdata(:,2)+RGBdata(:,3));

% Generate 2D ternary graph coordinates 
y = G*sin(pi/3);
x = R + y*cot(pi/3);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% k-means clustering
Data(:,1)=x;
Data(:,2)=y;

opts = statset('Display','off');
% [idx,~,~,D] = kmeans(Data,1,'Distance','sqEuclidean','Replicates',100,'Options',opts);
% % idx: N*1的向量，存储聚类标号
% % D：返回n*k矩阵D中每个点到每个质心的距离
% %Replicates：多次重复选取不同质心开始聚类
% % Options：迭代算法最小化拟合准则的选项，通过statset创建
% 
% for i=1:size(Data,1)% size返回data的第1个维度-行数
%     d(i)=D(i,idx(i));%distance between each point of a cluster and the cluster's centre
% end
% S(1)=sum(d.^2);%S(k) is the sum of all distorsions (k is the specified number of clusters)
% 
% Nd=2;%Number of dimensions
% alpha(1)=0;% weight factor
% alpha(2)=1-3/(4*Nd);
% f(1)=1;% evaluation function
% 
% for k=2:kmax
%     if k>2
%         alpha(k)=alpha(k-1)+(1-alpha(k-1))/6;
%     end
%     [idx,~,~,D] = kmeans(Data,k,'Distance','sqEuclidean','Replicates',100,'Options',opts);
%     for i=1:size(x,1)
%         d(i)=D(i,idx(i));
%     end
%     S(k)=sum(d.^2);
%     if S(k-1)==0
%         f(k)=1;
%     else
%         f(k)=S(k)/(alpha(k)*S(k-1));
%     end
% end
% 
% kopt=find(f==min(f));% the min of f gives the optimal k value (kopt) 
%find返回满足条件f=min的索引
[idx,ctrs] = kmeans(Data,kopt,'Distance','sqEuclidean','Replicates',100,'Options',opts);
%returns the k cluster centroid locations in the k-by-p matrix ctrs

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Display ternary plot

% figure
% scrsz = get(0,'ScreenSize');set(gcf,'Position',scrsz);%scrsz=[1,1,1920,1080]
set(gcf,'Position',[300 0 1000 1000]);

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
lyc=ticks*sin(pi/3);lxc=1-ticks+lyc*cot(pi/3);% sin=√3/2=0.866   cot=1/√3=0.577
text(lxc, lyc, labelsright,'FontSize',10,'FontWeight','bold','color',[0 1 0]);% labelsright指定为元胞数组，给向量lxc, lyc添加不同文本

%bottom labels
lyb = ticks*0;lxb = ticks + lyb*cot(pi/3);
text(lxb, lyb-0.01, labels,'FontSize',10,'FontWeight','bold','color',[1 0 0],'VerticalAlignment','top','HorizontalAlignment','center');

%left labels
lya = (1-ticks)*sin(pi/3);lxa = lya*cot(pi/3);
text(lxa, lya, labelsleft,'FontSize',10,'FontWeight','bold','color',[0 0 1],'HorizontalAlignment','right');% 相对于位置点靠右水平对齐文本

% Plot grid
for i = 1:Nticks-2
    plot([lxa(i+1) lxb(Nticks - i)], [lya(i+1) lyb(Nticks - i)],':k','linewidth',1,'handlevisibility','off');
    plot([lxb(i+1) lxc(Nticks - i)], [lyb(i+1) lyc(Nticks - i)],':k','linewidth',1,'handlevisibility','off');
    plot([lxc(i+1) lxa(Nticks - i)], [lyc(i+1) lya(Nticks - i)],':k','linewidth',1,'handlevisibility','off');
end
%'handlevisibility','off'表示隐藏句柄，不显示在图例中

% Axes labels
text(0.5, -0.06,'% Red', 'horizontalalignment', 'center','FontSize',12,'FontWeight','bold','color',[1 0 0]);
text(1-0.45*sin(pi/6)+0.07, 0.4,'% Green', 'rotation', -60, 'horizontalalignment', 'center','FontSize',12,'FontWeight','bold','color',[0 1 0]);
text(0.45*sin(pi/6)-0.07, 0.4, '% Blue', 'rotation', 60, 'horizontalalignment', 'center','FontSize',12,'FontWeight','bold','color',[0 0 1]);
set(gca,'dataaspectratio',[1 1 1]);

%% Plot RGB data points
colormap(jet);
CC=colormap;
ClusterNumber=[];

for k=1:kopt
    ii=round(1+(k-1)*63/(kopt-1));
    coloridx(k,:)=[CC(ii,1) CC(ii,2) CC(ii,3)];
    plot(Data(idx==k,1),Data(idx==k,2),'o','LineWidth',1,'MarkerEdgeColor',coloridx(k,:),'MarkerFaceColor',coloridx(k,:));hold on;
    ClusterNumber=[ClusterNumber;sprintf('Cluster % 3d',k)];
end
plot(ctrs(:,1),ctrs(:,2),'kx','MarkerSize',10,'LineWidth',1);
plot(ctrs(:,1),ctrs(:,2),'ko','MarkerSize',10,'LineWidth',1);
ClusterNumber=['Centroids  ';ClusterNumber];
legend1(ClusterNumber,'Location','NW','fontsize',8);

% for k=1:kopt
% Rmean(k)=mean(R(idx==k));Rstd(k)=std(R(idx==k));
% Gmean(k)=mean(G(idx==k));Gstd(k)=std(G(idx==k));
% Bmean(k)=mean(B(idx==k));Bstd(k)=std(B(idx==k));
% text(-0.3,1.00-(k)/10,['Cluster ',num2str(k),' <R> = ',num2str(100*Rmean(k),2),' % (+/- ',num2str(100*Rstd(k),2),' %)']);
% text(-0.3,0.98-(k)/10,['Cluster ',num2str(k),' <G> = ',num2str(100*Gmean(k),2),' % (+/- ',num2str(100*Gstd(k),2),' %)']);
% text(-0.3,0.96-(k)/10,['Cluster ',num2str(k),' <B> = ',num2str(100*Bmean(k),2),' % (+/- ',num2str(100*Bstd(k),2),' %)']);
% end
