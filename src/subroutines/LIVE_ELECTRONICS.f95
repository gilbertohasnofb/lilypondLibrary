! to be called AFTER a note or chord. Creates a circled number with an arrow and a description text. Needs SNIPPET(liveElectronics=.TRUE.)
subroutine LIVEELECTRONICS(N,arrowSize,text)

integer, intent(IN) :: N
real, optional, intent(IN) :: arrowSize ! horizontal shift
character (LEN=*), optional, intent(IN) :: text ! description text
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


write(*,"(A)",advance="NO") '\LE #'
write(11,"(A)",advance="NO") '\LE #'

if ((N >= 0) .AND. (N < 10)) then
  write(*,"(I1)",advance="NO") N
  write(11,"(I1)",advance="NO") N
  else if ((N >= 10) .AND. (N < 100)) then
    write(*,"(I2)",advance="NO") N
    write(11,"(I2)",advance="NO") N
  else if ((N >= 100) .AND. (N < 1000)) then
    write(*,"(I3)",advance="NO") N
    write(11,"(I3)",advance="NO") N
  else
    write(*,"(A)",advance="NO") "0"
    write(11,"(A)",advance="NO") "0"
endif

if (present(arrowSize)) then
  write(*,"(F5.1,1X)",advance="NO") arrowSize
  write(11,"(F5.1,1X)",advance="NO") arrowSize
  else
    write(*,"(A)") "3.0"
    write(11,"(A)") "3.0"  
endif

if (present(text)) then
  write(*,"(A,A,A)",advance="NO") '"', TRIM(text), '" '
  write(11,"(A,A,A)",advance="NO") '"', TRIM(text), '" '
  else
    write(*,"(A)",advance="NO") '"" '
    write(11,"(A)",advance="NO") '"" '
endif

end subroutine LIVEELECTRONICS
