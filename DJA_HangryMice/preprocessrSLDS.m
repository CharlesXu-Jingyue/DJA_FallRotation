%% preprocessrSLDS
% Preprocesses data for rSLDS. collapse behavior data, and smooth neural
% data
% 
% input: .mat file for dataset
% output: processed dataset, which is saved to the same directory
% 
% By Charles Xu @ DJA Lab, Caltech, 20231118
% Prompt user to select local .mat file
%
%% Import data
clear; close all

% Select and load the first .mat file
[filename1, pathname1] = uigetfile('*.mat', 'Select the .mat file to be processed');
filepath1 = fullfile(pathname1, filename1);
load(filepath1);

% Select and load the second .mat file
[filename2, pathname2] = uigetfile('*.mat', 'Select the .mat file for behavioral reference');
filepath2 = fullfile(pathname2, filename2);
load(filepath2);

%% Process EG1-1 fasted unreg traceOnly
% Import EG1-1_fasted_unreg.mat and EG1-1_fasted_rSLDS.mat
% Manually load variables to work with
neuralData = trace;

% Smooth neural data
smoothWin = 20;
[neuralDataPreprocessed, ~] = smoothdata(neuralData, 2, 'movmean', smoothWin);

% Add trailing zeros
neuralDataPreprocessed = padarray(neuralDataPreprocessed, [0, 6397-size(neuralDataPreprocessed,2)], 'post');

% Save preprocessed variables to .mat file in the same directory
[path, name, ext] = fileparts(filepath1);
filepath_preprocessed = fullfile(path, [name '_rSLDS' ext]);

save(filepath_preprocessed, 'collapsedBehaviorData', 'neuralDataPreprocessed');

%% Process EG1-1 fasted unreg
% Import EG1-1_fasted_unreg.mat
behaviorData = behaviorFullMaFPS;

% Smooth neural data
smoothWin = 20;
[neuralDataPreprocessed, ~] = smoothdata(neuralData, 2, 'movmean', smoothWin);

% Collapse behavioral data
% Select the rows to collapse
selectedRows = behaviorData([1, 2, 4, 7], :);

% Check for overlapping time points
overlappingTimePoints = sum(selectedRows, 1) > 1;
if any(overlappingTimePoints)
    fprintf('Overlapping behaviors detected at %d time points.\n', sum(overlappingTimePoints));
end

% Assign unique identifiers to each behavior
selectedRows = bsxfun(@times, selectedRows', 1:size(selectedRows, 1));

% Collapse the rows into a 1-D array
collapsedBehaviorData = max(selectedRows, [], 2)';

% Save preprocessed variables to .mat file in the same directory
[path, name, ext] = fileparts(filepath1);
filepath_preprocessed = fullfile(path, [name '_rSLDS' ext]);

save(filepath_preprocessed, 'collapsedBehaviorData', 'neuralDataPreprocessed');

%% Process EG1-4 fasted unreg
% Import EG1-4_fasted_unreg_nozscore.mat and EG1-4_fasted_preprocessed.mat
% Manually load variables to work with
behaviorData = behaviorDataPreprocessed;
neuralData = trace;

% z-score neural data
neuralDataPreprocessed = (neuralData - mean(neuralData, 2)) ./ std(neuralData, 0, 2);

% Smooth neural data
smoothWin = 20;
[neuralDataPreprocessed, ~] = smoothdata(neuralDataPreprocessed, 2, 'movmean', smoothWin);

% Collapse behavioral data
% Select the rows to collapse
selectedRows = behaviorData([10, 13, 12, 5], :);

% Check for overlapping time points
overlappingTimePoints = sum(selectedRows, 1) > 1;
if any(overlappingTimePoints)
    fprintf('Overlapping behaviors detected at %d time points.\n', sum(overlappingTimePoints));
end

% Assign unique identifiers to each behavior
selectedRows = bsxfun(@times, selectedRows', 1:size(selectedRows, 1));

% Collapse the rows into a 1-D array
collapsedBehaviorData = max(selectedRows, [], 2)';

% Save preprocessed variables to .mat file in the same directory
[path, name, ext] = fileparts(filepath1);
name_parts = strsplit(name, '_');
name_parts = name_parts(1:end-1);
name = strjoin(name_parts, '_');
filepath_preprocessed = fullfile(path, [name '_rSLDS' ext]);

save(filepath_preprocessed, 'collapsedBehaviorData', 'neuralDataPreprocessed');

%% Process EG1-4 fasted male1 unreg
% Import EG1-4_fasted_unreg_rSLDS.mat
% Slice array to include all frames before second male entrance
neuralDataPreprocessed = neuralDataPreprocessed(:, 1:8153);
collapsedBehaviorData = collapsedBehaviorData(:, 1:8153);

% Save preprocessed variables to .mat file in the same directory
[path, name, ext] = fileparts(filepath1);
name_parts = strsplit(name, '_');
name_parts = name_parts(1:end-1);
name = strjoin(name_parts, '_');
filepath_preprocessed = fullfile(path, [name '_male1_rSLDS' ext]);

save(filepath_preprocessed, 'collapsedBehaviorData', 'neuralDataPreprocessed');

%% Process EG1-4 fasted
% Import EG1-4_fasted_preprocessed.mat and EG1-4_fasted_unreg_rSLDS.mat
neuralDataPreprocessed = neuralData;

% Save preprocessed variables to .mat file in the same directory
[path, name, ext] = fileparts(filepath1);
name_parts = strsplit(name, '_');
name_parts = name_parts(1:end-1);
name = strjoin(name_parts, '_');
filepath_preprocessed = fullfile(path, [name '_rSLDS' ext]);

save(filepath_preprocessed, 'collapsedBehaviorData', 'neuralDataPreprocessed');

