! makes LilyPond compile a file. Not necessary if using either SCORE or FORCE_CLOSE with the option autoCompile set to .TRUE.
subroutine COMPILE(filename)

character (LEN=256), intent(IN) :: filename
logical :: error, condition

inquire(file=filename,exist=condition)

close(unit=11,status="keep") ! closing the file

if (condition)then
  write(*,"(A)") "Compiling your code:"
  write(*,*)
  call SYSTEM("lilypond "//TRIM(filename))
  write(*,*)
  else
    write(*,"(A,A,A)") "The file "//TRIM(filename)//" does not exist"
    write(*,*)   
endif

end subroutine COMPILE
