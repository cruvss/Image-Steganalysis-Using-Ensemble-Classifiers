function F=c300_extractor(input_path,output_path)
% Specify the directory containing JPEG images

input_directory = input_path;

% Specify the directory to save extracted features
output_directory = output_path;
% Specify the quality factor
quality_factor = 75;


% Create the output directory if it doesn't exist
%if ~exist(output_directory, 'dir')
   % mkdir(output_directory);
%end

% Get a list of all JPEG files in the input directory
%jpeg_files = dir(fullfile(input_directory, '*.jpg'));

% Initialize a cell array to store features
all_features = cell(1,1);

% Loop through each JPEG file and perform ccc300 extraction
%for i = 1:length(jpeg_files)
    % Construct the full path to the current image file
    input_image_path = input_directory;

    % Display the current image file being processed
    fprintf('\nProcessing image: %s\n', input_image_path);
    
    % Measure time for DCTR extraction
    t_start = tic;
    F = ccc300(input_image_path, quality_factor);
    t_end = toc(t_start);

    fprintf(' - processed in %.2f seconds\n', t_end);

    % Save the extracted features to the cell array
    all_features = F;
%end

% Save all features into a single .mat file
output_file_path = fullfile(output_directory, 'sample.mat');
save(output_file_path, 'all_features');

fprintf('\nAll features saved to: %s\n', output_file_path);
end