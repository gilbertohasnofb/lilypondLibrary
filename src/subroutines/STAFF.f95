! creates a variable which can be later used inside \score, for instance
subroutine STAFF(instrumentName,groupName,staffType,startGroup,staffRefName,transpose,transposeMIDI,transposeAccidental, &
naturalizeMusic,autochange)

character (LEN=*), optional, intent(IN) :: instrumentName ! name of the instrument. If left blank, then it won't be displayed.
character (LEN=*), optional, intent(IN) :: groupName ! name of the group of staves. If left blank, then it won't be displayed.
character (LEN=*), optional, intent(IN) :: staffType ! should be either "Staff", "PianoStaff", "GrandStaff", "StaffGroup", "ChoirStaff". Optional argument, if called without then all variables will be considered as simple Staff
logical, optional, intent(IN) :: startGroup ! If .TRUE., then this will consist of a new group of staves, if .FALSE. then it will be part of the previous staff group. Optional argument.
character (LEN=*), optional, intent(IN) :: staffRefName ! reference name for the staff. This won't show in the final score, but needs to be used if you plan to call STAFF_CHANGE(staffRefName)
integer, optional, intent(IN) :: transpose, transposeMIDI ! transpose will affect both the score and the MIDI output, while transposeMIDI affects only the MIDI (useful for "Score in C" type of notation)
character (LEN=*), optional, intent(IN) :: transposeAccidental ! if "is", "s" or "sharp, then the pitch will be notated with sharp accidental. If "es", "f" or "flat", then it will be notated as flat
logical, optional, intent(IN) :: naturalizeMusic ! this function avoids accidentals such as ces, bis, fes, eis by using the command \naturalizeMusic (remember to call SNIPPET with naturalizeMusic=.TRUE.)
logical, optional, intent(IN) :: autochange ! if .TRUE., pitches above middle C will be written in the upper staff while the pitches below it will be written in the bottom staff. To be used together with either PianoStaff or GrandStaff.
character (LEN=256) :: variableName, previous_staffType, staffType_AUX
integer :: i, j

! opening another output file
close(unit=7,status="delete")
open(unit=7,file="temp3")
write(7,"(L1)") .FALSE. ! this will mean to the next subroutine that this one didn't finish with an advance="NO"

! finding the previous value for staffType (this loop is indeed a waste of computation, but Fortran has no way of reading an specific line...)
previous_staffType = "Staff" ! in case this is the 1st time this subroutine is being called
open(unit=9,file="temp2")
i = 1
do
	read(9,"(A)",end=8) 
	read(9,"(A)") previous_staffType
	read(9,"(L1)") 
	read(9,"(A)") 
	read(9,"(A)") 
	read(9,"(A)")
	read(9,"(I2)") 
	read(9,"(I3)")
	read(9,"(A)") 
	read(9,"(L1)") 
	read(9,"(L1)") 
	i = i + 1
enddo
8 continue
close(unit=9,status="keep") 
! <rant> it is not elegant to close the file just to open it again few lines later, but the code above would produce an error when executing. 
! Basically, as of GNU Fortran (Ubuntu 4.8.2-19ubuntu1) 4.8.2, one cannot read until EOF and then write to the same file after it (!!!). As always,
! some argue this is a bug, some argue it is a wonderful standard implemented by a visionary dev. Nevertheless, it generates stupid situations 
! such as this one, and many frustrating hours trying to find out why a code that previously worked fine simply does not work any longer (did I hear
! anything about Fortran's amazing past compatibility?!)... </rant>

! creating a name for this staff
variableName = ""
do while (i > 0)
	j = MOD(i,26) 
	if (j==0) j = 26
	variableName = TRIM(variableName) // ACHAR(64 + j)	
	i = i - 26
enddo
if (variableName == "R") variableName = "R-not-a-rest" ! since R is reserved for whole bar rests

write(*,"(A,A)") TRIM(variableName), " = {"
write(11,"(A,A)") TRIM(variableName), " = {"

! outputting information about this staff to a temporary file
open(unit=9,file="temp2",access="append")

write(9,"(A)") TRIM(variableName)

! staff type
if (present(staffType)) then
	write(9,"(A)") TRIM(staffType)
	staffType_AUX = staffType
	else
		write(9,"(A)") "Staff"
		staffType_AUX = "Staff"
endif

! start of a group or not?
if (present(startGroup)) then
	write(9,"(L1)") startGroup	
	else	! if not present then
		if (staffType_AUX /= "Staff") then ! if this current staff isn't a simple "Staff" but part of a group
			if (previous_staffType == staffType_AUX) then ! and it is identical to the previous type
				write(9,"(L1)") .FALSE. ! then it is assumed NOT to be the start of a new group (UNLESS SPECIFIED)
				else
					write(9,"(L1)") .TRUE. ! that is, if this staff is groupped and the previous one was as well but they are of different types, then this is the start of a new group
			endif			
			else ! if this IS a simple Staff
				write(9,"(L1)") .TRUE. ! then groupping doesn't matter, but let's mark it as a start anyway (just for consistency, this is the start of a group of 1 staves)
		endif				
endif

! instrument name
if (present(instrumentName)) then
	write(9,"(A)") TRIM(instrumentName)
	else
		write(9,"(A)") ""
endif

! name of the group of staves
if (present(groupName)) then
	write(9,"(A)") TRIM(groupName)
	else
		write(9,"(A)") ""
endif

! reference name for the current staff
if (present(staffRefName)) then
	write(9,"(A)") TRIM(staffRefName)
	else
		write(9,"(A)") ""
endif

! transpose
if (present(transpose)) then
	write(9,"(I2)") transpose
	else
		write(9,"(I2)") 0
endif

if (present(transposeMIDI)) then
	write(9,"(I3)") transposeMIDI
	else
		write(9,"(I3)") 0
endif

if (present(transposeAccidental)) then
	write(9,"(A)") TRIM(transposeAccidental)
	else
		write(9,"(A)") "sharp"
endif

if (present(naturalizeMusic)) then
	write(9,"(L1)") naturalizeMusic
	else
		write(9,"(L1)") .FALSE.
endif

if (present(autochange)) then
	write(9,"(L1)") autochange
	else
		write(9,"(L1)") .FALSE.
endif

close(unit=9,status="keep")

end subroutine STAFF
