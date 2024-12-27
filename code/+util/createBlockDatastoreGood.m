function bimdsGood = createBlockDatastoreGood(goodFiles, blockSize)

% create blocked images from specified files
blockedImages = blockedImage(goodFiles);

% select blocks with higher offsets so that lesser blocks are chosen 
roadLocations = selectBlockLocations(blockedImages, ...
    BlockSize=blockSize, ...
    BlockOffsets=blockSize*2, ExcludeIncompleteBlocks=true);

% create blocked image datastore with selected block locations
bimdsGood = blockedImageDatastore(blockedImages, ...
    BlockLocationSet=roadLocations);

end