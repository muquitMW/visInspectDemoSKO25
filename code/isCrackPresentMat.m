function out = isCrackPresentMat(sz,IV)
%#codegen

persistent mynet;

if isempty(mynet)
    %mynet = coder.loadDeepLearningNetwork('crackDetector_Pass2.mat','detector');
    mynet = load('crackDetector_Pass2.mat');
end

% read image
in  = reshape(IV,sz(1),sz(2),sz(3)); 

% pass in input  
%out = mynet.classify(in);
out = classify(mynet.detector,in);
end