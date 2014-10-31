subroutine SCORE(layout,MIDI,autoCompile)

logical, optional, intent(IN) :: layout, MIDI ! score and MIDI output. Default .TRUE. and .FALSE., respectively.
logical, optional, intent(IN) :: autoCompile ! if set to .TRUE., then the first will automatically compile your score when the executable finishes running automatically. Default = .FALSE.
character (LEN=256), dimension(999) :: variableName, staffType, instrumentName, groupName, staffRefName ! data about each staff
logical, dimension(999) :: startGroup, transposeAccidental, naturalizeMusic, autochange ! data about each staff
integer, dimension(999) :: transpose, transposeMIDI ! data about each staff
character (LEN=256) :: filename
logical :: articulate ! checks if the articulate.ly is being used
logical :: layout_AUX, MIDI_AUX, currentScoreMIDI, condition, error ! auxiliary variables
integer :: i, j, nScoreBlocks, nInstruments ! auxiliary variables

! ******************************************************************************
! initialization
layout_AUX = .TRUE.
MIDI_AUX = .FALSE.
if (present(layout)) layout_AUX = layout
if (present(MIDI)) MIDI_AUX = MIDI

! reading filename and articulate from the temp file
rewind(unit=10)
read(10,"(A)") filename
read(10,"(L1)") articulate

! reading used variables from the temp2 file
open(unit=9,file="temp2")
i = 1
do
	read(9,"(A)",end=8) variableName(i)
	read(9,"(A)") staffType(i)
	read(9,"(L1)") startGroup(i)		
	read(9,"(A)") instrumentName(i)	
	read(9,"(A)") groupName(i)	
	read(9,"(A)") staffRefName(i)	
	read(9,"(I2)") transpose(i)
	read(9,"(I2)") transposeMIDI(i)		
	read(9,"(L1)") transposeAccidental(i)
	read(9,"(L1)") naturalizeMusic(i)
	read(9,"(L1)") autochange(i)	
	if ((transposeMIDI(i) == 0) .AND. (transpose(i) /= 0)) transposeMIDI(i) = transpose(i)  ! easier to deal explicitly like this, so now transpose affects only with \score \layout and transposeMIDI only \score \MIDI
	i = i + 1
enddo
8 continue
nInstruments = i - 1

! deleting temporary files
close(unit=7,status="delete")
close(unit=9,status="delete") 
close(unit=10,status="delete")
! ******************************************************************************
! creating the \score block

nScoreBlocks = 1
if ((layout_AUX) .AND. (MIDI_AUX)) nScoreBlocks = 2 ! that is, if both PDF and MID files are output, then two score blocks are necessary

do j=1,nScoreBlocks

	if (nScoreBlocks == 2) then ! if both PDF and MID then...
	  if (j==1) then ! if 1st time in the loop, it must be layout
	  	currentScoreMIDI = .FALSE.
			else ! else (2nd time in the loop), it must be MIDI
				currentScoreMIDI = .TRUE.
		endif
		else ! else if only one \score block then
			if (layout_AUX) then
				currentScoreMIDI = .FALSE.
			endif
			if (MIDI_AUX) then
				currentScoreMIDI = .TRUE.
			endif
	endif
	
	if (.NOT. currentScoreMIDI) then ! i.e., if current \score \layout block
		write(*,"(A)") "\score {"
		write(11,"(A)") "\score {"
		else ! i.e., if current \score \MIDI block
			if (.NOT. articulate) then
				write(*,"(A)") "\score { \unfoldRepeats"
				write(11,"(A)") "\score { \unfoldRepeats"
				else
					write(*,"(A)") "\score { \unfoldRepeats \articulate"
					write(11,"(A)") "\score { \unfoldRepeats \articulate"
			endif  
	endif

	if ((nInstruments==1) .AND. (.NOT. autochange(1))) then ! for a single instrument (WITHOUT autochange)

		write(*,"(A)",advance="NO") "  \new Staff "
		write(11,"(A)",advance="NO") "  \new Staff "
		
		! staff name
		if (LEN_TRIM(staffRefName(1)) > 0) then
			write(*,"(A,A,A)",advance="NO") '= "', TRIM(staffRefName(1)), '" '
			write(11,"(A,A,A)",advance="NO") '= "', TRIM(staffRefName(1)), '" '
		endif
		
		! instrument name
		if (LEN_TRIM(instrumentName(1)) > 0) then
			write(*,"(A,A,A)",advance="NO")	'\with { instrumentName = #"', TRIM(instrumentName(1)), ' " } '
			write(11,"(A,A,A)",advance="NO")	'\with { instrumentName = #"', TRIM(instrumentName(1)), ' " } '
		endif
		
		if ((naturalizeMusic(1)) .AND. (.NOT. currentScoreMIDI)) then
			write(*,"(A)",advance="NO") "\naturalizeMusic "
			write(11,"(A)",advance="NO") "\naturalizeMusic "
		endif
				
		! transpositions
		if (.NOT. currentScoreMIDI) then
			if (transpose(1) /= 0) then
				write(*,"(A)",advance="NO") "\transpose "
				write(11,"(A)",advance="NO") "\transpose "
				call MIDI_PITCH_TO_LP(60)
				write(*,"(A)",advance="NO") " "
				write(11,"(A)",advance="NO") " "
				call MIDI_PITCH_TO_LP(60+transpose(1),transposeAccidental(1))
				write(*,"(A)",advance="NO") " "
				write(11,"(A)",advance="NO") " "
			endif
			else
				if (transposeMIDI(i) /= 0) then
					write(*,"(A)",advance="NO") "\transpose "
					write(11,"(A)",advance="NO") "\transpose "
					call MIDI_PITCH_TO_LP(60)
					write(*,"(A)",advance="NO") " "
					write(11,"(A)",advance="NO") " "
					call MIDI_PITCH_TO_LP(60+transposeMIDI(1),transposeAccidental(1))
				write(*,"(A)",advance="NO") " "
				write(11,"(A)",advance="NO") " "
				endif
		endif
		
		write(*,"(A,A)") "\", TRIM(variableName(1))
		write(11,"(A,A)") "\", TRIM(variableName(1))
	
		else ! for more than one instrument below (or for one ore more instruments with autochange)...
	
			write(*,"(A)") "  <<"
			write(11,"(A)") "  <<"

			do i=1,nInstruments ! dealing with one instrument at a time				
				
				if (staffType(i) == "Staff") then ! dealing with simple staff's first
			
					write(*,"(A)",advance="NO") "    \new Staff "
					write(11,"(A)",advance="NO") "    \new Staff "
					
					if (LEN_TRIM(staffRefName(1)) > 0) then
						write(*,"(A,A,A)",advance="NO") '= "', TRIM(staffRefName(i)), '" '
						write(11,"(A,A,A)",advance="NO") '= "', TRIM(staffRefName(i)), '" '
					endif
					
					if (LEN_TRIM(instrumentName(i)) > 0) then
						write(*,"(A,A,A)",advance="NO")	'\with { instrumentName = #"', TRIM(instrumentName(i)), ' " } '
						write(11,"(A,A,A)",advance="NO")	'\with { instrumentName = #"', TRIM(instrumentName(i)), ' " } '
					endif
					
					if ((naturalizeMusic(i)) .AND. (.NOT. currentScoreMIDI)) then
						write(*,"(A)",advance="NO") "\naturalizeMusic "
						write(11,"(A)",advance="NO") "\naturalizeMusic "
					endif
					
					if (.NOT. currentScoreMIDI) then
						if (transpose(i) /= 0) then
							write(*,"(A)",advance="NO") "\transpose "
							write(11,"(A)",advance="NO") "\transpose "
							call MIDI_PITCH_TO_LP(60)
							write(*,"(A)",advance="NO") " "
							write(11,"(A)",advance="NO") " "
							call MIDI_PITCH_TO_LP(60+transpose(i),transposeAccidental(i))
							write(*,"(A)",advance="NO") " "
							write(11,"(A)",advance="NO") " "
						endif
						else
							if (transposeMIDI(i) /= 0) then
								write(*,"(A)",advance="NO") "\transpose "
								write(11,"(A)",advance="NO") "\transpose "
								call MIDI_PITCH_TO_LP(60)
								write(*,"(A)",advance="NO") " "
								write(11,"(A)",advance="NO") " "
								call MIDI_PITCH_TO_LP(60+transposeMIDI(i),transposeAccidental(i))
							write(*,"(A)",advance="NO") " "
							write(11,"(A)",advance="NO") " "
							endif
					endif
					
					write(*,"(A,A)") "\", TRIM(variableName(i))
					write(11,"(A,A)") "\", TRIM(variableName(i))
				
					else ! now with groupped staves
										
						if (.NOT. autochange(i)) then
						
							if (startGroup(i)) then ! if starting a group then
								write(*,"(A,A,1x)",advance="NO") "    \new ", TRIM(staffType(i))
								write(11,"(A,A,1x)",advance="NO") "    \new ", TRIM(staffType(i))
								if (LEN_TRIM(groupName(i)) > 0) then
									write(*,"(A,A,A)",advance="NO")	'\with { instrumentName = #"', TRIM(groupName(i)), ' " } '
									write(11,"(A,A,A)",advance="NO")	'\with { instrumentName = #"', TRIM(groupName(i)), ' " } '
								endif
								write(*,"(A)") "<<"
								write(11,"(A)") "<<"
							endif
					
							write(*,"(A)",advance="NO") "      \new Staff "
							write(11,"(A)",advance="NO") "      \new Staff "
						
							if (LEN_TRIM(staffRefName(1)) > 0) then
								write(*,"(A,A,A)",advance="NO") '= "', TRIM(staffRefName(i)), '" '
								write(11,"(A,A,A)",advance="NO") '= "', TRIM(staffRefName(i)), '" '
							endif
						
							if (LEN_TRIM(instrumentName(i)) > 0) then
								write(*,"(A,A,A)",advance="NO")	'\with { instrumentName = #"', TRIM(instrumentName(i)), ' " } '
								write(11,"(A,A,A)",advance="NO")	'\with { instrumentName = #"', TRIM(instrumentName(i)), ' " } '
							endif
						
							if ((naturalizeMusic(i)) .AND. (.NOT. currentScoreMIDI)) then
								write(*,"(A)",advance="NO") "\naturalizeMusic "
								write(11,"(A)",advance="NO") "\naturalizeMusic "
							endif
		
							if (.NOT. currentScoreMIDI) then
								if (transpose(i) /= 0) then
									write(*,"(A)",advance="NO") "\transpose "
									write(11,"(A)",advance="NO") "\transpose "
									call MIDI_PITCH_TO_LP(60)
									write(*,"(A)",advance="NO") " "
									write(11,"(A)",advance="NO") " "
									call MIDI_PITCH_TO_LP(60+transpose(i),transposeAccidental(i))
									write(*,"(A)",advance="NO") " "
									write(11,"(A)",advance="NO") " "
								endif
								else
									if (transposeMIDI(i) /= 0) then
										write(*,"(A)",advance="NO") "\transpose "
										write(11,"(A)",advance="NO") "\transpose "
										call MIDI_PITCH_TO_LP(60)
										write(*,"(A)",advance="NO") " "
										write(11,"(A)",advance="NO") " "
										call MIDI_PITCH_TO_LP(60+transposeMIDI(i),transposeAccidental(i))
									write(*,"(A)",advance="NO") " "
									write(11,"(A)",advance="NO") " "
									endif
							endif

							write(*,"(A,A)") "\", TRIM(variableName(i))
							write(11,"(A,A)") "\", TRIM(variableName(i))
					
							if ((i == nInstruments) .OR. (startGroup(i+1))) then
								write(*,"(A)") "    >>"
								write(11,"(A)") "    >>"
							endif
							
							else ! i.e., if it IS autochange! thus ignoring staffRefName (they are automatically "up" and "down") and instrumentName (it would get messy, and who wants to use it together with autochange anyway?!)
							
								if (startGroup(i)) then ! if starting a group then
									write(*,"(A,A,1x)",advance="NO") "    \new ", TRIM(staffType(i))
									write(11,"(A,A,1x)",advance="NO") "    \new ", TRIM(staffType(i))
									if (LEN_TRIM(groupName(i)) > 0) then
										write(*,"(A,A,A)",advance="NO")	'\with { instrumentName = #"', TRIM(groupName(i)), ' " } '
										write(11,"(A,A,A)",advance="NO")	'\with { instrumentName = #"', TRIM(groupName(i)), ' " } '
									endif
									write(*,"(A)") "{"
									write(11,"(A)") "{"
								endif

								write(*,"(A)",advance="NO") "      \autochange "
								write(11,"(A)",advance="NO") "      \autochange "
						
								if ((naturalizeMusic(i)) .AND. (.NOT. currentScoreMIDI)) then
									write(*,"(A)",advance="NO") "\naturalizeMusic "
									write(11,"(A)",advance="NO") "\naturalizeMusic "
								endif
		
								if (.NOT. currentScoreMIDI) then
									if (transpose(i) /= 0) then
										write(*,"(A)",advance="NO") "\transpose "
										write(11,"(A)",advance="NO") "\transpose "
										call MIDI_PITCH_TO_LP(60)
										write(*,"(A)",advance="NO") " "
										write(11,"(A)",advance="NO") " "
										call MIDI_PITCH_TO_LP(60+transpose(i),transposeAccidental(i))
										write(*,"(A)",advance="NO") " "
										write(11,"(A)",advance="NO") " "
									endif
									else
										if (transposeMIDI(i) /= 0) then
											write(*,"(A)",advance="NO") "\transpose "
											write(11,"(A)",advance="NO") "\transpose "
											call MIDI_PITCH_TO_LP(60)
											write(*,"(A)",advance="NO") " "
											write(11,"(A)",advance="NO") " "
											call MIDI_PITCH_TO_LP(60+transposeMIDI(i),transposeAccidental(i))
										write(*,"(A)",advance="NO") " "
										write(11,"(A)",advance="NO") " "
										endif
								endif

								write(*,"(A,A)") "\", TRIM(variableName(i))
								write(11,"(A,A)") "\", TRIM(variableName(i))
					
								write(*,"(A)") "    }"
								write(11,"(A)") "    }"
							
						endif
				
				endif
			
			enddo
		
			write(*,"(A)") "  >>"
			write(11,"(A)") "  >>"
		
	endif
	
	if (.NOT. currentScoreMIDI) then
		write(*,"(A)") "  \layout{ }"
		write(11,"(A)") "  \layout{ }"  
		else
			write(*,"(A)") "  \midi{ }"
			write(11,"(A)") "  \midi{ }"  
	endif
	
	write(*,"(A)") "}"
	write(11,"(A)") "}"
	write(*,*)
	write(11,*)
	
enddo

! ******************************************************************************
! checking if .ly file was properly created and compiling it

inquire(file=filename,exist=condition)
if (condition) then
	write(*,"(A)") "* * *"
	write(*,*)
	write(*,"(A)") "Your file "//TRIM(filename)//" was successfully created!"
	write(*,*)
	error = .FALSE.
	else
		write(*,"(A)") "* * *"
		write(*,*)
		write(*,"(A)") "ERROR: something went wrong!"
		write(*,*)		
		error = .TRUE.
endif

if ( (present(autoCompile)) .AND. (.NOT. error) )then
	if (autoCompile) then
		write(*,"(A)") "Compiling your code:"
		write(*,*)
		call SYSTEM("lilypond "//TRIM(filename))
		write(*,*)
	endif
endif


end subroutine SCORE
