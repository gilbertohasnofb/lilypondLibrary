! add certain interesting snippets to the score. Should be called immediately after HEADER and
subroutine SNIPPET(slashedGraces,repeatBracket,naturalizeMusic,timesigNote,modernStraightFlag,ottavate,liveElectronics)

logical, optional, intent(IN) :: slashedGraces ! this function adds a slash to grace notes in groups (single grace note automatically has a slash in LilyPond). Not that this function is still in beta.
! to use it, simply call SNIPPET(slashedGraces=.TRUE.) and then use the GRACE subroutine normally (no need to do anything else).
logical, optional, intent(IN) :: repeatBracket ! this function creates repeat brackets above repeated barlines in the style |----3x----|--2x--| etc. 
! After activating it via SNIPPET(repetitionBracket=.TRUE.), use call REPEATBRACKET(n) to start a repetition of n times, and to finish the repetition use call END_REPEATBRACKET or END_ANY
logical, optional, intent(IN) :: naturalizeMusic ! this function avoids accidentals such as ces, bis, fes, eis by using the command \naturalizeMusic (remember to call STAFF with naturalizeMusic=.TRUE.)
logical, optional, intent(IN) :: timesigNote ! This subroutine adds a snippet whose function is to display time signatures as, for instance, 3/quarter-note instead of 3/4. 
logical, optional, intent(IN) :: modernStraightFlag ! if true, then timesigNote will have modern straight flag style
logical, optional, intent(IN) :: ottavate ! This subroutine adds a snippet whose function is to automatically deal with ottavation (and 15a, and 8b and 15b)
logical, optional, intent(IN) :: liveElectronics ! This subroutine adds a snippet whose function is to create circled numbers with arrows below notes used for live electronics

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

if (present(timesigNote)) then
  if (timesigNote) then
    if (present(modernStraightFlag) .AND. (modernStraightFlag)) then
      call SNIPPET_TIMESIG_NOTE(modernStraightFlag=.TRUE.)
      write(*,*)
      write(11,*) 
      else
        call SNIPPET_TIMESIG_NOTE()
        write(*,*)
        write(11,*) 
    endif
  endif
endif

if (present(ottavate)) then
  if (ottavate) then
    call SNIPPET_OTTAVATE()
    write(*,*)
    write(11,*) 
  endif
endif

if (present(liveElectronics)) then
  if (liveElectronics) then
    call SNIPPET_LIVEELECTRONICS()
    write(*,*)
    write(11,*) 
  endif
endif

write(*,*) "% ****************************************************************************************"
write(11,*) "% ****************************************************************************************"
write(*,*)
write(11,*) 

end subroutine SNIPPET
