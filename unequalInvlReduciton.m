function dstData, dstTimeSerial = unequalInvlRection(inputData,inputTimeSerial compressedRatio)
srcData = inputData;
srcTimeSerial = inputTimeSerial;
src = struct('index', 1,'value'. 0);
for i=1:length(srcData)
    src(i).index = srcTimeSerial(i);
    src(i).value = srcData(i);
end
dstRatio = compressedRatio;
ratio = 1;
srcIndex = 1:length(src);
maxStep = length(src)-2;
nowStep = maxStep;

dst = struct('index', 1, 'value', 0);

dstData = [];
dstTimeSerial = [];
fitError = struct('index', 1, 'value',0);
for i=1:length(srcData)
    fitError(i).index = 0;
    fitError(i).value = 0;
end
maxError = struct('index', 1, 'value',0);
for i=1:maxStep

    %%generate fitting error serial
    for j=1:nowStep
        interval = 0;
        previousValue = 0;
        previousIndex = 0;
        fitValue  0;
        fitIndex = 0;
        forwardValue = 0;
        forwardIndex = 0;

        %%find previous value
        while interval < nowStep-j
            index = j+interval;
            if srcIndex[index] != 0
                previousValue = src[index];
                previousIndex = index;
                break;
            end
            interval = interval+1;
        end
        interval = interval+1;

        %%find fit value
        while interval < nowStep-j
            index = j+interval;
            if srcIndex[index] != 0
                fitValue = src[index];
                fitIndex = index;
                break;
            end
            interval = interval+1;
        end
        interval = interval+1;

        %%find forward value
        while interval < nowStep-j
            index = j+interval;
            if srcIndex[index] != 0
                forwardValue = src[index];
                forwardIndex = index;
                break;
            end
            interval = interval+1;
        end

        %%start caculate fitting error 
        k = (forwardValue-previousValue)/(forwardIndex - previousIndex);
        fitError(j).value = power((firValue - (previousValue + k*(fitIndex-previousIndex)), 2);
        fitError(j).index = fitIndex;
    end

    %% min = findMinIndex();
    dst(i).value = min.value;
    dst(i).index = min.index;
    
    if ratio <= dstRatio
        break;
    end
end

%%sortIndex();

for i=1:newLength
    dstData(i) = dst(i).value;
    dstTimeSerial(i) = dst(i).index;
end

print(dstData);
print(dstTimeSerial);

end

function min = findMinIndex(input)
minIndex = 1;
minFitError = input(1).value;
fError = 0;
for i=1:length(input)
    fError = input(i).value;
    if minFitError > input(i).value
        minFitError = input(i).value;
        minIndex = input(i).index;
    end
end
min = minIndex;
end

function sortArray = sortIndex(input)
%%using bubble sort algorithm
temp
for i=1:length(input)
end