! Subroutine CHORD: writing a chord into Lilypond's notation.
! Only pitch and duration are required arguments, all others are optionals. 
! The order of the arguments is: pitch, duration, dynamics, articulation, hairpin, slur, pedal, text, tremolo, accidental, tie and quartertone.
! E.g., to create a C major quarter note with a stacc. and cresc. hairpin, call CHORD(pitch_array,"4",A="-.",H="\<") with pitch_array=(/60,64,67/)
!
! IMPORTANT: CHORD creates N-note chords, where N is the size of pitch_array unless one or more elemants of pitch_array are equal to or smaller than 0. In that case, CHORD ignores any elements above the 0 element.
! That is, if pitch_array is dimension(4), but consists of (/60,64,67,0/), only a three note chord is created. The same is true for the dimension(6) pitch_arrayB=(/60,64,67,0,50,57/), which will also output a C major chord.

subroutine CHORD(pitch_array,duration,D,A,H,S,P,text,trem,accidental,accidentalVector,tie,tieVector,quartertone,&
quartertoneVector,beam)

integer, intent(in), dimension(:) :: pitch_array ! in MIDI no., i.e., 60 = C4. Obviously, no rests can be used here (i.e., no pitches = 0)
character (LEN=*), intent(in) :: duration ! Durations in LilyPond notation, such as "2." or "8.." or "64"
character (LEN=*), optional, intent(in) :: D ! Dynamics: 
! should consist of two or more characters, such as "\p", "\fp", etc. For explicit positioning, use "^\p", "_\fp", etc.
! if using "arguments.f95", then it can be substituted by variables such as p, fp, etc.
character (LEN=*), optional, intent(in) :: A ! Articulations:
! should consist of two or more characters, such as "->" for accent, "-." for staccato, etc. For explicit positioning, use "^->", "_-.", etc.
! if using "arguments.f95", then it can be substituted by variables such as accent, stacc, etc.
character (LEN=*), optional, intent(in) :: H ! Hairpins:
! should consist of two or more characters, such as "\<" for cresc., "\!" for stopping a hairpin, etc. For explicit positioning, use "^\<", "_\>", etc.
! if using "arguments.f95", then it can be substituted by variables such as cresc, dim and stopHairpin.
character (LEN=*), optional, intent(in) :: S ! Slur:
! should consist of one or more characters, such as "(" for starting a slur, ")" for stopping a slur, etc. For explicit positioning, use "^(", "_)", etc.
! if using "arguments.f95", then it can be substituted by variables such as startSlur, stopSlur, stopStartSlur.
character (LEN=*), optional, intent(in) :: P ! Pedal:
! should be either "\sustainOn", "\sustainOff" or "\sustainOff\sustainOn", 
! if using "arguments.f95", then it can be substituted by variables such as sustainOn (or pedOn), sustainOff (or pedOff), sustainOffsustainOn (or either pedOffpedOn and pedOffOn).
character (LEN=*), optional, intent(in) :: text ! simple text:
! should be either: ^"insertTextHere" or _"insertTextHere", including the quotations
integer, optional, intent(in) :: trem ! Tremolo:
! 0= no tremolo, 8 = tremolo of eighth notes (e.g., c'4:8), 16 = tremolo of sixteenth notes (e.g., g''1:16), and so on
logical, optional, intent(in) :: accidental ! if .TRUE., then all accidentals will be rendered as sharps. If .FALSE., all flats.
logical, optional, intent(in), dimension(:) :: accidentalVector ! a vector with individual values for accidentals of individual pitches
logical, optional, intent(in) :: tie ! if .TRUE., a tie "~" is added after the note is finished. Default = .FALSE.
logical, optional, intent(in), dimension(:) :: tieVector ! a vector with individual values for ties of individual pitches
logical, optional, intent(in) :: quartertone ! if .TRUE., then the note will by shifted by a quarter tone (default shift is up, but if sharp=.FALSE., then the shift is down). Default = .FALSE.
logical, optional, intent(in), dimension(:) :: quartertoneVector ! a vector with individual values for quartertones of individual pitches
character(LEN=*), optional, intent(in) :: beam ! manual beam, should be either "[" or "]"
! if using "arguments.f95", then it can be substituted by variables such as startBeam and stopBeam
logical, dimension(:), allocatable :: accidental_AUX, quartertone_AUX ! Auxiliary variables
integer :: i, relevantChordSize ! Auxiliary variables
logical :: previousAdvanceNo ! used to find out what was the spacing before this subroutine was called. if it finished with an advance="NO" or not

! =========== spacing ==============
rewind(unit=7)
read(7,"(L1)") previousAdvanceNo
if (previousAdvanceNo) then
	write(*,"(A)",advance="NO") " "
	write(11,"(A)",advance="NO") " "
	else
		write(*,"(A)",advance="NO") "  "
		write(11,"(A)",advance="NO") "  "
endif
close(unit=7,status="delete")
open(unit=7,file="temp3")
write(7,"(L1)") .TRUE. ! this will mean to the next subroutine that this one did finish with an advance="NO"
! =================================

allocate( accidental_AUX(SIZE(pitch_array)), quartertone_AUX(SIZE(pitch_array)) )

! dealing with optional variables
accidental_AUX = .TRUE.
quartertone_AUX = .FALSE.

if (present(accidental)) accidental_AUX = accidental
if (present(accidentalVector)) accidental_AUX = accidentalVector
if (present(quartertone)) quartertone_AUX = quartertone
if (present(quartertoneVector)) quartertone_AUX = quartertoneVector

! Checking if the chord was not called with too few notes
if (pitch_array(1)==0) then

 	call NOTE(0,duration)
	 else if (pitch_array(1)==-1) then
		 call NOTE(-1,duration)
	 else if (pitch_array(2)<=0) then
		 call NOTE(pitch_array(1),duration) 
		 
	 else
	 
 		! finding the relevant size of the chord (i.e., non zero elements)
		relevantChordSize = 0
		i = 1		
		do while (pitch_array(i)>0)
		 i = i + 1 
		 relevantChordSize = relevantChordSize + 1
		 if (i > SIZE(pitch_array)) exit
		enddo 

		! Writing the pitches themselves and dealing with individual ties
		write(*,"(A)",advance="NO") "<"
		write(11,"(A)",advance="NO") "<"
		do i=1,(relevantChordSize-1)
			call MIDI_PITCH_TO_LP(pitch_array(i),accidental_AUX(i),quartertone_AUX(i)) 
			if (present(tieVector)) then
				if (tieVector(i)) then
				 write(*,"(A)",advance="NO") "~"
				 write(11,"(A)",advance="NO") "~"
				endif
			endif
			write(*,"(A)",advance="NO") " "
			write(11,"(A)",advance="NO") " "
		enddo
		i = relevantChordSize
		call MIDI_PITCH_TO_LP(pitch_array(i),accidental_AUX(i),quartertone_AUX(i)) 
		if (present(tieVector)) then
			if (tieVector(i)) then
			 write(*,"(A)",advance="NO") "~"
			 write(11,"(A)",advance="NO") "~"
			endif
		endif
		write(*,"(A)",advance="NO") ">"
		write(11,"(A)",advance="NO") ">"

		! pitch duration
		write(*,"(A)",advance="NO") TRIM(duration)
		write(11,"(A)",advance="NO") TRIM(duration)

		! dealing with tremolo
		if (present(trem)) then
			if (trem > 0) then
			 if (trem < 10) then
				 write(11,"(A,I1)",advance="NO") ":", trem
				 else
					 write(11,"(A,I2)",advance="NO") ":", trem
			 endif
			endif
		endif

		! other attributes
		if (present(D)) then
			write(*,"(A)",advance="NO") TRIM(D)
			write(11,"(A)",advance="NO") TRIM(D)
		endif
		if (present(A)) then
			write(*,"(A)",advance="NO") TRIM(A)
			write(11,"(A)",advance="NO") TRIM(A)
		endif
		if (present(H)) then
			write(*,"(A)",advance="NO") TRIM(H)
			write(11,"(A)",advance="NO") TRIM(H)
		endif
		if (present(S)) then
			write(*,"(A)",advance="NO") TRIM(S)
			write(11,"(A)",advance="NO") TRIM(S)
		endif
		if (present(P)) then
			write(*,"(A)",advance="NO") TRIM(P)
			write(11,"(A)",advance="NO") TRIM(P)
		endif
		if (present(text)) then
			write(*,"(A)",advance="NO") TRIM(text)
			write(11,"(A)",advance="NO") TRIM(text)
		endif
		if (present(beam)) then
			write(*,"(A)",advance="NO") TRIM(beam)
			write(11,"(A)",advance="NO") TRIM(beam)
		endif
		if (present(tie)) then
	 		if (tie) then
				write(*,"(A)",advance="NO") "~"
		 		write(11,"(A)",advance="NO") "~"
 			endif
		endif
			 
endif

end subroutine CHORD
