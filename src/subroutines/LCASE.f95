! Converts any word into lower case
subroutine LCASE(text_string) 

character (LEN=*) , intent(INOUT) :: text_string
integer :: i, N, check

N = LEN(text_string) 

do i=1,N
  check = ICHAR(text_string(i:i)) 
  if (check >= 65 .AND. check < 90) then
    text_string(i:i) = CHAR(check+32)
  endif
enddo

end subroutine LCASE
