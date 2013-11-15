function [c,label,num,m]=anding(g) 

%comp, med, imadjust

r=g(:,:,1);
gl=r(5:576,20:700);
k=medfilt2(gl,[20 20]);
m = 1-double(im2bw(k, graythresh(k)));
m=medfilt2(m,[20 20]);

log=logical(m);

[label,num]=bwlabel(log,4);

% for i=1:num
% label_pts[i]=find(label==i);
% end
%c=imcomplement(r);
c=r;
c=medfilt2(c,[20 20]);
c=imadjust(c);
c=c(5:576,20:700);

[rr cc]=size(m);

for i=1:rr
    for j=1:cc
        
        if m(i,j)==0
            c(i,j)=255;

        end
    end

end

end