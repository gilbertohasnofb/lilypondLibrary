! a simple piano example using notes and chords
! examples of subroutines BAR, CLEF, CHORD

program example2
use lilypondLibrary
implicit none

integer :: vector(3)

call HEADER(title="Example 2",composer="G. Agostinho",subtitle="the most complex example yet",dedication="to myself", &
filename="example2.ly")

	call STAFF(staffType="PianoStaff") ! creating a PianoStaff
		call NOTE(60,"4",D="\p",A="-.",H="\<",S="(") ! using note with dynamics, articulation and hairpin
		call NOTE(62) ! just like in LilyPond, it's not necessary to explicitly write durations for each note
		call NOTE(64)
		call NOTE(65,D="\f",S=")")
		call BAR("|.") ! creating a barline
	call END_STAFF
	
	call STAFF(staffType="PianoStaff") ! creating a PianoStaff
		call CLEF("bass")
		vector = (/48,52,55/) ! creating a C major chord in an integer vector
		call CHORD(vector,"2") ! using that vector to create a chord
		call CHORD(vector,A="--",D="\pp") ! similar to note, CHORD can take several other arguments
		call BAR("|.") ! creating a barline
	call END_STAFF

call SCORE(autoCompile=.TRUE.) ! this argument will summon lilypond as soon as you execute your program

end program example2
