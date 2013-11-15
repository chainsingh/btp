input_image_path = 'test.png';

im = double(imread(input_image_path));

[masked_image] = separate(im,1);

%figure, imshow(uint8(masked_image.*im));
temp=rgb2gray(double(masked_image));
kk=medfilt2(temp(5:576,20:700),[5 5]);
filename='res.png';
imwrite(kk,filename,'png');
%figure, imshow((kk));
%test(filename);
% new_kk=medfilt2(temp(5:576,20:700),[10 10]);
% 
% figure, imshow((new_kk));
% 
% 
% new_kk_20=medfilt2(temp(5:576,20:700),[20 20]);
% 
% figure, imshow((new_kk_20));