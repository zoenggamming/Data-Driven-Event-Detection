function [dstData, dstTimeSerial] = unequalInvlReduction(inputData,inputTimeSerial, compressedRatio)
srcData = inputData;
srcTimeSerial = inputTimeSerial;
src = struct('index', 1,'value', 0);
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
deleteArray = struct('index', 1, 'value', 0);
%dstData = [];
%dstTimeSerial = [];
fitError = struct('index', 1, 'value',0);
for i=1:maxStep
    fitError(i).index = 0;
    fitError(i).value = 0;
end
maxError = struct('index', 1, 'value',0);

compressCnt = 0;
for i=1:maxStep
    %%generate fitting error serial
    previousValue = 0;
    previousIndex = 0;
    fitValue = 0;
    fitIndex = 0;
    forwardValue = 0;
    forwardIndex = 0;
    k=0;
    for j=1:nowStep
        interval = 0;
        

        %%find previous value
        while interval <= nowStep-j
            index = j+interval;
            if srcIndex(index) ~= 0
                previousValue = src(index).value;
                previousIndex = index;
                break;
            end
            interval = interval+1;
        end
        interval = interval+1;

        %%find fit value
        while interval <= nowStep-j+1
            index = j+interval;
            if srcIndex(index) ~= 0
                fitValue = src(index).value;
                fitIndex = index;
                break;
            end
            interval = interval+1;
        end
        interval = interval+1;

        %%find forward value
        while interval <= nowStep-j+2
            index = j+interval;
            if srcIndex(index) ~= 0
                forwardValue = src(index).value;
                forwardIndex = index;
                break;
            end
            interval = interval+1;
        end

        %%start caculate fitting error 
        k = (forwardValue-previousValue)/(forwardIndex - previousIndex);
        fitError(j).value = power((fitValue - (previousValue + k*(fitIndex-previousIndex))), 2);
        fitError(j).index = fitIndex;
    end

    min = findMinIndex(fitError);
    srcIndex(min.index) = 0;
    deleteArray(i).index = min.index;
    deleteArray(i).value = min.value;
    compressCnt = compressCnt+1;
    ratio = (length(srcData)-compressCnt)/length(srcData);
    nowStep = nowStep - 1;
    if ratio <= dstRatio
        break;
    end
end

deleteArray = sortIndex(deleteArray);

indexCnt = 1;
for i=1:length(src)
    if srcIndex(i) ~= 0
        dstData(indexCnt) = src(i).value;
        dstTimeSerial(indexCnt) = src(i).index;
        indexCnt = indexCnt+1;
    end
end
figure(1);
plot(1:length(src), srcData)
% figure(2);
hold on;
plot(dstTimeSerial, dstData, '*')
figure(3);
plot(1:length(src), srcIndex)
end

function min = findMinIndex(input)
minFitError = input(1).value;
minStruct = input(1);
fError = 0;
for i=1:length(input)
    fError = input(i).value;
    if minFitError > input(i).value
        minFitError = input(i).value;
        minStruct = input(i);
    end
end
min = minStruct;
end

function sortArray = sortIndex(input)
%%using bubble sort algorithm
startIndex = 0;
inputTemp = input;
for i=1:length(inputTemp)-1
    startIndex = i+1;
    for j=startIndex:length(inputTemp)
        if inputTemp(i).index > inputTemp(j).index
            %%exchange struct
            tempStruct = inputTemp(j);
            inputTemp(j) = inputTemp(i);
            inputTemp(i) = tempStruct;
        end
    end
end
sortArray = inputTemp;
end