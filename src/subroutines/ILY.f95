! opens a separate .ily file in which all music will be written into, until a END_ILY appears. Should be called BEFORE everything else (such as HEADER, STAFF and SCORE). Then, call INCLUDE("path") using the path of the ily inside a STAFF END_STAFF block to make use of it. Example of usage:
! 
! call ILY("A.ily")
!   call NOTE(60,"4")
! call END_ILY() 
! call ILY("B.ily")
!   call NOTE(48,"4")
! call END_ILY()
!
! call HEADER()
!   call STAFF()
!     call INCLUDE_FILE("A.ily")
!   call END_STAFF()
!   call STAFF()
!     call INCLUDE_FILE("B.ily")
!   call END_STAFF()
! call SCORE()


subroutine ILY(filename)

character (LEN=*), intent(IN) :: filename ! filename of the variable

! opening the output file
open(unit=11,file=TRIM(filename))

! opening a temp file
open(unit=7,file="temp3")
write(7,"(L1)") .FALSE. ! this will mean to the next subroutine that this one didn't finish with an advance="NO"

end subroutine ILY
