function C = minkowski_addition(x1, y1, C1, x2, y2, C2)
%% Minkowski Addition for two shapes with non-origin centers
% Define the vertices of the two input shapes as matrices of the form [x;y]
% (c1, c2) Define the centers of the two shapes

c1 = [0; 0];
c2 = C2-C1;

A = [x1; y1]; % polygon A
B = [x2; y2]; % polygon B

% Shift the shapes so that their centers coincide with the origin
A = A + c1;
B = B + c2;

% Compute the Minkowski sum of A and B
D = [];
for i = 1:size(A,2)
    for j = 1:size(B,2)
        D(:,end+1) = A(:,i) + B(:,j);
    end
end

% Remove duplicate vertices
D = unique(D', 'rows')';

% Compute the convex hull of the Minkowski sum vertices
K = convhull(D');

% Extract the vertices of the convex hull
C = D(:,K(1:end-1));

% Ensure that the resulting geometry is closed
if ~isequal(C(:,1), C(:,end))
    C(:,end+1) = C(:,1);
end

end
