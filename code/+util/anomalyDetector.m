function detector = anomalyDetector(imageSize, options)
% create anomaly detector from specified input image size, 

arguments
    imageSize (1,2) double = [224 224];
    options.Backbone (1,1) string {mustBeMember(options.Backbone, ...
        ["alexnet", "googlenet", "inceptionresnetv2", "inceptionv3", ...
        "mobilenetv2", "resnet18", "resnet50", "resnet101", "squeezenet", ...
        "vgg16", "vgg19"])} = "googlenet";
    options.Depth (1,1) double = 3;
    options.DetectorType (1,1) string {mustBeMember(options.DetectorType, ...
        ["fcdd", "fastflow", "patchcore"])}
end

% Extract pretrained network architecture
net = pretrainedEncoderNetwork(options.Backbone,options.Depth);

% Replace input layer with specified image size
inLayer = imageInputLayer([imageSize 3], 'Normalization', 'none');
lgraph = net.layerGraph;

lgraph = replaceLayer(lgraph, 'data', inLayer);

% define anomaly detector based on specified type
switch options.DetectorType
    case "fcdd"
        detector = fcddAnomalyDetector(lgraph);
    case "fastflow"
    case "patchcore"
end

end