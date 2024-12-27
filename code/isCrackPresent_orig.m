function out = isCrackPresent_orig(imageURL) 
%#codegen

persistent mynet;

% load net, if not loaded
if isempty(mynet)
    mynet = coder.loadDeepLearningNetwork('crackDetector_Pass2.mat','detector');
end

% read image
in = imread(imageURL);

% pass in input   
out = mynet.classify(in);