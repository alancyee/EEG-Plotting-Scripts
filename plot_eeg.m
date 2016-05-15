%% Plot EEG Data

%% Import EEG Data from CSV file
% filename of csv file will be given as command line argument
fileID = fopen(filename);
%eeg_data = textscan(fileID,'%s%s%s%s%s%s%s%s%s%s%s%s','Delimiter', ';');
eeg_data = textscan(fileID,'%.6f%.6f%.6f%.6f%.6f%.6f%.6f%.6f%.6f%.6f%.6f%.6f',...
    'HeaderLines', 1, 'Delimiter', ';');

%% Use only first seconds_to_plot seconds of data points
% seconds_to_plot will be given as command line argument
% Subtract reference noise from all signals
% Reference noise column is column 4
formatted_eeg_data = [[],[],[],[],[],[],[],[],[],[],[],[]];
index = 1;
while 1
    for k=2:12
        %skip reference noise column
        if k == 4
            continue
        end
        %subtract reference noise from each column
        formatted_eeg_data(k,index) = eeg_data{1,k}(index) - eeg_data{1,4}(index);
    end
    %add time data to frommated_eeg_data
    formatted_eeg_data(1,index) = eeg_data{1,1}(index);
    %exit loop after seconds_to_plot seconds of data
    if eeg_data{1,1}(index) == seconds_to_plot
        break
    end
    index = index + 1;
end

%% Plot data
plot(formatted_eeg_data(1,:),formatted_eeg_data(2,:),formatted_eeg_data(1,:),...
    formatted_eeg_data(3,:),formatted_eeg_data(1,:),formatted_eeg_data(5,:),...
    formatted_eeg_data(1,:),formatted_eeg_data(6,:),formatted_eeg_data(1,:),...
    formatted_eeg_data(7,:),formatted_eeg_data(1,:),formatted_eeg_data(8,:),...
    formatted_eeg_data(1,:),formatted_eeg_data(9,:),formatted_eeg_data(1,:),...
    formatted_eeg_data(10,:),formatted_eeg_data(1,:),formatted_eeg_data(11,:),...
    formatted_eeg_data(1,:),formatted_eeg_data(12,:))
axis([0.0, 2.0, 44000, 56000])
xlabel('Time (s)')
legend('C3','C4','FC3','FC4','C5','C1','C2','C6','CP3','CP4')