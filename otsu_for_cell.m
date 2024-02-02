 for i=351:400
    n0=num2str(i,'%05d'); 
    name1=['merge_',n0,'_CH1.tif'];
    name2=['merge_',n0,'_CH2.tif'];
    name3=['merge_',n0,'_CH3.tif'];%输入文件路径
    A1=imread(name1);
    A2=imread(name2);
    A3=imread(name3);%读取三通道文件
    M=cat(3,A1,A2,A3);%%合并三通道
    N=max(M,[],3);
    N=imadjust(A1);%调对比度
    X1 = medfilt2(N,[5,5]);%中值滤波
    level = graythresh(X1);%提取灰度阈值
    BW = imbinarize(X1,level*2.6);%%2.95调整
    filename=['Z:\hjh\20220406\ZYJ\200-500-new\roi\roi_',num2str(i),'.tif'];
    Y1 = bwareaopen(BW,100);%%为了去除小于一百像素点的连通域
    Y1=removeLargeArea(Y1,2000);%》1000
    Y1=uint8(Y1);
    Z1=uint8(Y1).*255;
    imwrite(Z1,filename,'tif')
    CH1_light = Y1.*A1;%%去背景
    CH2_light = Y1.*A2;
    CH3_light = Y1.*A3;
    filename3=['Z:\hjh\20220406\ZYJ\200-500-new\cell\c1_',num2str(i),'.tif'];
    filename4=['Z:\hjh\20220406\ZYJ\200-500-new\cell\c2_',num2str(i),'.tif'];
    filename5=['Z:\hjh\20220406\ZYJ\200-500-new\cell\c3_',num2str(i),'.tif'];%存文件目录
    imwrite(CH1_light,filename3,'tif')
    imwrite(CH2_light,filename4,'tif')
    imwrite(CH3_light,filename5,'tif')%存文件
  end

