function [res,out] = getCrackHeatmap(sz,IV)
%#codegen

persistent mynet;

maxMap = 57.1107;
minMap = 7.4506e-09;

if isempty(mynet)
    %mynet = coder.loadDeepLearningNetwork('crackDetector_Pass2.mat','detector');
    mynet = load('crackDetector_Pass2.mat');
end

% read image
in  = reshape(IV,sz(1),sz(2),sz(3)); 

% pass in input  
%out = mynet.classify(in);
res = classify(mynet.detector,in);
map = anomalyMap(mynet.detector,in);
out = anomalyMapOverlay(in,map,MapRange=[minMap,0.8*maxMap]);
end