function bimdsAnomaly = createBlockDatastoreAnomaly(imageFiles, maskFiles, blockSize)

% create blocked image masks 
crackLabeledImages = blockedImage(maskFiles);
crackLocations = selectBlockLocations(crackLabeledImages, BlockSize=blockSize, ...
    BlockOffsets=blockSize/2, ExcludeIncompleteBlocks=true, ...
    InclusionThreshold=0.01, Masks = crackLabeledImages);

bimdsBad = blockedImageDatastore(blockedImage(imageFiles), ...
    BlockLocationSet=convertBlockLocationSetForRGB(crackLocations));
bimdsBadMasks = blockedImageDatastore(blockedImage(maskFiles), ...
    BlockLocationSet=crackLocations);

bimdsAnomaly = combine(bimdsBad, bimdsBadMasks);

end

function trueLocationsRGB = convertBlockLocationSetForRGB(trueLocations)
blockOrigin = trueLocations.BlockOrigin;
blockOrigin(:,3) = 1;
blockSize = [trueLocations.BlockSize, 3];
trueLocationsRGB = blockLocationSet(trueLocations.ImageNumber, blockOrigin, blockSize);
end