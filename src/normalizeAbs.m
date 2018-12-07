function data = normalizeAbs(data)
%NORMALIZE DATA, such that min=0, max=1
%   data = normalize(data)
%
%ARGS
%   data
%RETURNS
%   normalized data
%
% created 06/09/19 Jan
if (size(data,1)==1 | size(data,2)==1)
   data = data-min(data);
   data = data/(max(data)+eps);
else
   for cat = 1:size(data,1)
      data(cat,:) = data(cat,:)-min(data(cat,:));
      data(cat,:) = data(cat,:)/(max(data(cat,:))+eps);
   end
end
