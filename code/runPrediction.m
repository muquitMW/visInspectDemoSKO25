function runPrediction(detector, videoPath)

% initialize video reader
vr = VideoReader(videoPath);

figure;
% run through every frame
while vr.hasFrame
    % read frame
    frame = vr.readFrame();
    % get anomaly map by passing frame through anomaly detector
    map = anomalyMap(detector, frame);

    % display frame overlay with anomaly map
    imshow(anomalyMapOverlay(frame, map));

    % display title based on if crack is detected or not
    if mean(map, 'all')>detector.Threshold
        title('Crack detected')
    else
        title('No crack detected')
    end
    vr.CurrentTime = min(vr.CurrentTime + 0.3, vr.Duration);
end

end