function [r] = over_lap(a,m)

r=zeros(size(a,1),size(a,2));
for i=1:size(a,1)
    for j=1:size(a,2)
        if(m(i,j)>0)
        r(i,j)=a(i,j);
        end
    end
end
end