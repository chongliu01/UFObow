% RGB3dPlotDisplay

% RGBdata should be a Nx3 matrix 
% DataMin and DataMax should be 1x3 vectors (RGB min and max values used
% for normalization)

function RGB3dPlotDisplay(RGBdata,DataMin,DataMax)

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


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% RGB 3d plot
% scrsz = get(0,'ScreenSize');set(gcf,'Position',scrsz);
set(gcf,'Position',[300 0 1000 1000]);

for i=1:size(RGBdata,1)
    plot3(RGBdata(i,1),RGBdata(i,2),RGBdata(i,3),'o','LineWidth',2,'MarkerEdgeColor',RGBdata(i,:),'MarkerFaceColor',RGBdata(i,:),'MarkerSize',5);hold on;
end
axis equal; axis vis3d;
set(gca,'LineWidth',1,'FontSize',12,'FontWeight','bold');
set(gca,'XTick',[0 0.5 1],'YTick',[0 0.5 1],'ZTick',[0 0.5 1])
axis([0 1 0 1 0 1]);box on;
xlabel('Red','FontSize',12,'color',[1 0 0]);
ylabel('Green','FontSize',12,'color',[0 1 0]);
zlabel('Blue','FontSize',12,'color',[0 0 1]);



