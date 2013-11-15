function[ret,ret_sum,medi]=obj_angles(obj_map,label1, label2, a,b)

angles=angle(a+(b*1i));
medi=zeros(size(obj_map,1),1);
ret=zeros(size(obj_map,1),1);
ret_sum=zeros(size(obj_map,1),1);

for i=1:size(obj_map,1)
obj1=i;
obj2=obj_map(i,1);
val=50;
medi_val=50;
angle_sum=50;
if(obj1>0 & obj2>0)
l1=obj_label(obj1,label1);
l2=obj_label(obj2,label2);

final_angle=over_lap(angles,(l1|l2));
final_u=over_lap(a,(l1));
final_v=over_lap(b,(l1));

u_sum=sum(sum(final_u));
v_sum=sum(sum(final_v));


angle_sum=atan2(v_sum,u_sum);

 final_mag=sqrt((final_u.*final_u)+(final_v.*final_v));
 
 [top_val top_idx]=sort(final_mag(:),'descend');

top_p=0.01;
top_number=size(top_val,1);
top_top=uint16(top_p*top_number);

s=0.0;

medi_angles=zeros(top_top,1);
 for j=1:top_top
 s=s+angles(top_idx(j));
medi_angles(j)=angles(top_idx(j));
 end
 
 medi_val=median(medi_angles);
 val=s/double(top_top);
% 
% 
%  pos_neg=sum(new_angles);
%  if(pos_neg>0)
%     [sort_val sort_idx]=sort(new_angles,'descend');
%  else
%      disp('ascending')
%      [sort_val sort_idx]=sort(new_angles,'ascend');
%  end
%  
%  p=0.0001;
%  number=size(sort_val,1);
%  idx=uint16(p*number);
%  val=sum(sort_val(1:idx))/double(idx);
end
medi(i)=medi_val;
ret(i)=val;
ret_sum(i)=angle_sum;
end
end