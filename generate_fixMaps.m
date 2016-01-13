% Zoya Bylinskii (January 2016)
% figrim.mit.edu/index_eyetracking.html

%addpath('../utils/');
%load('allImages_release.mat');
load('allImages_fillers.mat');
fixmapdir = 'FIXATIONMAPS_fillers';
fixlocdir = 'FIXATIONLOCS_fillers';

todisplay = 0; % whether or not to display the visualizations created
tosave = 1; % whether or not to save the visualizations created

%% recreate the FIXATIONMAPS and FIXATIONLOCS directories

if tosave
    mkdir(fixmapdir);
    mkdir(fixlocdir);
end

for j = 1:length(allImages)
    
    fprintf('On image %d of %d\n',j,length(allImages));
    
    whichusers = 1:length(allImages(j).userdata);
    im = imread(allImages(j).impath);
    [m,n,~] = size(im);
    [averageSaliencyMap,fixLocs] = compMapsLocsForImage(allImages,j,whichusers,m,n);
    
    curdir = fullfile(fixmapdir,allImages(j).category);
    curdir2 = fullfile(fixlocdir,allImages(j).category);
    if ~exist(curdir,'dir')
        mkdir(curdir);
        mkdir(curdir2);
    end
    
    if tosave
        imwrite(averageSaliencyMap,fullfile(curdir,allImages(j).filename));
        save(fullfile(curdir2,allImages(j).filename(1:end-4)),'fixLocs');
    end

    if todisplay
        omap = heatmap_overlay(im,averageSaliencyMap);
        figure; imshow(omap); pause
        close all;
    end
end

%% plot the fixation maps and locs generated

if todisplay
    figure;
    for i = 1:length(allImages)
        subplot(1,3,1); imshow(allImages(i).impath);
        subplot(1,3,2); imshow(fullfile(fixmapdir,allImages(i).category,allImages(i).filename));
        load(fullfile(fixlocdir,allImages(i).category,[allImages(i).filename(1:end-4),'.mat']));
        subplot(1,3,3); imshow(fixLocs); pause;
    end
end

%% plot the fixation maps on top of image

if todisplay
    figure;
    for i =50:length(allImages)
        i
        im = imread(allImages(i).impath);
        averageSaliencyMap = im2double(imread(fullfile(fixmapdir,allImages(i).category,allImages(i).filename)));
        omap = heatmap_overlay(im,averageSaliencyMap);
        imshow(omap); pause
    end
end


%% generate the spotlight fixation maps

if tosave, mkdir('SpotlightIms'); end
for j = 1:length(allImages)
    j
    whichusers = 1:length(allImages(j).userdata);
    im = imread(allImages(j).impath);
    [m,n,~] = size(im);
    [averageSaliencyMap,fixLocs] = compMapsLocsForImage(allImages,j,whichusers,m,n);
    spot = plotSpotlight(im,averageSaliencyMap,5);
    if tosave, imwrite(spot,fullfile('SpotlightIms',allImages(j).filename)); end
    
    if todisplay
        omap = heatmap_overlay(im,averageSaliencyMap);
        subplot(1,2,1); imshow(omap); 
        subplot(1,2,2); imshow(spot);
        pause
    end
end


%% plot fixation maps per observer per image

if todisplay

    perm = randperm(length(allImages));

    for jj = 1:length(allImages)
        %%
        j = perm(jj);

        im = imread(allImages(j).impath);
        [m,n,~] = size(im);

        whichusers = [];

        for ii = 1:length(allImages(j).userdata)
           if ~isempty(allImages(j).userdata(ii).fixations) && ...
                   isfield(allImages(j).userdata(ii).fixations,'enc') && ...
                   ~isempty(allImages(j).userdata(ii).fixations.enc)
               whichusers = [whichusers,ii];
           end
        end

        figure;
        d1 = floor(sqrt(length(whichusers))); d2 = ceil(length(whichusers)/d1);

        for ii = 1:length(whichusers)

            [averageSaliencyMap,fixLocs] = compMapsLocsForImage(allImages,j,whichusers(ii),m,n,'enc');

            omap = heatmap_overlay(im,averageSaliencyMap);

            subplot(d1,d2,ii); imshow(omap); 

        end

        pause; close all;
    end

end

%% plot fixation maps per observer for all 3 image repetitions (enc,rec,rec2) 

if todisplay

    perm = randperm(length(allImages));

    for jj = 1:length(allImages)
        %%
        j = perm(jj);

        im = imread(allImages(j).impath);
        [m,n,~] = size(im);

        whichusers = [];

        for ii = 1:length(allImages(j).userdata)
           if ~isempty(allImages(j).userdata(ii).fixations) && ...
                   isfield(allImages(j).userdata(ii).fixations,'enc') && ...
                   ~isempty(allImages(j).userdata(ii).fixations.enc)
               whichusers = [whichusers,ii];
           end
        end

        for ii = 1:length(whichusers)
            
            figure;

            [averageSaliencyMap,fixLocs] = compMapsLocsForImage(allImages,j,whichusers(ii),m,n,'enc');
            omap = heatmap_overlay(im,averageSaliencyMap);
            subplot(1,3,1); imshow(omap); 
            
            [averageSaliencyMap,fixLocs] = compMapsLocsForImage(allImages,j,whichusers(ii),m,n,'rec');
            omap = heatmap_overlay(im,averageSaliencyMap);
            subplot(1,3,2); imshow(omap); 
            
            [averageSaliencyMap,fixLocs] = compMapsLocsForImage(allImages,j,whichusers(ii),m,n,'rec2');
            omap = heatmap_overlay(im,averageSaliencyMap);
            subplot(1,3,3); imshow(omap); 
            
            pause; close all;

        end

        
    end

end