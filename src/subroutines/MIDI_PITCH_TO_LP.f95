! Subroutine MIDI number -> LilyPond pitches
subroutine MIDI_PITCH_TO_LP(pitch,accidental,enharmonic,doubleAccidental,quartertone)

integer, intent(in) :: pitch ! MIDI no., i.e., 60 = C4. To use rests, use MIDI = 0 !!!
character (LEN=*), optional, intent(in) :: accidental ! if "is", "s" or "sharp, then the pitch will be notated with sharp accidental. If "es", "f" or "flat", then it will be notated as flat
logical, optional, intent(in) :: enharmonic ! if .TRUE., then C and F will be notated as B# and E#, respectively, and B and E will be notated as Cb and Fb, respectively
character (LEN=*), optional, intent(in) :: doubleAccidental ! if "is","isis,", "s" or "sharp, then the pitch will be notated as a double sharp WHEN POSSIBLE. If "es","eses", "f" or "flat", then it will be notated as double flat when possible
character (LEN=*), optional, intent(in) :: quartertone ! if "ih", "up" or "higher", then quarter tone higher, if "eh", "down" or "lower", then quarter tone lower. If "", "default" or "neuter", then no quarter tone will be used
integer :: pc, octave, pitchCorrection
integer :: aux
character (LEN=2) :: quartertone_AUX
character (LEN=4) :: doubleAccidental_AUX
logical :: accidental_AUX, quartertoneActive, enharmonic_AUX

! Calculating pitch class from MIDI number
pc = MOD(pitch,12)

accidental_AUX=.TRUE.
enharmonic_AUX = .FALSE.
doubleAccidental_AUX="  "
quartertone_AUX="  "
quartertoneActive=.FALSE.
pitchCorrection = 0 ! used to correct pitches due to double accidentals

if (present(accidental)) then
	if ((TRIM(accidental) == "is") .OR. (TRIM(accidental) == "s") .OR. (TRIM(accidental) == "sharp")) accidental_AUX=.TRUE.
	if ((TRIM(accidental) == "es") .OR. (TRIM(accidental) == "f") .OR. (TRIM(accidental) == "flat")) accidental_AUX=.FALSE.
endif

if (present(enharmonic)) enharmonic_AUX = enharmonic

if (present(quartertone)) then
	if ((TRIM(quartertone) == "ih") .OR. (TRIM(quartertone) == "higher") .OR. (TRIM(quartertone) == "up")) then
		quartertone_AUX="ih"
		quartertoneActive = .TRUE.
		accidental_AUX=.TRUE. ! forcing accidental to be sharp, since there is no such thing as besih in lilypond, but only aisih
		enharmonic_AUX = .FALSE. ! forcing no enharmonicity
		else if ((TRIM(quartertone) == "eh") .OR. (TRIM(quartertone) == "lower") .OR. (TRIM(quartertone) == "down")) then
			quartertone_AUX="eh"
			quartertoneActive = .TRUE.
			accidental_AUX=.FALSE. ! forcing flat		
			enharmonic_AUX = .FALSE. ! forcing no enharmonicity
		else 
			quartertone_AUX="  "			
	endif
endif

if ( (present(doubleAccidental)) .AND. (.NOT. quartertoneActive) ) then ! that is, double accidentals are only used when quartertones are not present.
	if ( ((TRIM(doubleAccidental)=="is") .OR. (TRIM(doubleAccidental)=="isis") .OR. (TRIM(doubleAccidental)=="sharp") .OR. &
	(TRIM(doubleAccidental)=="s")) .AND. ((pc == 2) .OR. (pc == 4) .OR. (pc == 7) .OR. (pc == 9) .OR. (pc == 11)) ) then ! since only some pitch classes allow double sharp
		doubleAccidental_AUX = "isis"
		pitchCorrection = -2 ! example:  pitch 62 is normally a d. As doublesharp, it is a cisis, or a pitch 60 with double sharp
		enharmonic_AUX = .FALSE.
	endif
	if ( ((TRIM(doubleAccidental)=="es") .OR. (TRIM(doubleAccidental)=="eses") .OR. (TRIM(doubleAccidental)=="flat") .OR. &
	(TRIM(doubleAccidental)=="f")) .AND. ((pc == 0) .OR. (pc == 2) .OR. (pc == 5) .OR. (pc == 7) .OR. (pc == 9)) ) then ! since only some pitch classes allow double sharp
		doubleAccidental_AUX = "eses"
		pitchCorrection = 2 ! example:  pitch 62 is normally a d. As doubleflat, it is a eeses, or a pitch 64 with double flat
		enharmonic_AUX = .FALSE.
	endif
endif

if (pitch==0) then ! i.e., a rest
	write(*,"(A)",advance="NO") "r"
	write(11,"(A)",advance="NO") "r"
	else if (pitch==-1) then ! i.e., a rest
		write(*,"(A)",advance="NO") "s"
		write(11,"(A)",advance="NO") "s"
	else

		! Calculating register (octave position) from MIDI number
		octave=-1 ! this initial value of -1 is necessary since MIDI no. 60 is C4, not C5 (which would be more logical, since 5 x 12 = 60)
		aux = pitch + pitchCorrection ! pitchCorrection is necessary when using double sharps and flats
		do while (aux >= 12)
			aux = aux - 12
			octave = octave + 1
		enddo
	 
		! writing pitch class
		select case (MOD((pc + pitchCorrection),12))
			case(0)
				if (.NOT. enharmonic_AUX) then
					write(*,"(A)",advance="NO") "c"
					write(11,"(A)",advance="NO") "c"
					else
						write(*,"(A)",advance="NO") "bis"
						write(11,"(A)",advance="NO") "bis"
						octave = octave -1
				endif
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
				if (.NOT. enharmonic_AUX) then
					write(*,"(A)",advance="NO") "e"
					write(11,"(A)",advance="NO") "e"
					else
						write(*,"(A)",advance="NO") "fes"
						write(11,"(A)",advance="NO") "fes"
				endif
			case(5)
				if (.NOT. enharmonic_AUX) then
					write(*,"(A)",advance="NO") "f"
					write(11,"(A)",advance="NO") "f"
					else
						write(*,"(A)",advance="NO") "eis"
						write(11,"(A)",advance="NO") "eis"
				endif
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
				if (.NOT. enharmonic_AUX) then
					write(*,"(A)",advance="NO") "b"
					write(11,"(A)",advance="NO") "b"
					else
						write(*,"(A)",advance="NO") "ces"
						write(11,"(A)",advance="NO") "ces"
						octave = octave + 1
				endif
		end select

		! writing double accidentals
		write(*,"(A)",advance="NO") TRIM(doubleAccidental_AUX)
		write(11,"(A)",advance="NO") TRIM(doubleAccidental_AUX)

		! writing quarter tones
		write(*,"(A)",advance="NO") TRIM(quartertone_AUX)
		write(11,"(A)",advance="NO") TRIM(quartertone_AUX)
			 
		! writing register
		select case (octave)
			case(-2)
				write(*,"(A)",advance="NO") ",,,,,"
				write(11,"(A)",advance="NO") ",,,,,"
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
			case(8)
				write(*,"(A)",advance="NO") "'''''"
				write(11,"(A)",advance="NO") "'''''"
			case(9)
				write(*,"(A)",advance="NO") "''''''"
				write(11,"(A)",advance="NO") "''''''"
		end select

endif

end subroutine MIDI_PITCH_TO_LP
