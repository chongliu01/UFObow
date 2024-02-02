%HSV3dPlotDisplay

% RGBdata should be a Nx3 matrix 
% DataMin and DataMax should be 1x3 vectors (RGB min and max values used for normalization)

function HSclustering(RGBdata,DataMin,DataMax,kopt)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Warnings
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

% RGB to HSV conversion
HSVdata=rgb2hsv(RGBdata);
theta=HSVdata(:,1).*2*pi;
output(:,1)=HSVdata(:,2).*cos(theta);
output(:,2)=HSVdata(:,2).*sin(theta);
% for i=1:row
%      output(i,:) = [HSVdata(i,2)*cos(theta(i)),HSVdata(i,2)*sin(theta(i))];
% end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% HS 2d plot
% scrsz = get(0,'ScreenSize');set(gcf,'Position',scrsz);
set(gcf,'Position',[300 0 1000 1000]);
% Graph frame
circleangle=0:pi/1000:2*pi;
RGBcircle=hsv2rgb([circleangle'/(2*pi) circleangle'.*0+1 circleangle'.*0+1]);
for i=1:size(RGBcircle,1)
    plot(cos(circleangle(i)),sin(circleangle(i)),'o','LineWidth',3,'MarkerEdgeColor',RGBcircle(i,:),'MarkerFaceColor',RGBcircle(i,:),'MarkerSize',2,'handlevisibility','off');hold on;
end
plot(0.5*cos(circleangle),0.5*sin(circleangle),'--','LineWidth',1,'color',[0.5 0.5 0.5],'handlevisibility','off');
plot(0.25*cos(circleangle),0.25*sin(circleangle),'--','LineWidth',1,'color',[0.5 0.5 0.5],'handlevisibility','off');
plot(0.75*cos(circleangle),0.75*sin(circleangle),'--','LineWidth',1,'color',[0.5 0.5 0.5],'handlevisibility','off');
plot([-1 1],[0 0],'--','LineWidth',1,'color',[0.5 0.5 0.5],'handlevisibility','off');
plot([0 0],[-1 1],'--','LineWidth',1,'color',[0.5 0.5 0.5],'handlevisibility','off');
text(0.04, -0.03, '0', 'horizontalalignment', 'center','FontSize',12,'FontWeight','bold','color',[0 0 0]);
text(0.54, -0.03, '0.5', 'horizontalalignment', 'center','FontSize',12,'FontWeight','bold','color',[0 0 0]);
text(1.04, -0.03, '1', 'horizontalalignment',  'center','FontSize',12,'FontWeight','bold','color',[0 0 0]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% k-means clustering
opts = statset('Display','final');
[idx,ctrs] = kmeans(output,kopt,'Distance','sqEuclidean','Replicates',100,'Options',opts);
%returns the k cluster centroid locations in the k-by-p matrix ctrs

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Plot HSV data points
colormap(jet);
CC=colormap;
ClusterNumber=[];

for k=1:kopt
    ii=round(1+(k-1)*63/(kopt-1));
    coloridx(k,:)=[CC(ii,1) CC(ii,2) CC(ii,3)];
    plot(output(idx==k,1),output(idx==k,2),'o','LineWidth',1,'MarkerEdgeColor',coloridx(k,:),'MarkerFaceColor',coloridx(k,:));hold on;
    ClusterNumber=[ClusterNumber;sprintf('Cluster % 3d',k)];
end
disp(ClusterNumber)
%聚类�?
plot(ctrs(:,1),ctrs(:,2),'kx','MarkerSize',10,'LineWidth',1);
plot(ctrs(:,1),ctrs(:,2),'ko','MarkerSize',10,'LineWidth',1);
ClusterNumber=['Centroids  ';ClusterNumber];
legend1(ClusterNumber,'Location','northwest','fontsize',8);

axis equal;
set(gca,'LineWidth',1,'FontSize',12,'FontWeight','bold');
set(gca,'XTick',[],'YTick',[])
axis([-1.1 1.1 -1.1 1.1]);box off;
set(gca, 'visible', 'off');
text(-1,1, 'Hue (Angle)', 'horizontalalignment', 'left','FontSize',12,'FontWeight','bold','color',[0 0 0]);
text(-1,0.95, '& Saturation (Radius)', 'horizontalalignment', 'left','FontSize',12,'FontWeight','bold','color',[0 0 0]);
