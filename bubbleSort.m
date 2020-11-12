function sortArray = bubbleSort(input)
%%using bubble sort algorithm
inputTemp = input;
startIndex = 0;
for i=1:length(inputTemp)-1
    startIndex = i+1;
    for j=startIndex:length(inputTemp)
        if inputTemp(i) > inputTemp(j)
            %%exchange struct
            tempStruct = inputTemp(j);
            inputTemp(j) = inputTemp(i);
            inputTemp(i) = tempStruct;
        end
    end
end
sortArray = inputTemp;
end