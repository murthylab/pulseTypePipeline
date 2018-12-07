function varargout=colorLines(varargin)
% COLORLINES - Apply a colormap to lines in plot
%
%   COLORLINES finds all lines in an axis and specifies their
%   colors according to a custom
%   colormaps in the form of a n x 3 matrix.
%
% OPTIONS and SYNTAX
%   colorLines() - with no inputs, colorLines finds all lines in the
%   current axis and applies the colormap 'jet'.
%   colorLines(AX,CMAP) - will find all lines
%   in the specified axis AX and applies the colormap CMAP.
%   colorLines(CMAP) - will find all lines
%   in the current axis (GCA) and applies the colormap CMAP.
%
% SEE ALSO  cmaplines, colormap


%default values
ax=gca;
cmap=jet;
fillflag=0;
plotType = 'line';
switch nargin
   case 0
      ax = gca;
      cmap = jet;
   case 1
      ax = gca;
      cmap = varargin{1};
   case 2
      ax = varargin{1};
      cmap = varargin{2};
   case 3
      ax = varargin{1};
      cmap = varargin{2};
      plotType = varargin{2};
end
m=size(cmap,1);
lh=num2cell(findobj(ax,'type',plotType));
numlines=numel(lh);

if isempty(lh)
   fprintf('No lines present in specified axes.\n')
end

%if needed, interpolate colormap to number of lines
if numlines~=m
   int=m/numlines;
   ivec=1:m;
   ovec=1:int:1+(numlines-1)*int;
   
   cmap=num2cell(cmap,1);
   cmap=cellfun(@(x)(interp1(ivec,x,ovec,...
      'linear')'),cmap,'uni',0);
   colrs=num2cell(cell2mat(cmap),2);
else
   colrs=num2cell(limit(cmap,0,1),2);
end
% avoid limit to [0 1]
colrs = cellfun(@limit, colrs, 'UniformOutput', false);
%apply colors to lines
cellfun(@(x,y)(set(x,'color',y)),lh,colrs);

if strcmpi(get(lh{1},'marker'),'none')~=1 && ...
      fillflag==1;
   cellfun(@(x,y)(set(x,'markerfacecolor',y)),...
      lh,colrs);
end

%output
if nargout>0
   varargout{1}=cell2mat(lh);
end
if nargout>1
   varargout{2}=cell2mat(colrs);
end






