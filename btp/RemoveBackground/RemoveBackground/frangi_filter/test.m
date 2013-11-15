function [res]= test(image,orig)
I=double(((imcomplement(imread(image)))));
 
Ivessel=FrangiFilter2D(I);

%figure, imshow(Ivessel);
  figure,
  subplot(1,2,1), imshow(I,[]);
  subplot(1,2,2), imshow(Ivessel,[0 0.25]);
  res=medfilt2(imcomplement(I)-Ivessel,[5 5]);
  
  
 % figure, imshow(res);
end