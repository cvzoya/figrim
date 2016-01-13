% Zoya Bylinskii (January 2016)
% figrim.mit.edu/index_eyetracking.html

% Compute the fixation locations and fixation maps from the allImages
% structure which contains individual participant fixation data.

function [averageSaliencyMap,fixLocs] = compMapsLocsForImage(allImages,j,whichusers,m,n,whichtime)
% allImages(j).userdata contains the fixations of individual participants
% for image j
% allImages(j).userdata(whichusers) selects the fixation data that will be
% accumulated into fixation maps
% [m,n] is the size of the image j
% whichtime can be 'enc','rec', or 'rec2' if applicable

if nargin < 6
    whichtime = 'enc';
end

% accumulate all fixations
allfix = [];
for i = 1:length(whichusers) 
    curdata = allImages(j).userdata(whichusers(i)).fixations;
    if ~isempty(curdata) && isfield(curdata,whichtime)
        allfix = [allfix ; curdata.(whichtime)];
    end
end

% keep only valid fixations
allfix = round(allfix);
validInd1 = find( (allfix(:,1)>0).*(allfix(:,1)<=n) );
validInd2 = find( (allfix(:,2)>0).*(allfix(:,2)<=m) );
validInd = intersect(validInd1,validInd2);
allfix = allfix(validInd,:);

% save fixation locations in matrix
fixLocs = zeros(m,n);
for ii = 1:size(allfix,1)
    x = allfix(ii,2); y = allfix(ii,1); 
    fixLocs(x,y) = fixLocs(x,y) + 1;
end

% convolve with Gaussian and normalize
averageSaliencyMap = run_antonioGaussian(double(fixLocs), 33);
m1 = min(averageSaliencyMap(:));
m2 = max(averageSaliencyMap(:));
averageSaliencyMap = (averageSaliencyMap - m1)/(m2-m1);
%subplot(1,2,1); imshow(averageSaliencyMap);

%omap = heatmap_overlay( im , averageSaliencyMap, 'hot' );
%subplot(1,2,2); imshow(omap); pause;

fixLocs = fixLocs>0;

