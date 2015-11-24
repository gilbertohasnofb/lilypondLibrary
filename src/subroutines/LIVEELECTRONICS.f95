! to be called AFTER a note or chord. Creates a circled number with an arrow and a description text. Needs SNIPPET(liveElectronics=.TRUE.)
subroutine LIVEELECTRONICS(N,hshift,text)

integer, intent(IN) :: N
real, optional, intent(IN) :: hshift ! horizontal shift
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


write(*,"(A)",advance="NO") '\LE '
write(11,"(A)",advance="NO") '\LE '

if ((N >= 0) .AND. (N < 10)) then ! the best looking output is "  n  " for n={0,9}, " nn " for n={10,99} and "nnn" for n={100,999}
  write(*,"(A,I1,A)",advance="NO") '"  ', N, '  " '
  write(11,"(A,I1,A)",advance="NO") '"  ', N, '  " '
  else if ((N >= 10) .AND. (N < 100)) then
    write(*,"(A,I2,A)",advance="NO") '" ', N, ' " '
    write(11,"(A,I2,A)",advance="NO") '" ', N, ' " '
  else if ((N >= 100) .AND. (N < 1000)) then
    write(*,"(A,I3,A)",advance="NO") '"', N, '" '
    write(11,"(A,I3,A)",advance="NO") '"', N, '" '
  else
    write(*,"(A)",advance="NO") '"  ?  " '
    write(11,"(A)",advance="NO") '"  ?  " '
endif

if (present(hshift)) then
  write(*,"(F5.1,1X)",advance="NO") hshift
  write(11,"(F5.1,1X)",advance="NO") hshift
endif

if (present(text)) then
  write(*,"(A,A,A)",advance="NO") '"', TRIM(text), '" '
  write(11,"(A,A,A)",advance="NO") '"', TRIM(text), '" '
  else
    write(*,"(A)",advance="NO") '"" '
    write(11,"(A)",advance="NO") '"" '
endif

end subroutine LIVEELECTRONICS
