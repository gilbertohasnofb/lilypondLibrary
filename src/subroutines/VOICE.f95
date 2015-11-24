! outputs \voiceOne, \voiceTwo, etc...
subroutine VOICE(i)

integer, intent(in) :: i ! if 1-4 then \voiceOne-\voiceFour, if 0 then \oneVoice
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
write(7,"(L1)") .FALSE. ! this will mean to the next subroutine that this one did finish with an advance="NO"
! =================================

select case (i)
  case(1)
    write(*,"(A)") "  \voiceOne"
    write(11,"(A)") "  \voiceOne"
  case(2)
    write(*,"(A)") "  \voiceTwo"
    write(11,"(A)") "  \voiceTwo"
  case(3)
    write(*,"(A)") "  \voiceThree"
    write(11,"(A)") "  \voiceThree"
  case(4)
    write(*,"(A)") "  \voiceFour"
    write(11,"(A)") "  \voiceFour"
  case(0)
    write(*,"(A)") "  \oneVoice"
    write(11,"(A)") "  \oneVoice"
  case default
    write(*,"(A)") "  \oneVoice"
    write(11,"(A)") "  \oneVoice"
end select

end subroutine VOICE
