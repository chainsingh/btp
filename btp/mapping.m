function [obj_mapping,a]=mapping(pts1,pts2,label1,label2,num1,num2)
label1=label1';
label2=label2';
obj_mapping=zeros(num1,1);
a=zeros(num2,num1);

for i=1:num1
    
[x y]=find(label1==i);
xy=[x y];


pts1=uint32(pts1);
pts2=uint32(pts2);



% disp(sprintf('[%d %d],[%d %d],[%d %d]',pts1(1,1),pts1(1,2),pts1(2,1),pts1(2,2),pts1(3,1),pts1(3,2)));
for j=1:size(pts1,1)

    if (pts1(j,1)<=size(label1,1) & pts1(j,2)<=size(label1,2)... 
    & pts2(j,1)<=size(label2,1) & pts2(j,2)<=size(label2,2) ...    
    & label2(pts2(j,1),pts2(j,2))>0 & label1(pts1(j,1),pts1(j,2))>0)
     %   disp(sprintf('2nd: in loop with i=%d\t j=%d\n',i,j));
        if (label1(pts1(j,1),pts1(j,2))==i)
    
            x1=label2(pts2(j,1),pts2(j,2));
    %        disp(sprintf('%d',x1));
            temp=a(x1,i)+1;
            a(x1,i)=temp;

   % disp(sprintf('3rd: in loop with i=%d\t j=%d\n',i,j));
        end
    end
end
[val obj]=max(a(:,i));

if(val>0)
obj_mapping(i)=obj;
end
end
end