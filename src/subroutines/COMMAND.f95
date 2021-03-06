! can be used to add ANY command to the code. E.g.:
! call COMMAND("\break c'1\startTrillSpan g'1\stopTrillSpan")
subroutine COMMAND(text,lineSkip,advanceNo)

character (LEN=*), intent(IN) :: text
logical, intent(IN), optional :: lineSkip, advanceNo
logical :: previousAdvanceNo ! used to find out what was the spacing before this subroutine was called. if it finished with an advance="NO" or not

! =========== spacing ==============
rewind(unit=7)
read(7,"(L1)") previousAdvanceNo
if (previousAdvanceNo) then
  if ((.NOT. present(lineSkip)) .OR. (lineSkip)) then
    write(*,*)
    write(11,*)
  endif
endif
close(unit=7,status="delete")
open(unit=7,file="temp3")
! =================================

if (present(advanceNo) .AND. (advanceNo)) then
  write(*,"(A)",advance="NO") text
  write(11,"(A)",advance="NO") text
  write(7,"(L1)") .TRUE. ! this will mean to the next subroutine that this one did finish with an advance="NO"
  else
    write(*,"(A)") text
    write(11,"(A)") text
    write(7,"(L1)") .FALSE. ! this will mean to the next subroutine that this one didn't finish with an advance="NO"
endif

end subroutine COMMAND
