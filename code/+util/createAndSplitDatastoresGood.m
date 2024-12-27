function [imdsTrain, imdsCal, imdsTest] = createAndSplitDatastoresGood(inputFolder, p1, p2)
%% create image datastores on specified input folder
%% and split the datastore for training, calibration, and testing based on p1, p2

% create an image datastore with input folder
imds = imageDatastore(inputFolder, "IncludeSubfolders",true);

% split imds files into train, cal, test based on 'p' value
filesIdx = randperm(imds.numpartitions);

trainIdxEnd = round(p1*length(filesIdx));
trainIdx = filesIdx(1:trainIdxEnd);

calIdxEnd = trainIdxEnd+round(p2*length(filesIdx));
calIdx = filesIdx(trainIdxEnd+1:calIdxEnd);

testIdx = filesIdx(calIdxEnd+1:end);

% create train and test image datastores
imdsTrain = subset(imds, trainIdx);
imdsCal = subset(imds, calIdx);
imdsTest = subset(imds, testIdx);

end