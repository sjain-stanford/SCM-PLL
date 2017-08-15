clc;
clear all;
close all;

% Generate a sine table, 'n' point
n = input('No. of points in one period of the sine wave (e.g. 32 point): ');
x = linspace(0,2*pi-2*pi/n,n);
y = zeros(1,n);
z = zeros(1,n);
for i = 1:1:n
    y(i) = sin(x(i));
    z(i) = cos(x(i));
end
