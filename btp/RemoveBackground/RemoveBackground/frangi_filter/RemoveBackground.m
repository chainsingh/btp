input_image_path = 'test.png';

h=fspecial('gaussian',[5 5],1);

iml=imread(input_image_path);
%figure, imshow(iml);
%imln=imfilter(iml,h,'replicate');
im = double(iml);
%figure, imshow(imln);
[masked_image] = separate(im,1);

figure, imshow(uint8(masked_image.*im));
temp=rgb2gray(double(masked_image));
kk=medfilt2(temp,[5 5]);
filename='res.png';
imwrite(kk,filename,'png');
figure, imshow((kk(5:576,20:700)));
result = test(filename,im);
figure, imshow(result(5:576,20:700));

finale=zeros(576,720,3);
for i=5:576
    for j=20:700
        if(kk(i,j)>0)
            finale(i,j,1)=im(i,j,1);
            finale(i,j,2)=im(i,j,2);
            finale(i,j,3)=im(i,j,3);
        end
    end
end
figure,imshow(uint8(finale));










% new_kk=medfilt2(temp(5:576,20:700),[10 10]);
% 
% figure, imshow((new_kk));
% 
% 
% new_kk_20=medfilt2(temp(5:576,20:700),[20 20]);
% 
% figure, imshow((new_kk_20));