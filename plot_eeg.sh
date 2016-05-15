#!/bin/sh
#Import and plot EEG data

read_csv() {
	FILE_NAME=$1
	Seconds=$2 
	I=0
	count=0
	while IFS=';' read Time C3 C4 Ref_Noise FC3 FC4 C5 C1 C2 C6 CP3 CP4 
	do
		if [ $I -eq 0 ]; then
			labels=(Time C3 C4 FC3 FC4 C5 C1 C2 C6 CP3 CP4)
			I=1
			continue
		fi
		Time_A+=("$Time")
		C3_A+=("$C3")
		C4_A+=("$C4")
		Ref_Noise_A+=("$Ref_Noise")
		FC3_A+=("$FC3")
		FC4_A+=("$FC4")
		C5_A+=("$C5")
		C1_A+=("$C1")
		C2_A+=("$C2")
		C6_A+=("$C6")
		CP3_A+=("$CP3")
		CP4_A+=("$CP4")

		current_time="$(echo $Time | cut -c1)"
		if [ $Seconds -eq $current_time ]; then
			break
		fi
	done < $FILE_NAME
}

adjust_for_ref_noise() {
	array_length=${#Ref_Noise_A[*]}
	i=0
	while :
	do
		if [ $i -eq $array_length ]; then
			break
		fi
		C3_A[$i]=$(echo "${C3_A[$i]} - ${Ref_Noise_A[$i]}" | bc)	
		C4_A[$i]=$(echo "${C4_A[$i]} - ${Ref_Noise_A[$i]}" | bc)	
		FC3_A[$i]=$(echo "${FC3_A[$i]} - ${Ref_Noise_A[$i]}" | bc)	
		FC4_A[$i]=$(echo "${FC4_A[$i]} - ${Ref_Noise_A[$i]}" | bc)	
		C5_A[$i]=$(echo "${C5_A[$i]} - ${Ref_Noise_A[$i]}" | bc)	
		C1_A[$i]=$(echo "${C1_A[$i]} - ${Ref_Noise_A[$i]}" | bc)	
		C2_A[$i]=$(echo "${C2_A[$i]} - ${Ref_Noise_A[$i]}" | bc)	
		C6_A[$i]=$(echo "${C6_A[$i]} - ${Ref_Noise_A[$i]}" | bc)	
		CP3_A[$i]=$(echo "${CP3_A[$i]} - ${Ref_Noise_A[$i]}" | bc)	
		CP4_A[$i]=$(echo "${CP4_A[$i]} - ${Ref_Noise_A[$i]}" | bc)	
		i=$(($i+1))
	done
}

export_as_gnuplot_data() {
	array_length=${#Time_A[*]}
	i=0
	while [ $i -lt $array_length ]
	do
 
		echo "${Time_A[$i]} ${C3_A[$i]} ${C4_A[$i]} ${FC3_A[$i]} ${FC4_A[$i]} ${C5_A[$i]} ${C1_A[$i]} ${C2_A[$i]} ${C6_A[$i]} ${CP3_A[$i]} ${CP4_A[$i]}" >> gnuplot_data.dat		
		i=$(($i + 1))
	done
}

plot_eeg_data() {
	gnuplot.exe "plot_formatted_eeg_data.sh"
}

read_csv $1 $2
adjust_for_ref_noise
export_as_gnuplot_data
plot_eeg_data
