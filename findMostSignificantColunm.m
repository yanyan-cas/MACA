function [row, colNum] = findMostSignificantColunm(matrix)
%search for the column has the most 1's and 
%return the column number and the rows.
    [M, N] = size(matrix);

    y = zeros(M, 1);
    x = 0;
    for i = 1 : N
        temp1 = find(matrix(:, i) == true);
        if length(temp1) >= x
            x = length(temp1);
            y = temp1;
            colNum = i; 
        end
    end
    row = y; 
end