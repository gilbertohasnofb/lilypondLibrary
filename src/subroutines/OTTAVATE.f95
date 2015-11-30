! automatic ottavation. Needs SNIPPET(ottavate=.TRUE.)
subroutine OTTAVATE(ottava,fifteenth,ottavaBassa,fifteenthBassa,openingClef)

integer, intent(IN), optional :: ottava,fifteenth,ottavaBassa,fifteenthBassa ! each one of these variables correspond to the number of ledger lines in which ottava, fifteenth, ottava bassa and fifteenth bassa will be activate. Default values are 4, 7, -4 and -7, respectively
character (LEN=*), intent(IN), optional :: openingClef ! ottavate ignores any clef that was set before it was called, assuming the music is in treble clef. If a different clef is in use, then call this subroutine with one of the following values: treble, treble_8, bass, bass_8, alto, tenor
integer :: ottava_aux,fifteenth_aux,ottavaBassa_aux,fifteenthBassa_aux
logical :: previousAdvanceNo ! used to find out what was the spacing before this subroutine was called. if it finished with an advance="NO" or not

! =========== spacing ==============
rewind(unit=7)
read(7,"(L1)") previousAdvanceNo
if (previousAdvanceNo) then
  write(*,*)
  write(11,*)
endif
close(unit=7,status="delete")
open(unit=7,file="temp3")
write(7,"(L1)") .FALSE. ! this will mean to the next subroutine that this one did not finish with an advance="NO"
! =================================

ottava_aux = 4
fifteenth_aux = 7
ottavaBassa_aux = -4
fifteenthBassa_aux = -7

if (present(ottava)) ottava_aux = ottava
if (present(fifteenth)) fifteenth_aux = fifteenth
if (present(ottavaBassa)) ottavaBassa_aux = ottavaBassa
if (present(fifteenthBassa)) fifteenthBassa_aux = fifteenthBassa

if (present(openingClef)) then
  write(*,"(A,I2,A,I2,A,I2,A,I2,A,A,A,A)") "  \ottavate #'(",ottava_aux," . ",fifteenth_aux,") #'(",ottavaBassa_aux, &
  " . ",fifteenthBassa_aux,") #'((opening-clef . ", TRIM(openingClef) ,")) {"
  write(11,"(A,I2,A,I2,A,I2,A,I2,A,A,A,A)") "  \ottavate #'(",ottava_aux," . ",fifteenth_aux,") #'(",ottavaBassa_aux, &
  " . ",fifteenthBassa_aux,") #'((opening-clef . ", TRIM(openingClef) ,")) {"
  else
    write(*,"(A,I2,A,I2,A,I2,A,I2,A)") "  \ottavate #'(",ottava_aux," . ",fifteenth_aux,") #'(",ottavaBassa_aux," . ", &
    fifteenthBassa_aux,") {"
    write(11,"(A,I2,A,I2,A,I2,A,I2,A)") "  \ottavate #'(",ottava_aux," . ",fifteenth_aux,") #'(",ottavaBassa_aux," . ", &
    fifteenthBassa_aux,") {"
endif

end subroutine OTTAVATE
