function [Result] = HistMatch(I, R)
close all
I_ = I;
R_ = R;
Result = zeros(size(I));

for Channel = 1:3
    if size(R, 2) > 1
        if size(R, 3) > 1
            R_ = R(:, :, Channel);
        end
        [countR, ~] = imhist(R_);
        %pR=countR/(size(R_,1)*size(R_,2));
        pR = countR / numel(R_);
    else
        pR = R_;
    end
    
    G = 255 * cumsum(pR);
    G = round(G);
    
    if size(I, 3)>1
        I_ = I(:, :, Channel);
    end
    
    [S] = HistEquTrans(I_);
    F = zeros(size(G));
    min = 1000000;
    minIndex = -1;
    
    for i = 1:size(S,1)
        for j = 1:size(G,1)
            T = abs(S(i, 1) - G(j, 1));
            if T==0
                minIndex = j;
                break
            elseif T < min
                minIndex = j;
                min = T;
            end
        end
        F(i, 1) = minIndex;
        minIndex = -1;
        min = 1000000;
    end
    
    result = zeros(size(I_(:)));
    
    for k = 1:size(F, 1)
        indecies = I_==k-1;
        result(indecies) = F(k, 1);
    end
    
    Result(:, :, Channel) = reshape(uint8(result), size(I_));
end

Result = Result / 255;
end

function [s] = HistEquTrans(i)
L = 256;

if(size(i, 3) > 1)
    i = rgb2gray(i);
end

temp = i(:);
[counts, ~] = imhist(temp);
p = counts / size(temp, 1);
s = (L-1) * cumsum(p);
s = round(s);
end