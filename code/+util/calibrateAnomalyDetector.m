function [anomalyThresh, calAnomalyScores, calGoodScores, minMap, maxMap] = ...
    calibrateAnomalyDetector(detector, dsCalGood, dsCalAnomalyIm)

% initialize min and max heatmap values
minMap = inf;
maxMap = -inf;

%% calculate scores for anomaly images
reset(dsCalAnomalyIm);
calAnomalyScores = zeros(1,dsCalAnomalyIm.numpartitions);
count = 1;
while hasdata(dsCalAnomalyIm)
    x = read(dsCalAnomalyIm);
    map = anomalyMap(detector,x);
    calAnomalyScores(count) = mean(map, "all");
    count = count+1;

    minMap = min(minMap,min(map,[],'all'));
    maxMap = max(maxMap,max(map,[],'all'));
end

%% calculate scores for good images
reset(dsCalGood);
calGoodScores = zeros(1,dsCalGood.numpartitions);
count = 1;
while hasdata(dsCalGood)
    x = read(dsCalGood);
    map = anomalyMap(detector,x);
    calGoodScores(count) = mean(map, "all");
    count = count+1;

    minMap = min(minMap,min(map,[],'all'));
    maxMap = max(maxMap,max(map,[],'all'));
end

%% calculate anomaly threshold
predScores = [calGoodScores'; calAnomalyScores'];
trueLabels = [false(length(calGoodScores), 1); true(length(calAnomalyScores), 1)];

anomalyThresh = anomalyThreshold(trueLabels,predScores,true);
end