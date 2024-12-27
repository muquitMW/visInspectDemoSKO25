function out = isCrackPresent(imageURL)

%#codegen
persistent mynet;

if isempty(mynet)
    %mynet = coder.loadDeepLearningNetwork('crackDetector_Pass2.mat','detector');
    mynet = load('crackDetector_Pass2.mat');
end

% read image
in = imread(imageURL);

% pass in input  
%out = mynet.classify(in);
out = classify(mynet.detector,in);
end