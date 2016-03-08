! example 6
! using ILY and END_ILY subroutines

program example6
use lilypondLibrary
implicit none

! the blocks ILY ... END_ILY should be called before anything. They will create files containing any music written inside the block.
call ILY("example6-A.ily")
  call NOTE(60,"4")
  call NOTE(62,"4")
  call NOTE(64,"4")
  call NOTE(65,"4")
call END_ILY

call ILY("example6-B.ily")
  call NOTE(60,"2")
  call NOTE(55,"2")
call END_ILY

! *****

call HEADER(title="Example 6",filename="example6.ly")

  call STAFF
    call INCLUDE_FILE("example6-A.ily") ! now those files created before by the block ILY ... END_ILY will be included using INCLUDE_FILE and will be associated with a regular variable created by STAFF
  call END_STAFF
  
  call STAFF
    call INCLUDE_FILE("example6-B.ily")
  call END_STAFF

call SCORE

! so this program will output three files, example6.ly, example6-A.ily and example6-B.ily. The music itself will be contained in the .ily files, and two \include command are present in the main .ly file

end program example6
