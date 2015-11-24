! simple example of how to algorithmically produce music
! examples of subroutines KEY, BAR_CHECK

program example3
use lilypondLibrary
implicit none

integer, dimension(8) :: majorScale = (/0,2,4,5,7,9,11,12/)
integer :: i, pitch

call HEADER(title="Example 3",filename="example3.ly")

  call STAFF(staffType="Staff") ! creating a regular Staff
    call KEY(2,"major") ! first argument is the pitch class of the key, second is the mode. In this case, D Major
    
    do i=1,8
      pitch = 62 + majorScale(i)
      call NOTE(pitch,"4")
      if (i==4) call BAR_CHECK ! that is, after 4 notes, inser a bar check ("|" in LilyPond's notation). It also makes the output file more readable, since it adds a line break to the textfile
    enddo

    call BAR("|.")
  call END_STAFF()

call SCORE(autoCompile=.TRUE.)

end program example3
