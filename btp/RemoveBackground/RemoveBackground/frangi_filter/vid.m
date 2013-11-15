xyloObj = VideoReader('2.avi');

nFrames = xyloObj.NumberOfFrames;
 vidHeight = xyloObj.Height;
 vidWidth = xyloObj.Width;
 
% % Preallocate movie structure.
 mov(1:nFrames) = ...
     struct('cdata', zeros(vidHeight, vidWidth, 3, 'uint8'),...
            'colormap', []);

% outputVideo = VideoWriter('vid/out7.avi');
% outputVideo.FrameRate = 30;
% open(outputVideo);
% 
 BWVideo = VideoWriter('background_removed_1.avi');
 BWVideo.FrameRate = 5;
 open(BWVideo);
 
Mask_Video = VideoWriter('filtered_5_1.avi');
 Mask_Video.FrameRate = 5;
 open(Mask_Video);

 EVideo = VideoWriter('filtered_20_!.avi');
 EVideo.FrameRate = 5;
 open(EVideo);


 % Read one frame at a time.
 for k = 100 : 120
     mov(k).cdata = read(xyloObj, k);
   


im =double(mov(k).cdata);

masked_image = separate(im,1);
writeVideo(BWVideo,uint8(masked_image.*im));

temp=rgb2gray(double(masked_image));
kk=medfilt2(temp(5:576,20:700),[5 5]);
writeVideo(Mask_Video,kk);

new_kk_20=medfilt2(temp(5:576,20:700),[20 20]);

writeVideo(EVideo,new_kk_20);




 end
%  close(outputVideo);
close(BWVideo);
close(Mask_Video);
 
close(EVideo);
