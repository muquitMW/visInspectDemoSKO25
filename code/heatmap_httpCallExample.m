clear
%here is the matrix, you can use yours.
I = imread("crack.png");
I = imresize(I,0.4);
%I=I(1:4,1:4,1:2);
tic
% here is the code to fill in input for microservices.
sizeMeta.mwdata     = size(I);
sizeMeta.mwsize     = size(size(I));
sizeMeta.mwtype     = class(size(I));

matrixMeta.mwdata   = I(:);
matrixMeta.mwsize   = size(I(:));
matrixMeta.mwtype   = class(I);

inJson.nargout      = 2;
%inJson.rhs = {size(I),I(:)};
inJson.rhs = [sizeMeta,matrixMeta];
toc

tic
data = jsonencode(inJson);
toc

tic
% this is the testing function, you can change to crackdetection url
url = "http://heatmapdemo.c8hbajhjdee6cxev.eastus.azurecontainer.io:9910/heatmapdemo/getCrackHeatmap";
 
options = weboptions("MediaType","application/json","Timeout",30);
resp = webwrite(url, data, options);

Iout= uint8(reshape(resp.lhs(2).mwdata,resp.lhs(2).mwsize'));
toc

figure,imshow(Iout)
disp(resp.lhs(1).mwdata)