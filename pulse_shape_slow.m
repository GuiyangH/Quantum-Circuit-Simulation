function[y]=pulse_shape_slow(t_total,t)
% This file inputs the total time this pulse running, and the current time,
% it outputs value y ranging from 0 to 1.
if t < 1/3*t_total
    y = -1/2*cos(3*pi*t/t_total)+1/2;
elseif t > 2/3*t_total
    y = 1/2*cos(3*pi*t/t_total+4*pi)+1/2;
else
    y = 1;
end

%% Test file
% total = 8;
% for p = 1: 200
%     T = p/200*total;
%     List(p) = pulse_shape(total,T);
% end
% x_axis = 0: total/(200-1):total;
% plot(x_axis,List)
