
This data is available as a supplement to the following paper. 
If you use this data, please cite:

Zoya Bylinskii, Phillip Isola, Constance Bainbridge, Antonio Torralba, Aude Oliva.
"Intrinsic and Extrinsic Effects on Image Memorability", Vision Research (2015)

Project page: http://figrim.mit.edu

------------------------------------------------------------------
#### Data download:

2k filler images: [Fillers.zip](http://figrim.mit.edu/Fillers.zip)

Fixation maps: [FIXATIONMAPS_fillers.zip](http://figrim.mit.edu/FIXATIONMAPS_fillers.zip)

Fixation locations: [FIXATIONLOCS_fillers.zip](http://figrim.mit.edu/FIXATIONLOCS_fillers.zip)

Annotation structure: [allImages_fillers.mat](https://github.com/cvzoya/figrim/blob/master/fillerData/allImages_fillers.mat)

------------------------------------------------------------------

#### Using the allImages structure:

After downloading the [Fillers.zip](http://figrim.mit.edu/Fillers.zip), to display an image:
```
>> imshow(allImages(i).impath)
```

The encoding fixations of the j-th participant on the i-th image:
```
>> allImages(i).userdata(j).fixations.enc
```

Note: unlike the target images, each filler image was shown to participants only once (enc).
The other two fields of fixations (rec, rec2) are empty for filler images. The fields have been kept
for structure consistency with the target data.

The (keypress) responses of the j-th participant on the i-th image:
```
>> allImages(i).userdata(j).SDT
```

Note: SDT is a 3-element vector corresponding to the recorded responses 
('signal detections') of the participant. For the filler images, only the first entry has been recorded
(since each filler image was only shown once).

The SDT values of relevance are:
2 = false alarm;
4 = correct rejection

So, the j-th participant false alarmed on the i-th image (i.e. mistakenly thought the filler image had repeated) if:
```
>> allImages(i).userdata(j).SDT(1) == 2
```

Note: the j-th participant is the same for all images, so if participant j 
did not see image i during the experimental setting, allImages(i).userdata(j)
will have empty fields.

------------------------------------------------------------------

#### Recomputing fixation maps:

To recreate fixation maps and fixation locations maps per image using the 
allImages structure:

(1) Download:

[antonioGaussian.m](https://github.com/cvzoya/saliency/blob/master/code_forMetrics/antonioGaussian.m)

[run_antonioGaussian.m](https://github.com/cvzoya/saliency/blob/master/code_forMetrics/run_antonioGaussian.m)

[code for visualizations](https://github.com/cvzoya/fixation-visualization)

(2) Run the [generate_fixMaps.m](https://github.com/cvzoya/figrim/blob/master/generate_fixMaps.m) file provided here

------------------------------------------------------------------

#### Retrieving the original images:

Note that unlike the target images, the filler images have not been explicitly annotated with object labels for this project. However, as the SUN database continues to grow in annotations, it is possible some of these images may have annotations (or feel free to label these images!).

To retrieve the original image from the SUN database and look up possible annotations:

Example image: airport_terminal/sun_aabkzjntjfarengi.jpg

Then the corresponding SUN database folder is: a/airport_terminal
(the first letter of the category name, followed by the category name itself)

The original full-sized image can be found at:
http://labelme.csail.mit.edu/Images/users/antonio/static_sun_database/a/airport_terminal/sun_aabkzjntjfarengi.jpg

The LabelMe annotations for this image can be found at:
http://labelme.csail.mit.edu/Release3.0/tool.html?actions=v&folder=users/antonio/static_sun_database/a/airport_terminal&image=sun_aabkzjntjfarengi.jpg

Example to download images and annotations from LabelMe and save them into a struct:
```
>> folderlist = {'users/antonio/static_sun_database/a/airport_terminal','users/antonio/static_sun_database/b/badlands'};
>> HOMEIMAGES = 'ImageDir'; HOMEANNOTATIONS = 'AnnotDir';
>> LMinstall(folderlist,HOMEIMAGES,HOMEANNOTATIONS);
>> D = LMdatabase(HOMEANNOTATIONS,HOMEIMAGES,folderlist);
```

Hint: The LabelMe toolbox function 'LMimresizecrop' can be used to resize the image and annotations jointly.
(see also 'LMvalidobjects' and 'addcroplabel')

------------------------------------------------------------------










