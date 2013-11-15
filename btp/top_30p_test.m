 
function [r]=top_30p_test(list)
  [sort_val sort_idx]=sort(list(:),'descend');

 
 p=0.30;
 number=size(sort_val,1);
 idx=uint16(p*number);
 x=1;
 y=idx;
 r=sum(sort_val(x:y))/double(y-x);
end