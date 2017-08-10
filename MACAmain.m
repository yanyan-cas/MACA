clc;
clear ALL;
%%
% Data generation

bitSize = 4;
pattern = zeros(1, 2^bitSize);

for i = 1 : 2^bitSize
    pattern(i) = i;
end

numOne = 2^(bitSize -1) - unidrnd(4);
numTwo = 2^(bitSize -1) - unidrnd(4);
temp = randperm(2^bitSize);

classOne = zeros(1, numOne);
for i = 1 : numOne
    classOne(i) = temp(i) - 1; %for n bits, the decimal num is 0 to 2^n -1
end

classTwo = zeros(1, numTwo);
for i = 1 : numTwo
    classTwo(i) = temp(2^bitSize+1-i) - 1;
end
%%
% convert data into binary logical vectors
patternOne = true(numOne, bitSize);
patternTwo = true(numTwo, bitSize);

for i = 1 : numOne
    patternOne(i,:) = dec2bin(classOne(i), bitSize) == '1';
end

for i = 1 : numTwo
    patternTwo(i,:) = dec2bin(classTwo(i), bitSize) == '1';
end
%%
% step 1: compute the XOR set
xorSet = true(numOne*numTwo, bitSize);
for i = 1 : numOne
    for j = 1 : numTwo
        xorSet(i*j,:) = xor(patternOne(i,:), patternTwo(j,:));
    end
end

%%`
%step 2: binarize X, delete the same vector
xorBin = unique(xorSet,'rows');

%%
%step 3: find p

%find the least significant position
%identify the minimum set of columns 
index = 0;
x_temp = xorBin;
k = 0;
move = zeros(1, bitSize);
signal = 0;
while index < size(xorBin, 1)
    
    [M, N] = findMostSignificantColunm(x_temp);
    index = index + size(M, 1);
 
    x_temp(:, N) = 0;
    for i = M
        x_temp(i, :) = 0;
    end
    k = k + 1;
    move(1, k) = N; %keep a record for each column number
end

%the first is the least significant in move
%the most significant is the first in L
tmp = length(find(move(1, :) ~= 0));
L = fliplr(move(1, 1:tmp));

%get p
P = size(L, 2);
%%
%step 4
%reorganize the input patterns
%generate the reorganize rules
tempL = zeros(1, bitSize-P);
j = 0;
for i = 1 : bitSize
        if(~ismember(i, L))
            j = j + 1;
            tempL(1, j) = i;
        end   
end
reOrganRule = [L, tempL];
    
rePatternOne = patternOne(:, reOrganRule);
rePatternTwo= patternTwo(:, reOrganRule);
% compute the XOR of the re-organized patterns
rexorSet = true(numOne*numTwo, bitSize);
for i = 1 : numOne
    for j = 1 : numTwo
        rexorSet(i*j,:) = xor(rePatternOne(i,:), rePatternTwo(j,:));
    end
end
 
%%
%step 5
T_p = eye(P);

%%
%step 6 - Binary Decision Diagram BDD optimisation technique
%to make sure that the modified T_p . X' ~=0


%BDD optimisation algorithm????



%%
%step 7 - Construction of the T














