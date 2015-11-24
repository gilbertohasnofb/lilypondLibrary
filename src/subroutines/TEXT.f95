! Subroutine to add text above or below a note (or chord). Should be executed AFTER the subroutines NOTE or CHORD
! If called only with a textString, which can contain markup commands. DEFAULT values are: position = 0
subroutine TEXT(textString,position,italic,bold,offsetX,offsetY)

character (LEN=*), intent(in) :: textString ! text to be written
integer, optional, intent(in) :: position ! 0 = default position, 1 = above note, -1 = below note. Default = 0
logical, optional, intent(in) :: italic, bold ! style options, optional. Default = .FALSE.
real, optional, intent(in) :: offsetX, offsetY
integer :: position_AUX
logical :: italic_AUX, bold_AUX
real :: offsetX_AUX, offsetY_AUX
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

position_AUX=0
italic_AUX=.FALSE.
bold_AUX=.FALSE.
offsetX_AUX=0.
offsetY_AUX=0.

if (present(position)) position_AUX = position
if (present(italic)) italic_AUX = italic
if (present(bold)) bold_AUX = bold
if (present(offsetX)) offsetX_AUX = offsetX
if (present(offsetY)) offsetY_AUX = offsetY

if (LEN_TRIM(textString) /= 0) then

 ! tweak offset
  if ((offsetX_AUX /= 0) .OR. (offsetY_AUX /= 0)) then
    write(*,"(A,F4.1,A,F4.1,A)",advance="NO") "-\tweak extra-offset #'(", offsetX_AUX, " . ", offsetY_AUX, ")"
    write(11,"(A,F4.1,A,F4.1,A)",advance="NO") "-\tweak extra-offset #'(", offsetX_AUX, " . ", offsetY_AUX, ")"
  endif

  select case (position_AUX)
    case(0)
      write(*,"(A)",advance="NO") "-"
      write(11,"(A)",advance="NO") "-"
    case(1)
      write(*,"(A)",advance="NO") "^"
      write(11,"(A)",advance="NO") "^"
    case(-1)
      write(*,"(A)",advance="NO") "_" 
      write(11,"(A)",advance="NO") "_"
  end select
 
  write(*,"(A, 1x)",advance="NO") '\markup {'
  write(11,"(A, 1x)",advance="NO") '\markup {' 

  if (italic_AUX) then
    write(*,"(A, 1x)",advance="NO") '\italic' 
    write(11,"(A, 1x)",advance="NO") '\italic'
  endif

  if (bold_AUX) then
    write(*,"(A, 1x)",advance="NO") '\bold' 
    write(11,"(A, 1x)",advance="NO") '\bold'
  endif 

  write(*,"(A,A)",advance="NO") TRIM(textString)," }"
  write(11,"(A,A)",advance="NO") TRIM(textString)," }"
 
endif

end subroutine TEXT
