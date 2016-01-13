
This data is available as a supplement to the following paper. 
If you use this data, please cite:

Zoya Bylinskii, Phillip Isola, Constance Bainbridge, Antonio Torralba, Aude Oliva.
"Intrinsic and Extrinsic Effects on Image Memorability", Vision Research (2015)

Project page: http://figrim.mit.edu

------------------------------------------------------------------
#### Data download:

630 target images: [Targets.zip](http://figrim.mit.edu/Targets.zip)

Fixation maps: [FIXATIONMAPS.zip](http://figrim.mit.edu/FIXATIONMAPS.zip)

Fixation locations: [FIXATIONLOCS.zip](http://figrim.mit.edu/FIXATIONLOCS.zip)

Annotation structure: [allImages_release.mat](https://github.com/cvzoya/figrim/blob/master/targetData/allImages_release.mat)

------------------------------------------------------------------

#### Displaying LabelMe annotations on top of images:

Download: 

[LabelMe Matlab toolbox](http://labelme2.csail.mit.edu/Release3.0/browserTools/php/matlab_toolbox.php)

[distinguishable_colors.m](www.mathworks.com/matlabcentral/fileexchange/29702-generate-maximally-perceptually-distinct-colors)

But run the [LMplot.m](https://github.com/cvzoya/figrim/blob/master/LMplot.m) provided in this directory instead of the one in the LabelMe toolbox.

```
>> im = imread(allImages(i).impath);
>> LMplot(allImages(i).annotation,im);
```

------------------------------------------------------------------

#### Using the allImages structure:

After downloading the [Targets.zip](http://figrim.mit.edu/Targets.zip), to display an image:
```
>> imshow(allImages(i).impath)
```

Computing the memorability score (HR) using the MTurk (AMT) data:
```
>> a = allImages(i).AMT_comb;
>> HR = a.hits/(a.hits+a.misses)
```

The encoding fixations of the j-th participant on the i-th image:
```
>> allImages(i).userdata(j).fixations.enc
```

Note: each image was shown to participants 3 times, denoted: encoding (enc), 
recognition (rec), second recognition (rec2). If recorded successfully for 
a particular participant, fixations may be available for any or all of these 3 times.

The (keypress) responses of the j-th participant on the i-th image:
```
>> allImages(i).userdata(j).SDT
```

Note: SDT is a 3-element vector corresponding to the recorded responses 
('signal detections') of the participant on the encoding, recognition, 
and second recognition image repetitions.

The SDT values are as follows:
1 = hit;
2 = false alarm;
3 = miss;
4 = correct rejection

So, the j-th participant recognized the i-th image on the second presentation if:
```
>> allImages(i).userdata(j).SDT(2) == 1
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

#### Retrieving the original images and annotations:

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

Note: the following pairs of images are duplicates:

Targets/highway/sun_bnjxztsvnercygxn.jpg ~            Targets/highway/sun_bdwttbytrbnqyqsk.jpg
Targets/conference_room/sun_awjucfvtjllxrtkv.jpg ~   Targets/conference_room/sun_abpqxslcljhrwmck.jpg
Targets/highway/sun_byoonkqxghujgvkh.jpg ~           Targets/highway/sun_bjitfqyiepkgfkks.jpg
Targets/highway/sun_bwrlzawyknljbhcb.jpg ~           Targets/highway/sun_auwrraazjwdcjcjg.jpg
Targets/mountain/sun_boskvwzgsvsyuhll.jpg ~          Targets/mountain/sun_bgdykfpjgudqpzlu.jpg
Targets/conference_room/sun_bzagimnxconenicn.jpg ~   Targets/conference_room/sun_bsccnfecifucnavf.jpg








