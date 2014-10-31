! add certain interesting snippets to the score. Should be called immediately after HEADER and
subroutine SNIPPET(slashedGraces,repeatBracket,naturalizeMusic)

logical, optional, intent(IN) :: slashedGraces ! this function adds a slash to grace notes in groups (single grace note automatically has a slash in LilyPond). Not that this function is still in beta.
! to use it, simply call SNIPPET(slashedGraces=.TRUE.) and then use the GRACE subroutine normally (no need to do anything else).
logical, optional, intent(IN) :: repeatBracket ! this function creates repeat brackets above repeated barlines in the style |----3x----|--2x--| etc. 
! After activating it via SNIPPET(repetitionBracket=.TRUE.), use call REPEATBRACKET(n) to start a repetition of n times, and to finish the repetition use call END_REPEATBRACKET or END_ANY
logical, optional, intent(IN) :: naturalizeMusic ! this function avoids accidentals such as ces, bis, fes, eis by using the command \naturalizeMusic (remember to call STAFF with naturalizeMusic=.TRUE.)

write(*,*) "% *************************************** SNIPPETS ***************************************"
write(11,*) "% *************************************** SNIPPETS ***************************************"
write(*,*)
write(11,*) 

if (present(slashedGraces)) then
	if (slashedGraces) then
		call SNIPPET_SLASHEDGRACES()
		write(*,*)
		write(11,*) 
	endif
endif

if (present(repeatBracket)) then
	if (repeatBracket) then
		call SNIPPET_REPEATBRACKET()
		write(*,*)
		write(11,*) 
	endif
endif

if (present(naturalizeMusic)) then
	if (naturalizeMusic) then
		call SNIPPET_NATURALIZEMUSIC()
		write(*,*)
		write(11,*) 
	endif
endif

write(*,*) "% ****************************************************************************************"
write(11,*) "% ****************************************************************************************"
write(*,*)
write(11,*) 

end subroutine SNIPPET
