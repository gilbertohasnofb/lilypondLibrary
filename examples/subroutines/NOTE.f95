! Subroutine NOTE: writing a note into Lilypond's notation. 
! Only pitch and duration are required arguments, all others are optionals. 
! The order of the arguments is: pitch, duration, dynamics, articulation, hairpin, slur, pedal, text, tremolo, accidental, tie and quartertone.
! E.g., to create a middle C quarter note with a stacc. and cresc. hairpin, call NOTE(60,"4",A="-.",H="\<")

subroutine NOTE(pitch,duration,D,A,H,S,P,text,trem,accidental,quartertone,tie,beam)

integer, intent(in) :: pitch ! MIDI no., i.e., 60 = C4. To use rests, use MIDI = 0 !!!
character (LEN=*), optional, intent(in) :: duration ! Durations in LilyPond notation, such as "2." or "8.." or "64"
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
character (LEN=*), optional, intent(in) :: accidental ! if "is", "s" or "sharp, then the pitch will be notated with sharp accidental. If "es", "f" or "flat", then it will be notated as flat
character (LEN=*), optional, intent(in) :: quartertone ! if "ih", "up" or "higher", then quarter tone higher, if "eh", "down" or "lower", then quarter tone lower. If "" or "neuter" or "default", then no quarter tone will be used
logical, optional, intent(in) :: tie ! if .TRUE., a tie "~" is added after the note is finished. Default = .FALSE.
character(LEN=*), optional, intent(in) :: beam ! manual beam, should be either "[" or "]"
! if using "arguments.f95", then it can be substituted by variables such as startBeam and stopBeam
character (LEN=256) :: accidental_AUX, quartertone_AUX ! Auxiliary variable
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

! dealing with optional variables
accidental_AUX="sharp"
quartertone_AUX="neuter"
if (present(accidental)) accidental_AUX = TRIM(accidental)
if (present(quartertone)) quartertone_AUX = TRIM(quartertone)

if ( ((TRIM(quartertone_AUX) == "ih") .OR. (TRIM(quartertone_AUX) == "higher") .OR. (TRIM(quartertone_AUX) == "up")) .AND. &
((TRIM(accidental_AUX) == "es") .OR. (TRIM(accidental_AUX) == "f") .OR. (TRIM(accidental_AUX) == "flat")) ) accidental_AUX="sharp" ! that is, if quarter tone up and accidental flat, then accidental changes to sharp. This avoid absurd syntax problems in LilyPond, such as gesih, and still outputs the correct note, which is a quarter tone higher than the pitch class
if ( ((TRIM(quartertone_AUX) == "eh") .OR. (TRIM(quartertone_AUX) == "lower") .OR. (TRIM(quartertone_AUX) == "down")) .AND. &
((TRIM(accidental_AUX) == "is") .OR. (TRIM(accidental_AUX) == "s") .OR. (TRIM(accidental_AUX) == "sharp")) ) accidental_AUX="flat" ! that is, if quarter tone up and accidental flat, then accidental changes to sharp. This avoid absurd syntax problems in LilyPond, such as gesih, and still outputs the correct note, which is a quarter tone higher than the pitch class


! Write the pitch itself
call MIDI_PITCH_TO_LP(pitch,accidental_AUX,quartertone_AUX)

! pitch duration
if (present(duration)) then
	write(*,"(A)",advance="NO") TRIM(duration)
	write(11,"(A)",advance="NO") TRIM(duration)
endif

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

end subroutine NOTE

