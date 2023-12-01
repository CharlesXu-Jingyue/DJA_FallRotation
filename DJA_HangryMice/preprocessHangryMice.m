%% preprocessHangryMice
% Preprocesses HangryMice data. Manually align behavior labels, insert
% missing ones with zeros, and smooth neural data.
% 
% input: .mat file for dataset
% output: processed dataset, which is saved to the same directory
% 
% By Charles Xu @ DJA Lab, Caltech, 20231103
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
stimuliData = stimFullMaFPS;
stimuliLabels = stimNames;

clearvars -except filepath behaviorData behaviorLabels stimuliData stimuliLabels neuralData

%% Manually process behavioral data and labels, M1
% Rename behavior labels
behaviorLabels = {'attack';'eating';'food_approach';'food_sniff';'introduction';'sniffM';'drinking'};
behaviorData = [behaviorData(1:5, :); behaviorData(7:end, :)];
% Manually define labels to align to
behaviorLabelsGrouped = {'baseline', ... % Baseline
                         'introduction', ... % Novelty
                         'sniffM', 'attack', ... % Male
                         'food_approach', 'food_sniff', 'eating', 'drinking', ... % Food
                         };
groupIndices = [1; 2; 4; 8]; % Indices of the first behavior in each group

behaviorLabelsPreprocessed = cell(size(behaviorLabelsGrouped, 2), 1); % Preallocate
behaviorLabelsPreprocessed(1:length(behaviorLabels)) = behaviorLabels; % Insert existing labels
behaviorDataPreprocessed = zeros(length(behaviorLabelsGrouped), size(behaviorData, 2)); % Preallocate
behaviorDataPreprocessed(1:length(behaviorLabels), :) = behaviorData; % Insert existing data

% Check for missing labels in behaviorLabels compared to behaviorLabelsGrouped
missingLabels = setdiff(behaviorLabelsGrouped, behaviorLabels);

% If any missing labels exist
if ~isempty(missingLabels)
    % For each missing label
    for i = 1:length(missingLabels)
        % Add it to the end of behaviorLabels
        behaviorLabelsPreprocessed(length(behaviorLabels)+i) = missingLabels(i); %#ok<*AGROW>
        
        % Add a row of zeros to the bottom of behaviorData
        behaviorDataPreprocessed(length(behaviorLabels)+i, :) = zeros(1, size(behaviorData, 2));
    end
end

% Reorder behaviorLabels and the rows of behaviorData according to the order of labels in behaviorLabelsGrouped
[~, sorted_indices] = ismember(behaviorLabelsGrouped, behaviorLabelsPreprocessed);
behaviorLabelsPreprocessed = behaviorLabelsPreprocessed(sorted_indices);
behaviorDataPreprocessed = behaviorDataPreprocessed(sorted_indices, :);

% Set baseline values
firstBehaviorIdx = find(any(behaviorData, 1), 1, 'first'); % Find the index of the first behavior
baseline = zeros(1, size(behaviorData, 2)); % Initialize baseline_fasted as zeros
baseline(firstBehaviorIdx-1200:firstBehaviorIdx-1) = 1; % Set the baseline to be 2 minutes before the first behavior
[~, baselineWhere] = ismember("baseline", behaviorLabelsPreprocessed);
behaviorDataPreprocessed(baselineWhere, :) = baseline;

clearvars -except filepath behaviorDataPreprocessed behaviorLabelsPreprocessed stimuliData stimuliLabels neuralData

%% Manually process stimuli data and labels
% Degenerate stimuli labels (fasted)
stimuliLabelsPreprocessed = {'baseline'; 'male'; 'food'};
firstBehaviorIdx = find(any(stimuliData, 1), 1, 'first'); % Find the index of the first behavior
baselineStim = zeros(1, size(stimuliData, 2)); % Initialize baseline_fasted as zeros
baselineStim(1:firstBehaviorIdx-1) = 1; % Set the baseline to be all before the first behavior

stimuliDataPreprocessed = zeros(size(stimuliLabelsPreprocessed, 1), size(stimuliData, 2));
stimuliDataPreprocessed(1, :) = baselineStim; % "baseline"
stimuliDataPreprocessed(2, :) = stimuliData(4, :) | stimuliData(5, :); % "male"
stimuliDataPreprocessed(3, :) = stimuliData(5, :) | stimuliData(1, :); % "food"

clearvars -except filepath behaviorDataPreprocessed behaviorLabelsPreprocessed stimuliDataPreprocessed stimuliLabelsPreprocessed neuralData

%% Manually process behavioral data and labels, M2
% Manually define labels to align to
behaviorLabelsGrouped = {'baseline', ... % Baseline
                         'danglingM', 'introduction', ... % Novelty
                         'male_approach', 'sniffM', 'sniff_face', 'mountM', 'chasing', 'attack_attempt', 'attack', ... % Consummatory
                         'food_approach', 'food_sniff', 'eating', 'drinking', ... % Food
                         'self_grooming'
                         };
groupIndices = [1; 3; 10; 14]; % Indices of the first behavior in each group

behaviorLabelsPreprocessed = cell(size(behaviorLabelsGrouped, 2), 1); % Preallocate
behaviorLabelsPreprocessed(1:length(behaviorLabels)) = behaviorLabels; % Insert existing labels
behaviorDataPreprocessed = zeros(length(behaviorLabelsGrouped), size(behaviorData, 2)); % Preallocate
behaviorDataPreprocessed(1:length(behaviorLabels), :) = behaviorData; % Insert existing data

% Check for missing labels in behaviorLabels compared to behaviorLabelsGrouped
missingLabels = setdiff(behaviorLabelsGrouped, behaviorLabels);

% If any missing labels exist
if ~isempty(missingLabels)
    % For each missing label
    for i = 1:length(missingLabels)
        % Add it to the end of behaviorLabels
        behaviorLabelsPreprocessed(length(behaviorLabels)+i) = missingLabels(i); %#ok<*AGROW>
        
        % Add a row of zeros to the bottom of behaviorData
        behaviorDataPreprocessed(length(behaviorLabels)+i, :) = zeros(1, size(behaviorData, 2));
    end
end

% Reorder behaviorLabels and the rows of behaviorData according to the order of labels in behaviorLabelsGrouped
[~, sorted_indices] = ismember(behaviorLabelsGrouped, behaviorLabelsPreprocessed);
behaviorLabelsPreprocessed = behaviorLabelsPreprocessed(sorted_indices);
behaviorDataPreprocessed = behaviorDataPreprocessed(sorted_indices, :);

% Set baseline values
firstBehaviorIdx = find(any(behaviorData, 1), 1, 'first'); % Find the index of the first behavior
baseline = zeros(1, size(behaviorData, 2)); % Initialize baseline_fasted as zeros
baseline(firstBehaviorIdx-1200:firstBehaviorIdx-1) = 1; % Set the baseline to be 2 minutes before the first behavior
[~, baselineWhere] = ismember("baseline", behaviorLabelsPreprocessed);
behaviorDataPreprocessed(baselineWhere, :) = baseline;

clearvars -except filepath behaviorDataPreprocessed behaviorLabelsPreprocessed stimuliData stimuliLabels neuralData

%% Manually process stimuli data and labels
% Degenerate stimuli labels (fasted)
% stimuliLabelsPreprocessed = {'baseline'; 'male'; 'object'; 'food'; 'male2'};
% stimuliDataPreprocessed = zeros(length(stimuliLabelsPreprocessed), size(stimuliData, 2)); % Preallocate
% stimuliDataPreprocessed(1, :) = stimuliData(1, :); % "baseline"
% stimuliDataPreprocessed(2, :) = stimuliData(5, :) | stimuliData(6, :) | stimuliData(7, :); % "male"
% stimuliDataPreprocessed(3, :) = stimuliData(7, :); % "object"
% stimuliDataPreprocessed(4, :) = stimuliData(6, :) | stimuliData(2, :) | stimuliData(3, :); % "food"
% stimuliDataPreprocessed(5, :) = stimuliData(2, :); % "male2"
% [~, introductionWhere] = ismember("introduction", behaviorLabelsPreprocessed);
% behaviorDataPreprocessed(introductionWhere, :) = stimuliData(4, :);

% Degenerate stimuli labels (fed)
stimuliLabelsPreprocessed = {'baseline'; 'male'; 'food'; 'male2'};
firstBehaviorIdx = find(any(stimuliData, 1), 1, 'first'); % Find the index of the first behavior
baselineStim = zeros(1, size(stimuliData, 2)); % Initialize baseline_fasted as zeros
baselineStim(1:firstBehaviorIdx-1) = 1; % Set the baseline to be all before the first behavior
stimuliDataPreprocessed(1, :) = baselineStim; % "baseline"
stimuliDataPreprocessed(2, :) = stimuliData(3, :); % "male"
stimuliDataPreprocessed(3, :) = stimuliData(2, :) | stimuliData(1, :); % "food"
stimuliDataPreprocessed(4, :) = stimuliData(1, :); % "male2"

clearvars -except filepath behaviorDataPreprocessed behaviorLabelsPreprocessed stimuliDataPreprocessed stimuliLabelsPreprocessed neuralData

%% Smooth neural data
smoothWin = 20;
[neuralDataPreprocessed, window] = smoothdata(neuralData, 2, 'movmean', smoothWin);

clearvars -except filepath behaviorDataPreprocessed behaviorLabelsPreprocessed stimuliDataPreprocessed stimuliLabelsPreprocessed neuralData neuralDataPreprocessed

%% Save preprocessed variables to .mat file in the same directory
[path, name, ext] = fileparts(filepath);
filepath_preprocessed = fullfile(path, [name '_preprocessed' ext]);

save(filepath_preprocessed, 'behaviorDataPreprocessed', 'behaviorLabelsPreprocessed', 'stimuliDataPreprocessed', 'stimuliLabelsPreprocessed', 'neuralData', 'neuralDataPreprocessed');

%%
filepath_preprocessed = fullfile('/Users/alveus/Documents/WorkingDirectory/LocalRepository/DJA_FallRotation/DJA_HangryMice/data', 'EG1-4_fasted_unreg_male1_preprocessed_use.mat');
save(filepath_preprocessed, 'behaviorDataPreprocessed', 'behaviorLabelsPreprocessed', 'stimuliDataPreprocessed', 'stimuliLabelsPreprocessed', 'neuralData', 'neuralDataPreprocessed');
