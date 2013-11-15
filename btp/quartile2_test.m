 
function [r]=quartile2_test(list)
  [sort_val sort_idx]=sort(list(:),'descend');

 
 p=0.25;
 number=size(sort_val,1);
 idx=uint16(p*number);
 x=idx;
 y=2*idx;
 r=sum(sort_val(x:y))/double(y-x);
end