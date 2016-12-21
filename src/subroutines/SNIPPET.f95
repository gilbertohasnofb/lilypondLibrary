! add certain interesting snippets to the score. Should be called immediately after HEADER and
subroutine SNIPPET(slashedGraces,repeatBracket,naturalizeMusic,timesigNote,modernStraightFlag,ottavate,liveElectronics, &
minorTrills,graceOnBeat,graceMidiDuration,trillSpeed,crossStaffArpeggios,numericOttava,tupletAngles,horizontalTuplets)

logical, optional, intent(IN) :: slashedGraces ! this function adds a slash to grace notes in groups (single grace note automatically has a slash in LilyPond). Not that this function is still in beta.
! to use it, simply call SNIPPET(slashedGraces=.TRUE.) and then use the GRACE subroutine normally (no need to do anything else).
logical, optional, intent(IN) :: repeatBracket ! this function creates repeat brackets above repeated barlines in the style |----3x----|--2x--| etc. 
! After activating it via SNIPPET(repetitionBracket=.TRUE.), use call REPEATBRACKET(n) to start a repetition of n times, and to finish the repetition use call END_REPEATBRACKET or END_ANY
logical, optional, intent(IN) :: naturalizeMusic ! this function avoids accidentals such as ces, bis, fes, eis by using the command \naturalizeMusic (remember to call STAFF with naturalizeMusic=.TRUE.)
logical, optional, intent(IN) :: timesigNote ! This subroutine adds a snippet whose function is to display time signatures as, for instance, 3/quarter-note instead of 3/4. 
logical, optional, intent(IN) :: modernStraightFlag ! if true, then timesigNote will have modern straight flag style
logical, optional, intent(IN) :: ottavate ! This subroutine adds a snippet whose function is to automatically deal with ottavation (and 15a, and 8b and 15b)
logical, optional, intent(IN) :: liveElectronics ! This subroutine adds a snippet whose function is to create circled numbers with arrows below notes used for live electronics
logical, optional, intent(IN) :: minorTrills ! if .TRUE., all trills will be minor in the MIDI playback. Default = .FALSE.
logical, optional, intent(IN) :: graceOnBeat ! if .TRUE., grace notes will be played on the beat on the MIDI playback. Default = .FALSE.
logical, optional, intent(IN) :: crossStaffArpeggios ! if .TRUE., cross staff arpeggios will be affected by ARPEGGIO_TYPE
logical, optional, intent(IN) :: numericOttava ! if .TRUE., \numericOttava will output 8--| and 8___| instead of 8va---| and 8vb___|
character (LEN=*), optional, intent(IN) :: graceMidiDuration ! should be a string containing an integer or a fraction, such as "1" or "8/10"
character (LEN=*), optional, intent(IN) :: trillSpeed ! should be a string containing an integer or a fraction. Default = "1/64". The larger the denominator the faster the trill
logical, optional, intent(IN) :: tupletAngles ! if .TRUE., then use call TUPLET_ANGLES to offset and change angles of tuplet brackets
logical, optional, intent(IN) :: horizontalTuplets ! if .TRUE., then use call HORIZONTAL_TUPLETS to force all tuplet brackets to be horizontal

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

if (present(minorTrills)) then
  if (minorTrills) then
    call SNIPPET_MINOR_TRILLS()
    write(*,*)
    write(11,*) 
  endif
endif

if (present(trillSpeed)) then
  call SNIPPET_TRILL_SPEED(trillSpeed) 
  write(*,*)
  write(11,*) 
endif

if (present(graceOnBeat)) then
  if (graceOnBeat) then
    call SNIPPET_GRACE_ON_BEAT()
  endif
endif

if (present(graceMidiDuration)) then
  call SNIPPET_GRACE_MIDI_DURATION(graceMidiDuration) 
endif

if (present(crossStaffArpeggios)) then
  if (crossStaffArpeggios) then
    call SNIPPET_CROSS_STAFF_ARPEGGIOS()
  endif
endif

if (present(numericOttava)) then
  if (numericOttava) then
    call SNIPPET_NUMERICOTTAVA()
  endif
endif

if (present(tupletAngles)) then
  if (tupletAngles) then
    call SNIPPET_TUPLET_ANGLES()
  endif
endif
if (present(horizontalTuplets)) then
  if (horizontalTuplets) then
    call SNIPPET_HORIZONTAL_TUPLETS()
  endif
endif

write(*,*)
write(11,*) 
write(*,*) "% ****************************************************************************************"
write(11,*) "% ****************************************************************************************"
write(*,*)
write(11,*) 

end subroutine SNIPPET
