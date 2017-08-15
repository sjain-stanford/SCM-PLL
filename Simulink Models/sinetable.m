clc;
clear all;
close all;

% Generate a sine table, 'n' point, 'bits' no of bits in the output
n = input('No. of points in one period of the sine wave (e.g. 32 point): ');
bits = input('No. of bits in the output (e.g. 8 bits): ');
a = 2^(bits-1)-1;
b = 2^(bits-1);
x = linspace(0,2*pi-2*pi/n,n);
y = zeros(1,n);
z = zeros(1,n);
for i = 1:1:n
    y(i) = a*sin(x(i))+b;
    z(i) = a*cos(x(i))+b;
end
