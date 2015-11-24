! to be called AFTER a note or chord. Use arguments such as:
! "fermata", "shortfermata", "longfermata", " trill", "mordent", "turn", "prall", "flageolet", "open", "halfopen", "snappizzicato", "upbow", "downbow", "espressivo", "segno", "coda", etc...
subroutine SYMBOL(c,position)

character (LEN=*), intent(IN) :: c
integer, optional, intent(IN) :: position ! if = 0, then regular position. if = 1, forced above note, if = -1, forced below
logical :: previousAdvanceNo ! used to find out what was the spacing before this subroutine was called. if it finished with an advance="NO" or not

! =========== spacing ==============
rewind(unit=7)
read(7,"(L1)") previousAdvanceNo
if (.NOT. previousAdvanceNo) then
  write(*,"(A)",advance="NO") "  "
  write(11,"(A)",advance="NO") "  "
endif
close(unit=7,status="delete")
open(unit=7,file="temp3")
write(7,"(L1)") .TRUE. ! this will mean to the next subroutine that this one did finish with an advance="NO"
! =================================

if (present(position)) then
  if (position == 0) then
    write(*,"(A1)",advance="NO") "-"
    write(11,"(A1)",advance="NO") "-"
    else if (position >= 1) then
      write(*,"(A1)",advance="NO") "^"
      write(11,"(A1)",advance="NO") "^"
    else if (position <= 1) then
      write(*,"(A1)",advance="NO") "_"
      write(11,"(A1)",advance="NO") "_"
  endif
  else  
    write(*,"(A1)",advance="NO") "-"
    write(11,"(A1)",advance="NO") "-"
endif

write(*,"(A,A)",advance="NO") "\",TRIM(c)
write(11,"(A,A)",advance="NO") "\",TRIM(c)

end subroutine SYMBOL
