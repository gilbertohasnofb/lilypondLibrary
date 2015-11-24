! Subroutine MARK creates a rehearsal mark (which can be hacked to behave as text)

subroutine MARK(text,markup,offsetX,offsetY)

character (LEN=*), optional, intent(in) :: text ! text to be written
character (LEN=*), optional, intent(in) :: markup ! text to be written as markup
real, optional, intent(in) :: offsetX, offsetY
logical :: offset
real :: offsetX_AUX,offsetY_AUX
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
write(7,"(L1)") .FALSE. ! this will mean to the next subroutine that this one didn't finish with an advance="NO"
! =================================

offset=.FALSE.
offsetX_AUX=0.
offsetY_AUX=0.

if (present(offsetX)) offsetX_AUX = offsetX
if (present(offsetY)) offsetY_AUX = offsetY
if (present(offsetX) .OR. present(offsetY)) offset = .TRUE.

! skiping a line
write(*,*)
write(11,*)

! tweak offset
if (offset) then
  write(*,"(A,F4.1,A,F4.1,A)") "  \once \override Score.RehearsalMark.extra-offset = #'(", offsetX_AUX, " . ", offsetY_AUX, ")"
  write(11,"(A,F4.1,A,F4.1,A)") "  \once \override Score.RehearsalMark.extra-offset = #'(", offsetX_AUX, " . ", offsetY_AUX, ")"
endif

write(*,"(A)",advance="NO") "  \mark "
write(11,"(A)",advance="NO") "  \mark "

if (.NOT. present(markup)) then
  if (.NOT. present(text)) then
  write(*,"(A)") "\default"
  write(11,"(A)") "\default"
  else
    write(*,"(A,1x)") TRIM(text)
    write(11,"(A,1x)") TRIM(text)
  endif
  else
    write(*,"(A,A,A)") "\markup {", markup,"}"
    write(11,"(A,A,A)") "\markup {", markup,"}"
endif

end subroutine MARK

