

xyloObj = VideoReader('../2.avi');

nFrames = xyloObj.NumberOfFrames;
 vidHeight = xyloObj.Height;
 vidWidth = xyloObj.Width;
 
% % Preallocate movie structure.
 mov(1:nFrames) = ...
     struct('cdata', zeros(vidHeight, vidWidth, 3, 'uint8'),...
            'colormap', []);
        
% map_matrix=zeros(10,2);       
% obj_matrix_idx=0;

start_frame=120;
end_frame=120;

%long_4 4420-4500 4000-4040 4800-4950
%2.avi  45-65 110-125
%
        
% obj_list_index=0;
% 
% obj_list=zeros(500,end_frame-start_frame+1);
% list_mapp=zeros(10,2);

        
 flag1=0;
    flag2=0;
    
    kk1=1;
 
for i=start_frame:end_frame

        mov(i).cdata = read(xyloObj, i);
        j=i+1;
         mov(j).cdata = read(xyloObj, j);
        k=j+1;
        mov(k).cdata = read(xyloObj, k);
        
J1 = mov(i).cdata;
J2 = mov(j).cdata;
J3 = mov(k).cdata;


[I1,label1,num1,m1]=anding(J1);
[I2,label2,num2,m2]=anding(J2);
[I3,label3,num3,m3]=anding(J3);

  figure,imshow(I1);
  figure,imshow(label1);
  figure,imshow(m1);
regions1 = detectMSERFeatures(I1,'ThresholdDelta',0.1);
regions2 = detectMSERFeatures(I2,'ThresholdDelta',0.1);
regions3 = detectMSERFeatures(I3,'ThresholdDelta',0.1);

  
[f1, vpts1] = extractFeatures(I1, regions1);
[f2, vpts2] = extractFeatures(I2, regions2);
[f3, vpts3] = extractFeatures(I3, regions3);

          
index_pairs1 = matchFeatures(f1, f2,'Metric','SSD') ;
matched_pts1_1 = vpts1(index_pairs1(:, 1));
matched_pts1_2 = vpts2(index_pairs1(:, 2));

index_pairs2 = matchFeatures(f2, f3,'Metric','SSD') ;
matched_pts2_1 = vpts2(index_pairs2(:, 1));
matched_pts2_2 = vpts3(index_pairs2(:, 2));


%remove the points which say mapping is more than certain limit..
 %..........remember it
[mapp1,arr1]=mapping(matched_pts1_1.Location,matched_pts1_2.Location,label1, label2,num1,num2);
[mapp2,arr2]=mapping(matched_pts2_1.Location,matched_pts2_2.Location,label2, label3,num2,num3);

% Visualize corresponding points
   cvexShowMatches(I1,I2,matched_pts1_1,matched_pts1_2);
%  cvexShowMatches(I2,I3,matched_pts2_1,matched_pts2_2);

 

 % feature points to object mapping
 [a1 b1]=HS(m1,m2);
 [a2 b2]=HS(m2,m3);
%  figure,imshow(a);
%  figure,imshow(over_lap(a,m1|m2));
%  figure,imshow(b);
%  figure,imshow(over_lap(b,m1|m2));
  


[angle_map1 sum_map1 med_map1]=obj_angles(mapp1,label1,label2,a1,b1);
[angle_map2 sum_map2 med_map2]=obj_angles(mapp2,label2,label3,a2,b2);


% logic for calculating

 for idx=1:size(angle_map1,1)
if(abs(angle_map1(idx))<40 &  abs(angle_map2(mapp1(idx)))<40)

    val=angle_map1(idx)-angle_map2(mapp1(idx));
    angle_sum=sum_map1(idx)-sum_map2(mapp1(idx));
    medi_val=med_map1(idx)-med_map2(mapp1(idx));

    val=double(-1)*sign(val)*min(abs(val),6.28-abs(val));
    medi_val=double(-1)*sign(medi_val)*min(abs(medi_val),6.28-abs(medi_val));
    angle_sum=double(-1)*sign(angle_sum)*min(abs(angle_sum),6.28-abs(angle_sum));

listt(kk1)=abs(val);
listm(kk1)=abs(medi_val);
lists(kk1)=abs(angle_sum);

kk1=kk1+1;
end
 
 end
 

% if(i==start_frame)
%     for sst=1:num1
%     obj_list_index=obj_list_index+1;
%         list_mapp(sst,1)=obj_list_index;
%         list_mapp(sst,2)=1;
%     obj_list(list_mapp(sst,1),list_mapp(sst,2))=sum_map1-sum_map2;
%     end
%         
% end
% 
% 
% if(flag1==1)
%  obj_list_index=obj_list_index+1;
%        
%  for lk=1:num1
%  if(ismember(lk,final_mapp)==0)
%      list_mapp(lk,1)=obj_list_index;
%      list_mapp(lk,2)=1;
%      obj_list(list_mapp(lk,1),list_mapp(lk,2))=sum_map1-sum_map2;
%  end
%  end
% 
% end
% 
% 
% if(num1==num2 & num2==num3 & i>start_frame)
%     flag1=0;
%     flag2=0;
% for ss=1:num1
%     final_mapp(ss)=mapp2(mapp1(ss));
%     list_mapp(ss,2)=list_mapp(ss,2)+1;
%     obj_list(list_mapp(ss,1),list_mapp(ss,2))=sum_map1-sum_map2;
% end
% elseif (num2>num1)
%     flag1=1;
% elseif (num2<num1)
%     flag2=1;
% end




% if(i==start_frame)
%     
%     for kl=1:num1
%     map_matrix(kl,1)=kl;
%     map_matrix(kl,2)=1;
%         obj_matrix(1,1,map_matrix(kl))=angle_map(kl);
%         obj_matrix(1,2,map_matrix(kl))=sum_map(kl);
%         obj_matrix(1,3,map_matrix(kl))=med_map(kl);
%     obj_matrix_idx=obj_matrix_idx+1;
%     end
% end
% 
% if(num2>num1)
%     %entry or separation of occluded objects
%     %obj_matrix_idx=obj_matrix_idx+1;
%     
%     
% elseif(num2<num1)
%        %exit or occlusion of objects 
%         exited_objs=find(mapp==0);
%         for klt=1:size(exited_objs,1)
%         map_matrix(exited_objs(klt))
%         end
% end



end
