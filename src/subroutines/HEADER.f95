subroutine HEADER(title,composer,subtitle,dedication,subsubtitle,instrument,poet,meter,arranger,version,filename,articulate)

character (LEN=*), optional, intent(IN) :: title, composer, subtitle, dedication, subsubtitle, instrument, poet, meter, arranger
character (LEN=*), optional, intent(IN) :: version ! if called without this argument, it will assume version 2.19.15, which is the version this library was tested with
character (LEN=*), optional, intent(IN) :: filename ! if called without this argument, it will create a file output.ly
logical, optional, intent(IN) :: articulate ! if .TRUE., it will include the script articulate.ly. Remember to also activate it in the SCORE subroutine
character (LEN=256) :: filename_AUX

filename_AUX = "output.ly"
if (present(filename)) filename_AUX = filename

! opening the output file
open(unit=11,file=TRIM(filename_AUX))

! creating a temporary file with the name of the file and with information about the articulate.ly script
open(unit=10,file="temp",status="replace")
write(10,"(A)") TRIM(filename_AUX)
if (present(articulate)) then
  write(10,"(L1)") articulate
  else
    write(10,"(A)") "F"
endif

! opening another temp file
open(unit=9,file="temp2")
close(unit=9,status="delete")

! opening another temp file
open(unit=7,file="temp3",status="replace")
write(7,"(L1)") .FALSE. ! this will mean to the next subroutine that this one didn't finish with an advance="NO"
  
! version
if (present(version)) then
  write(*,"(A,A,A)") '\version "', TRIM(version), '"'
  write(11,"(A,A,A)") '\version "', TRIM(version), '"'
endif

! skipping a line
write(*,*)
write(11,*)

! dealing with the articulate.ly script
if (present(articulate)) then
  if (articulate) then
    write(*,"(A)") '\include "articulate.ly"'
    write(11,"(A)") '\include "articulate.ly"'
    write(*,*)
    write(11,*)
  endif
endif

! header block
write(*,"(A)") "\header {"
write(11,"(A)") "\header {"

if (present(title)) then
  write(*,"(A,A,A)") '  title = \markup{', TRIM(title), '}'
  write(11,"(A,A,A)") '  title = \markup{', TRIM(title), '}'
endif

if (present(composer)) then
  write(*,"(A,A,A)") '  composer = \markup{', TRIM(composer), '}'
  write(11,"(A,A,A)") '  composer = \markup{', TRIM(composer), '}'
endif

if (present(subtitle)) then
  write(*,"(A,A,A)") '  subtitle = \markup{', TRIM(subtitle), '}'
  write(11,"(A,A,A)") '  subtitle = \markup{', TRIM(subtitle), '}'
endif

if (present(dedication)) then
  write(*,"(A,A,A)") '  dedication = \markup{', TRIM(dedication), '}'
  write(11,"(A,A,A)") '  dedication = \markup{', TRIM(dedication), '}'
endif

if (present(subsubtitle)) then
  write(*,"(A,A,A)") '  subsubtitle = \markup{', TRIM(subsubtitle), '}'
  write(11,"(A,A,A)") '  subsubtitle = \markup{', TRIM(subsubtitle), '}'
endif

if (present(instrument)) then
  write(*,"(A,A,A)") '  instrument = \markup{', TRIM(instrument), '}'
  write(11,"(A,A,A)") '  instrument = \markup{', TRIM(instrument), '}'
endif

if (present(poet)) then
  write(*,"(A,A,A)") '  poet = \markup{', TRIM(poet), '}'
  write(11,"(A,A,A)") '  poet = \markup{', TRIM(poet), '}'
endif

if (present(meter)) then
  write(*,"(A,A,A)") '  meter = \markup{', TRIM(meter), '}'
  write(11,"(A,A,A)") '  meter = \markup{', TRIM(meter), '}'
endif

if (present(arranger)) then
  write(*,"(A,A,A)") '  arranger = \markup{', TRIM(arranger), '}'
  write(11,"(A,A,A)") '  arranger = \markup{', TRIM(arranger), '}'
endif

write(*,"(A)") '  tagline = ""'
write(11,"(A)") '  tagline = ""'
write(*,"(A)") "}"
write(11,"(A)") "}"
write(*,*)
write(11,*)
  
end subroutine HEADER
