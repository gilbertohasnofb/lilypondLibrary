include "lilypondLibrary.f95"

program example2
use lilypondLibrary
implicit none

integer :: vector(3)

call HEADER(title="Example 2",composer="G. Agostinho",subtitle="the most complex example yet",dedication="to myself", &
filename="example2.ly")

	call STAFF(staffType="PianoStaff") ! creating a PianoStaff
		call NOTE(60,"4",D="\p",A="-.",H="\<") ! using note with dynamics, articulation and hairpin
		call NOTE(62,"4")
		call NOTE(64,"4")
		call NOTE(65,"4",D="\f")
		call BAR("|.") ! creating a barline
	call END_STAFF()
	
	call STAFF(staffType="PianoStaff") ! creating a PianoStaff
		call CLEF("bass")
		vector = (/48,52,55/) ! creating a C major chord in an integer vector
		call CHORD(vector,"1",A="--",D="\pp") ! using that vector to create a chord
		call BAR("|.") ! creating a barline
	call END_STAFF()

call SCORE(autoCompile=.TRUE.) ! this argument will summon lilypond as soon as you execute your program

end program example2
