function displayNextExample(detector, ds, minMap, maxMap)
% Display next image in the datastore with heatmap overlay

if hasdata(ds)
    I = read(ds);
    map = anomalyMap(detector,I);
    figure
    montage({I, anomalyMapOverlay(I,map,MapRange=[minMap,0.8*maxMap])}, ...
        BorderSize=[5 5]);
    title('Original image(left), Image with detector heatmap overlay(right)')
else
    disp('No more images to show.');
end
end