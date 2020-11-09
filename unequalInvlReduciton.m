function compressedArray = unequalInvlRection(input, compressedRatio)
src = input;
dstRatio = compressedRatio;
ratio = 1;
srcIndex = 1:length(src);
maxStep = length(src)-2;
nowStep = maxStep;
fitError = 1:length(src);
for i=1:maxStep
    for j=1:nowStep
        if srcIndex[j] != 0
            previousValue = src[j];
            break;
            forwardValue
        end
    end
    if ratio <= dstRatio
        break;
    end
end