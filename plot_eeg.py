import sys
import pandas as pd

#Set file name to first command line argument 
filename = sys.argv[1]
#Set seconds_to_plot to second command line argument as integer
seconds_to_plot = int(sys.argv[2])
#Read in EEG data from CSV file
signal_df = pd.read_csv(filename, sep=';')
#Set Time column to Index
signal_df.set_index('Time (s)', inplace=True)
#Use first seconds_to_plot seconds of Data for Graphing
signal_df = signal_df.loc[:seconds_to_plot,:]
#Subtract out the Reference Noise column from each value
signal_df = signal_df.subtract(signal_df['Ref_Noise'], axis='index')
#Drop the Reference Noise column from the dataframe
signal_df = signal_df.drop('Ref_Noise', axis=1)
#Graph EEG Data
signal_df.plot()

