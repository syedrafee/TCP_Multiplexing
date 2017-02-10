function [ packets ] = sources( windowSize,src )
%UNTITLED2 Summary of this function goes here
%   Generates windowSize numbers, all with a value of src 
    packets=src*ones(1,windowSize) ;
end

