! examples of randomness

! first, defining some useful subroutines for dealing with random numbers
module randomModule
implicit none

contains

	! Subroutine INIT_RANDOM_SEED: selects a random value for RANDOM_SEED by using the computer clock, which assures that RANDOM will output different numbers each run
	! Adapted from: http://fortranwiki.org/fortran/show/random_seed
	subroutine INIT_RANDOM_SEED()

		integer :: i, N, x
		integer, dimension(:), allocatable :: seed

		call SYSTEM_CLOCK(count=x)

		call RANDOM_SEED(size=N)
		allocate(seed(N))

		seed=x+37*(/ (i - 1, i = 1, n) /)

		call RANDOM_SEED(put=seed)

		deallocate(seed)

	end subroutine INIT_RANDOM_SEED

! **********************************************************************************************************************************************************
	
	! Subroutine RANDOM INTEGER
	subroutine RANDOM_INT(x,N,offset) ! i.e., if offset=0: generates an integer x between 0 and (N-1). If offset=/=0: generates an integer x between (offset) and ((N-1)+offset). There are always N possibilities.

		integer, intent(OUT) :: x
		integer, intent(IN),optional :: N, offset
		integer :: N_AUX, offset_AUX
		real :: random_AUX

		! if called without N, N is set to 2 (i.e., two options: 0 and 1)
		N_AUX=2
		if (present(N)) N_AUX=N
		! if called without offset, offset is set to 0.
		offset_AUX=0
		if (present(offset)) offset_AUX=offset

		call RANDOM_NUMBER(random_AUX)
		x=floor(random_AUX*N_AUX) + offset_AUX ! i.e., random 3 = 1, 2 or 3      

	end subroutine RANDOM_INT

end module randomModule

! **********************************************************************************************************************************************************

program example5
use lilypondLibrary
use randomModule
implicit none

integer :: i, pitch

call INIT_RANDOM_SEED() ! generating a random seed for the pseudo-random number generator

call HEADER(title="Example 5",subtitle="example of random melody",filename="example5.ly")

	call STAFF(staffType="Staff") ! creating a regular Staff

		call STYLE(dodecaphonicNoRepeat=.TRUE.) ! this will add accidentals to all notes except for repeated ones. There are several possible arguments for the subroutine STYLE
	
		do i=1,8
			call RANDOM_INT(pitch,24,60) ! generating a random pitch between MIDI number 60 and 84
			call NOTE(pitch,"4")
		enddo
		
	call END_STAFF()


call SCORE(autoCompile=.TRUE.)

end program example5
