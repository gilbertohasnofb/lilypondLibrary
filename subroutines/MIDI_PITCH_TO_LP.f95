! Subroutine MIDI number -> LilyPond pitches
subroutine MIDI_PITCH_TO_LP(pitch,accidental,quartertone)

integer, intent(in) :: pitch ! MIDI no., i.e., 60 = C4. To use rests, use MIDI = 0 !!!
character (LEN=*), optional, intent(in) :: accidental ! if "is", "s" or "sharp, then the pitch will be notated with sharp accidental. If "es", "f" or "flat", then it will be notated as flat
character (LEN=*), optional, intent(in) :: quartertone ! if "ih", "up" or "higher", then quarter tone higher, if "eh", "down" or "lower", then quarter tone lower. If "", "default" or "neuter", then no quarter tone will be used
integer :: pitch_class, octave
integer :: aux
character (LEN=2) :: quartertone_AUX
logical :: accidental_AUX

accidental_AUX=.TRUE.
quartertone_AUX="  "
if (present(accidental)) then
	if ((TRIM(accidental) == "is") .OR. (TRIM(accidental) == "s") .OR. (TRIM(accidental) == "sharp")) accidental_AUX=.TRUE.
	if ((TRIM(accidental) == "es") .OR. (TRIM(accidental) == "f") .OR. (TRIM(accidental) == "flat")) accidental_AUX=.FALSE.
endif
if (present(quartertone)) then
	if ((TRIM(quartertone) == "ih") .OR. (TRIM(quartertone) == "higher") .OR. (TRIM(quartertone) == "up")) quartertone_AUX="ih"
	if ((TRIM(quartertone) == "") .OR. (TRIM(quartertone) == "neuter") .OR. (TRIM(quartertone) == "default")) quartertone_AUX="  "
	if ((TRIM(quartertone) == "eh") .OR. (TRIM(quartertone) == "lower") .OR. (TRIM(quartertone) == "down")) quartertone_AUX="eh"
endif

if (pitch==0) then ! i.e., a rest
 write(*,"(A)",advance="NO") "r"
 write(11,"(A)",advance="NO") "r"
 else 
	 if (pitch==-1) then ! i.e., a rest
		 write(*,"(A)",advance="NO") "s"
		 write(11,"(A)",advance="NO") "s"
		 else
			 ! Calculating pitch class from MIDI number
			 pitch_class=MOD(pitch,12)
	 
			 ! Calculating register (octave position) from MIDI number
			 octave=-1 ! this initial value of -1 is necessary since MIDI no. 60 is C4, not C5 (which would be more logical, since 5 x 12 = 60)
			 aux = pitch 
			 do while (aux >= 12)
				 aux = aux - 12
				 octave = octave + 1
			 enddo
			 
			 ! writing pitch class
			 select case (pitch_class)
			 case(0)
				 write(*,"(A)",advance="NO") "c"
				 write(11,"(A)",advance="NO") "c"
			 case(1)
				 if (accidental_AUX) then
					 write(*,"(A)",advance="NO") "cis"
					 write(11,"(A)",advance="NO") "cis"
					 else
						 write(*,"(A)",advance="NO") "des"
						 write(11,"(A)",advance="NO") "des"
				 endif
			 case(2)
				 write(*,"(A)",advance="NO") "d"
				 write(11,"(A)",advance="NO") "d"
			 case(3)
				 if (accidental_AUX) then
					 write(*,"(A)",advance="NO") "dis"
					 write(11,"(A)",advance="NO") "dis"
					 else
						 write(*,"(A)",advance="NO") "ees"
						 write(11,"(A)",advance="NO") "ees"
				 endif
				 case(4)
				 write(*,"(A)",advance="NO") "e"
				 write(11,"(A)",advance="NO") "e"
			 case(5)
				 write(*,"(A)",advance="NO") "f"
				 write(11,"(A)",advance="NO") "f"
			 case(6)
				 if (accidental_AUX) then
					 write(*,"(A)",advance="NO") "fis"
					 write(11,"(A)",advance="NO") "fis"
					 else
						 write(*,"(A)",advance="NO") "ges"
						 write(11,"(A)",advance="NO") "ges"
				 endif
			 case(7)
				 write(*,"(A)",advance="NO") "g"
				 write(11,"(A)",advance="NO") "g"
			 case(8)
				 if (accidental_AUX) then
					 write(*,"(A)",advance="NO") "gis"
					 write(11,"(A)",advance="NO") "gis"
					 else
						 write(*,"(A)",advance="NO") "aes"
						 write(11,"(A)",advance="NO") "aes"
				 endif
			 case(9)
				 write(*,"(A)",advance="NO") "a"
				 write(11,"(A)",advance="NO") "a"
			 case(10)
				 if (accidental_AUX) then
					 write(*,"(A)",advance="NO") "ais"
					 write(11,"(A)",advance="NO") "ais"
					 else
						 write(*,"(A)",advance="NO") "bes"
						 write(11,"(A)",advance="NO") "bes"
				 endif
			 case(11)
				 write(*,"(A)",advance="NO") "b"
				 write(11,"(A)",advance="NO") "b"
			 end select
			 
			 ! writing quarter tones
			 write(*,"(A)",advance="NO") TRIM(quartertone_AUX)
			 write(11,"(A)",advance="NO") TRIM(quartertone_AUX)
			 
			 ! writing register
			 select case (octave)
			 case(-1)
				 write(*,"(A)",advance="NO") ",,,,"
				 write(11,"(A)",advance="NO") ",,,,"
			 case(0)
				 write(*,"(A)",advance="NO") ",,,"
				 write(11,"(A)",advance="NO") ",,,"
			 case(1)
				 write(*,"(A)",advance="NO") ",,"
				 write(11,"(A)",advance="NO") ",,"
			 case(2)
				 write(*,"(A)",advance="NO") ","
				 write(11,"(A)",advance="NO") ","
			 ! case(3) = do nothing!!!
			 case(4)
				 write(*,"(A)",advance="NO") "'"
				 write(11,"(A)",advance="NO") "'"
			 case(5)
				 write(*,"(A)",advance="NO") "''"
				 write(11,"(A)",advance="NO") "''"
			 case(6)
				 write(*,"(A)",advance="NO") "'''"
				 write(11,"(A)",advance="NO") "'''"
			 case(7)
				 write(*,"(A)",advance="NO") "''''"
				 write(11,"(A)",advance="NO") "''''"
			 end select
	 endif
endif

end subroutine MIDI_PITCH_TO_LP
