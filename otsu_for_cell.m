 for i=351:400
    n0=num2str(i,'%05d'); 
    name1=['merge_',n0,'_CH1.tif'];
    name2=['merge_',n0,'_CH2.tif'];
    name3=['merge_',n0,'_CH3.tif'];%�����ļ�·��
    A1=imread(name1);
    A2=imread(name2);
    A3=imread(name3);%��ȡ��ͨ���ļ�
    M=cat(3,A1,A2,A3);%%�ϲ���ͨ��
    N=max(M,[],3);
    N=imadjust(A1);%���Աȶ�
    X1 = medfilt2(N,[5,5]);%��ֵ�˲�
    level = graythresh(X1);%��ȡ�Ҷ���ֵ
    BW = imbinarize(X1,level*2.6);%%2.95����
    filename=['Z:\hjh\20220406\ZYJ\200-500-new\roi\roi_',num2str(i),'.tif'];
    Y1 = bwareaopen(BW,100);%%Ϊ��ȥ��С��һ�����ص����ͨ��
    Y1=removeLargeArea(Y1,2000);%��1000
    Y1=uint8(Y1);
    Z1=uint8(Y1).*255;
    imwrite(Z1,filename,'tif')
    CH1_light = Y1.*A1;%%ȥ����
    CH2_light = Y1.*A2;
    CH3_light = Y1.*A3;
    filename3=['Z:\hjh\20220406\ZYJ\200-500-new\cell\c1_',num2str(i),'.tif'];
    filename4=['Z:\hjh\20220406\ZYJ\200-500-new\cell\c2_',num2str(i),'.tif'];
    filename5=['Z:\hjh\20220406\ZYJ\200-500-new\cell\c3_',num2str(i),'.tif'];%���ļ�Ŀ¼
    imwrite(CH1_light,filename3,'tif')
    imwrite(CH2_light,filename4,'tif')
    imwrite(CH3_light,filename5,'tif')%���ļ�
  end

