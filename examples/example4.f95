! example of how to deal with accidentals
! examples of subroutine STYLE and BREAK

program example4
use lilypondLibrary
implicit none

integer, dimension(8) :: majorScale = (/0,2,4,5,7,9,11,12/)
integer :: i, pitch

call HEADER(title="Example 4",filename="example4.ly")

	call STAFF(staffType="Staff") ! creating a regular Staff
	
		call STYLE(dodecaphonic=.TRUE.) ! this will add accidentals to all notes. There are several possible arguments for the subroutine STYLE
	
		! since these subroutine use MIDI numbers, the user has to specify the accidentals
		call NOTE(61,"1") ! produces a C sharp
		call BAR_CHECK
		
		call NOTE(61,"4",accidental="is") ! produces a C sharp (explicit accidental declaration, not necessary)
		call NOTE(61,"4",accidental="sharp") ! also produces a C sharp
		call NOTE(61,"4",accidental="s") ! this also produces a C sharp
		call NOTE(0,"4") ! simple rest		
		call BAR_CHECK
		
		call NOTE(61,"4",accidental="es") ! this will produce a D flat
		call NOTE(61,"4",accidental="flat") ! another way of producing a D flat
		call NOTE(61,"4",accidental="f") ! and yet another way
		call NOTE(0,"4")
		call BAR_CHECK
				
		call CHORD((/66,70,73/),"4") ! produces a F sharp chord
		call CHORD((/66,70,73/),"4",accidental="es") ! produces a G flat chord
		call CHORD((/66,70,73/),"4",accidentalVector=(/"es","is","is"/)) ! to specify individual accidentals in a chord, use accidentalVector. In this case, it results in Gb A# C#
		call NOTE(0,"4")
		call BAR_CHECK
		
		call BREAK ! adds a \break to the code, i.e., starts a new system
		
		call NOTE(60,"8") ! C
		call NOTE(60,"8",enharmonic=.TRUE.) ! enharmonic = B sharp
		call NOTE(65,"8") ! F
		call NOTE(65,"8",enharmonic=.TRUE.) ! enharmonic = E sharp
		call NOTE(64,"8") ! E
		call NOTE(64,"8",enharmonic=.TRUE.) ! enharmonic = F flat
		call NOTE(71,"8") ! B
		call NOTE(71,"8",enharmonic=.TRUE.) ! enharmonic = C flat
		call BAR_CHECK
				
		! dealing with quarter tones
		call NOTE(60,"4",quartertone="up") ! "up" or "higher" or "ih" produces a note raised by quarter tone
		call NOTE(60,"4",quartertone="neuter") ! "", "default" or "neuter" produces a standard note (no quarter tone)
		call NOTE(60,"4",quartertone="down") ! "down" or "lower" or "eh" produces a note raised by quarter tone
		call NOTE(0,"4")
		call BAR_CHECK
		
		! automatic resolution of conflicts: in lilypond's notation, a sharp note cannot be lowered by a quartertone, nor can a flat note be raised by a quartertone. Thus, when a conflict happens, the subroutines NOTE and CHORD will automatically change the accidental of the conflicting pitch
		call NOTE(66,"4",accidental="sharp",quartertone="up")
		call NOTE(66,"4",accidental="sharp",quartertone="neuter")
		call NOTE(66,"4",accidental="sharp",quartertone="down") ! this will be corrected to accidental = flat
		call NOTE(0,"4")
		call BAR_CHECK
		
		call NOTE(66,"4",accidental="flat",quartertone="up") ! this will be corrected to accidental = sharp
		call NOTE(66,"4",accidental="flat",quartertone="neuter")
		call NOTE(66,"4",accidental="flat",quartertone="down") 
		call NOTE(0,"4")
		call BAR_CHECK

		! same but with chords		
		call CHORD((/66,78/),"4",accidental="flat",quartertone="up") ! this will be corrected to accidental = sharp
		call CHORD((/66,78/),"4",accidental="sharp",quartertone="down") ! this will be corrected to accidental = flat
		call NOTE(0,"2")
		call BAR_CHECK
		
	call END_STAFF()

call SCORE(autoCompile=.TRUE.)

end program example4
