function [r]=obj_label(o,label)

r=zeros(size(label,1),size(label,2));

for i=1:size(label,1)
    for j=1:size(label,2)
        if(label(i,j)==o)
        r(i,j)=1;
        end
    end
end
end
