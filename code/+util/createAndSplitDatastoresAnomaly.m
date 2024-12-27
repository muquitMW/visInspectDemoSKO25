function [dsTrainAnomalyIm, dsTrainAnomalyMasks, ...
    dsCalAnomalyIm, dsCalAnomalyMasks, dsTestAnomalyIm, dsTestAnomalyMasks] = ...
    createAndSplitDatastoresAnomaly(inputFolder, p1, p2)

% create an image datastore with input folder
imds = imageDatastore(fullfile(inputFolder, "images"), "IncludeSubfolders",true);
maskds = imageDatastore(fullfile(inputFolder, "masks"), "IncludeSubfolders",true);

% split imds files into train/test based on 'p' value
filesIdx = randperm(imds.numpartitions);

trainIdxEnd = round(p1*length(filesIdx));
trainIdx = filesIdx(1:trainIdxEnd);

calIdxEnd = trainIdxEnd+round(p2*length(filesIdx));
calIdx = filesIdx(trainIdxEnd+1:calIdxEnd);

testIdx = filesIdx(calIdxEnd+1:end);

% create train image and mask datastores
dsTrainAnomalyIm = subset(imds, trainIdx);
dsTrainAnomalyMasks = subset(maskds, trainIdx);

% create calibration image and mask datastores
dsCalAnomalyIm = subset(imds, calIdx);
dsCalAnomalyMasks = subset(maskds, calIdx);

% create test image and mask datastores
dsTestAnomalyIm = subset(imds, testIdx);
dsTestAnomalyMasks = subset(maskds, testIdx);

end