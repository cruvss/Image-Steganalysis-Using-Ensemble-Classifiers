function F=Untitled(path)




input_path=path;

output_path=fullfile('D:','desktop','new matlab');
c300_extractor(input_path,output_path);
F=load('sample.mat');
allFeatures = F.all_features;
cellContents = allFeatures;
F=cellContents.';
save('sample.mat');
path_clf_out=fullfile('D:', 'desktop', 'new matlab','grayModel.mat');
path_votes_out=fullfile('D:', 'desktop', 'new matlab','sample.txt');

ensemble_predict(path_clf_out, 'sample.mat' , path_votes_out);

% Open the file for reading
fileID = fopen('sample.txt', 'r');

% Initialize counters
positiveCount = 0;
negativeCount = 0;

% Read the file line by line
while ~feof(fileID)
    % Read the next line
    line = fgetl(fileID);
    
    % Split the line into numbers
    numbers = str2double(strsplit(line));
    
    % Count the positive and negative numbers
    positiveCount = positiveCount + sum(numbers > 0);
    negativeCount = negativeCount + sum(numbers < 0);
end

% Close the file
fclose(fileID);
F=positiveCount;
% Display the results
fprintf('Number of positive numbers: %d\n', positiveCount);
fprintf('Number of negative numbers: %d\n', negativeCount);
end