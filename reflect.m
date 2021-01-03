%Reflects a shape S about the x or y axis
%Felipe Nuti

function S_ref = reflect(S, c)
if strcmpi(c, 'x')        % ensures that the reflection is about the x axis regardless of the case of c
    S_ref = reflectx(S);
else
    if strcmpi(c, 'y')
        S_ref = reflecty(S);
    end
end

%Reflects a shape S about the x axis
%Felipe Nuti
function S_ref = reflectx(S)
T = [1 0; 0 -1];%use of a reflection matrix
S_ref = T * S;

%Reflects a shape S about the y axis
%Felipe Nuti
function S_ref = reflecty(S)
T = [-1 0; 0 1]; %use of a reflection matrix
S_ref = T * S;