function data = normalizeMean(data)
%NORMALIZE DATA, such that mean=0, std=1
%   data = normalize(data)
%ARGS
%   data
%RETURNS
%   normalized data
%
% created 06/11/09 janc

if (size(data,1)==1 || size(data,2)==1)
   data = data - nanmean(data);
   if not( std(data)==0)
      data = data/(nanstd(data)+eps);
   end
else
   for cat = 1:size(data,1)
      data(cat,:) = data(cat,:)-nanmean(data(cat,:));
      data(cat,:) = data(cat,:)/(nanstd(data(cat,:))+eps);
   end
end
