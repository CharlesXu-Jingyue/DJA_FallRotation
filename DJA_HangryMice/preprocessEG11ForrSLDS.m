%% preprocessEG11forrSLDS
% Preprocesses EG1-1 data for rSLDS. collapse behavior data, and smooth
% neural data
% 
% input: .mat file for dataset
% output: processed dataset, which is saved to the same directory
% 
% By Charles Xu @ DJA Lab, Caltech, 20231111
% Prompt user to select local .mat file
%
%% Import data
clear; close all

[filename, pathname] = uigetfile('*.mat', 'Select a .mat file');
filepath = fullfile(pathname, filename);

% Load data from selected file
load(filepath);

%% Manually load variables to work with
behaviorData = behaviorFullMaFPS;
behaviorLabels = behaviorNames;
neuralData = neural_mouse1_fasted_zscore_coreg;

clearvars -except filepath behaviorData behaviorLabels neuralData

%% Smooth neural data
smoothWin = 20;
[neuralDataPreprocessed, window] = smoothdata(neuralData, 2, 'movmean', smoothWin);

clearvars -except filepath behaviorData behaviorLabels neuralData neuralDataPreprocessed

%% Collapse behavioral data
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

clearvars -except filepath collapsedBehaviorData neuralDataPreprocessed

%% Save preprocessed variables to .mat file in the same directory
[path, name, ext] = fileparts(filepath);
filepath_preprocessed = fullfile(path, [name '_preprocessed' ext]);

save(filepath_preprocessed, 'collapsedBehaviorData', 'neuralDataPreprocessed');
