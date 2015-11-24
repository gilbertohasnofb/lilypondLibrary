! Subroutine STYLE: accidentals style, bar number visibility, note beaming, etc.
subroutine STYLE(barNumberVisibility, autoBeam, dodecaphonic, dodecaphonicNoRepeat, hideTiedAccidentalAfterBreak, &
pedalSustainStyleMixed, countPercentRepeats, numericTimeSignature, compressFullBarRests, Kirchenpausen, modernStraightFlag, &
stemlet, autoKneeGap, trillToBarline, breakableBeam, dynamicPadding, hideBarline, hideTimeSignature, spacingIncrement, &
spacingIncrementRevert, textLength, dynamicTextExtraSpacing, markFormatter, arpeggio)

logical, optional, intent(IN) :: barNumberVisibility ! If .TRUE., then every system will display bar numbers. If .FALSE., then bar numbers are hidden. Affects whole Score. Default = .TRUE.
logical, optional, intent(IN) :: autoBeam ! If .TRUE., then notes of value 8 or lower will be beamed automatically. Affects Staff only. Default = .TRUE.
logical, optional, intent(IN) :: dodecaphonic ! If .TRUE., then every note will have an accidental preceeding it ('dodecaphonic style'). Affects whole Score. Default = .FALSE.
logical, optional, intent(IN) :: dodecaphonicNoRepeat ! If .TRUE., then every note will have an accidental preceeding it, EXCEPT for repetitions and after barlines ('dodecaphonic style'). Affects whole Score. Default = .FALSE.
logical, optional, intent(IN) :: hideTiedAccidentalAfterBreak ! If .TRUE., then tied accidentals are restated in a new system. Affects Staff only. Default = .TRUE.
logical, optional, intent(IN) :: pedalSustainStyleMixed ! If .FALSE., Ped style is "Ped.  *". If .TRUE., style is "Ped. __/\___|". Affects Staff only. Default = .FALSE.
logical, optional, intent(IN) :: countPercentRepeats ! When using the percent method for writing bar repeats (%), it will add a number above each bar repetition when .TRUE. Affects Staff only. Default = .FALSE.
logical, optional, intent(IN) :: numericTimeSignature ! If .TRUE., only numerical Time Signatures are used (thus "4/4", not "C"). Affects Staff only. Default = .FALSE.
logical, optional, intent(IN) :: compressFullBarRests ! . If .TRUE., then multiple bar rests are grouped into a single one with a number above. Affects Staff only. Default = .FALSE.
logical, optional, intent(IN) :: Kirchenpausen ! . If .TRUE., then when there are ten or fewer measures of rests, a series of longa and breve rests (called in German “Kirchenpausen” - church rests) are used. Else, multi-measure rests are used. Affects Staff only. Default = .TRUE.
logical, optional, intent(IN) :: modernStraightFlag ! If .TRUE., then notes with durations shorter than a quarter note will have straight flags instead of the traditional curved ones. Affects Staff only. Default = .FALSE.
logical, optional, intent(IN) :: stemlet ! If .TRUE., stemlets will connect rests to the beams. Affects Staff only. Default = .FALSE.
logical, optional, intent(IN) :: autoKneeGap ! If .TRUE., LilyPond will use kneed beams. Affects Staff only. Default = .TRUE.
logical, optional, intent(IN) :: trillToBarline ! If .TRUE., trill spans are drawn until barline, not until next notehead. Affects Staff only. Default = .FALSE.
logical, optional, intent(IN) :: breakableBeam ! If .TRUE., notes can be beamed across systems. Affects Staff only. Default = .FALSE.
real, optional, intent(IN) :: dynamicPadding ! padding for dynamics (can be set to bring all the dynamics have the same vertical position, except in extreme cases). Affects Staff only.
logical, optional, intent(IN) :: hideBarline ! If .TRUE., then all barlines of the current staff are going to be hidden. Affects Staff only. Default = .FALSE.
logical, optional, intent(IN) :: hideTimeSignature ! If .TRUE., all time signatures of the staff are hidden. Affects Staff only. Default = .FALSE.
real, optional, intent(IN) :: spacingIncrement ! controls the spacing between all notes in the score (it can tighten or loose the spacing). Affects whole Score.
logical, optional, intent(IN) :: spacingIncrementRevert ! if spacingIncrement has been used before and the user wants to set its values to LilyPond's default, then use spacingIncrementRevert = .TRUE. Affects whole Score.
logical, optional, intent(IN) :: textLength ! if .TRUE., Lilypond waits for a text string to finish before continuing to the next note (so no vertical shift due to colliding text). Does NOT influence dynamic text (use dyn_text_spacing for that). Affects Staff only. Default = .FALSE.
logical, optional, intent(IN) :: dynamicTextExtraSpacing ! If .TRUE., Lilypond extends the horizontal spacing between two notes in order to avoid collision between two dynamic texts Affects Staff only. Default = .FALSE.
character (LEN=*), optional, intent(in) :: markFormatter ! if markFormatter = "" (empty) or "default" then default layout. If = "box", then boxed rehearsal marks, if = "circle", circled rehearsal marks. Note: only works with \default (i.e., if no text is presen when calling MARK). Capitalization doesn't matter.
character (LEN=*), optional, intent(in) :: arpeggio ! if arpeggio = "" (empty), "normal" or "default" then default arpeggios. Other options are: "arrowup", "arrowdown", "bracket", "parenthesis" and "parenthesisdashed". Capitalization doesn't matter.
character (LEN=256) :: markFormatter_AUX, arpeggio_AUX
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
write(7,"(L1)") .FALSE. ! this will mean to the next subroutine that this one didn't finish with an advance="NO"
! =================================

! Bar numbers
if (present(barNumberVisibility)) then
  if (barNumberVisibility) then
    write(*,"(A)") "  \set Score.barNumberVisibility = #all-bar-numbers-visible"
    write(11,"(A)") "  \set Score.barNumberVisibility = #all-bar-numbers-visible"
    else
      write(*,"(A)") "  \override Score.BarNumber.stencil = ##f"
      write(11,"(A)") "  \override Score.BarNumber.stencil = ##f"
  endif
endif

! Beaming
if (present(autoBeam)) then
  if (autoBeam) then
    write(*,"(A)") "  \autoBeamOn"
    write(11,"(A)") "  \autoBeamOn"
    else
      write(*,"(A)") "  \autoBeamOff"
      write(11,"(A)") "  \autoBeamOff"
  endif
endif

! Accidentals
if (present(dodecaphonic)) then 
  if (dodecaphonic) then
    write(*,"(A)") "  \accidentalStyle Score.dodecaphonic" 
    write(11,"(A)") "  \accidentalStyle Score.dodecaphonic"
    else
      write(*,"(A)") "  \accidentalStyle Score.default"
      write(11,"(A)") "  \accidentalStyle Score.default"
  endif
endif

if (present(dodecaphonicNoRepeat)) then 
  if (dodecaphonicNoRepeat) then
    write(*,"(A)") "  \accidentalStyle Score.dodecaphonic-no-repeat" 
    write(11,"(A)") "  \accidentalStyle Score.dodecaphonic-no-repeat"
    else
      write(*,"(A)") "  \accidentalStyle Score.default"
      write(11,"(A)") "  \accidentalStyle Score.default"
  endif
endif

! Tied accidentals
if (present(hideTiedAccidentalAfterBreak)) then
  if (hideTiedAccidentalAfterBreak) then
    write(*,"(A)") "  \override Staff.Accidental.hide-tied-accidental-after-break = ##t"
    write(11,"(A)") "  \override Staff.Accidental.hide-tied-accidental-after-break = ##t"
    else
      write(*,"(A)") "  \override Staff.Accidental.hide-tied-accidental-after-break = ##f"
      write(11,"(A)") "  \override Staff.Accidental.hide-tied-accidental-after-break = ##f"
  endif
endif

! Mixed pedal style (i.e., Ped.__/\_____| and not Ped.    * )
if (present(pedalSustainStyleMixed)) then
  if (pedalSustainStyleMixed) then
    write(*,"(A)") "  \set Staff.pedalSustainStyle = #'mixed"
    write(11,"(A)") "  \set Staff.pedalSustainStyle = #'mixed"
    else
      write(*,"(A)") "  \set Staff.pedalSustainStyle = #'text"
      write(11,"(A)") "  \set Staff.pedalSustainStyle = #'text"
  endif
endif

! When using the percent method for writing bar repeats (%), it will add a number above each bar repetition when .TRUE.
if (present(countPercentRepeats)) then
  if (countPercentRepeats) then
    write(*,"(A)") "  \set countPercentRepeats = ##t"
    write(11,"(A)") "  \set countPercentRepeats = ##t"
    else
      write(*,"(A)") "  \set countPercentRepeats = ##f"
      write(11,"(A)") "  \set countPercentRepeats = ##f"
  endif
endif

if (present(numericTimeSignature)) then
  if (numericTimeSignature) then
    write(*,"(A)") "  \numericTimeSignature" 
    write(11,"(A)") "  \numericTimeSignature"
    else
      write(*,"(A)") "  \defaultTimeSignature"
      write(11,"(A)") "  \defaultTimeSignature"
  endif
endif

if (present(compressFullBarRests))then
  if (compressFullBarRests) then
    write(*,"(A)") "  \compressFullBarRests" 
    write(11,"(A)") "  \compressFullBarRests"
    else
      write(*,"(A)") "  \expandFullBarRests"
      write(11,"(A)") "  \expandFullBarRests"
  endif
endif

if (present(Kirchenpausen))then
  if (.NOT. Kirchenpausen) then
    write(*,"(A)") "  \override Staff.MultiMeasureRest.expand-limit = #2" 
    write(11,"(A)") "  \override Staff.MultiMeasureRest.expand-limit = #2"
    else
      write(*,"(A)") "  \revert MultiMeasureRest.expand-limit"
      write(11,"(A)") "  \revert MultiMeasureRest.expand-limit"
  endif
endif

if (present(modernStraightFlag)) then
  if (modernStraightFlag) then
    write(*,"(A)") "  \override Staff.Flag.stencil = #modern-straight-flag"
    write(11,"(A)") "  \override Staff.Flag.stencil = #modern-straight-flag"
    else
      write(*,"(A)") "  \revert Staff.Flag.stencil"
      write(11,"(A)") "  \revert Staff.Flag.stencil"
  endif
endif

if (present(stemlet)) then
  if (stemlet) then
    write(*,"(A)") "  \override Staff.Stem.stemlet-length = 0.75"
    write(11,"(A)") "  \override Staff.Stem.stemlet-length = 0.75"
    else
      write(*,"(A)") "  \override Staff.Stem.stemlet-length = ##f"
      write(11,"(A)") "  \override Staff.Stem.stemlet-length = ##f"
  endif
endif

if (present(autoKneeGap)) then
  if (.NOT. autoKneeGap) then
    write(*,"(A)") "  \override Staff.Beam.auto-knee-gap = ##f"
    write(11,"(A)") "  \override Staff.Beam.auto-knee-gap = ##f"  
    else
      write(*,"(A)") "  \revert Staff.Beam.auto-knee-gap"
      write(11,"(A)") "  \revert Staff.Beam.auto-knee-gap"
  endif
endif

if (present(trillToBarline)) then
  if (trillToBarline) then
    write(*,"(A)") "  \override Staff.TrillSpanner.to-barline = ##t"
    write(11,"(A)") "  \override Staff.TrillSpanner.to-barline = ##t"
    else
      write(*,"(A)") "  \revert Staff.TrillSpanner.to-barline"
      write(*,"(A)") "  \revert Staff.TrillSpanner.to-barline"
  endif
endif

if (present(breakableBeam)) then
  if (breakableBeam) then
    write(*,"(A)") "  \override Staff.Beam.breakable = ##t"
    write(11,"(A)") "  \override Staff.Beam.breakable = ##t"
    else
      write(*,"(A)") "  \override Staff.Beam.breakable = ##f"
      write(11,"(A)") "  \override Staff.Beam.breakable = ##f"
  endif
endif

if (present(dynamicPadding)) then
  write(*,"(A,F4.1)") "  \override Staff.DynamicLineSpanner.staff-padding = ", dynamicPadding
  write(11,"(A,F4.1)") "  \override Staff.DynamicLineSpanner.staff-padding = ", dynamicPadding
endif

if (present(hideBarline)) then
  if (hideBarline) then
    write(*,"(A)") "  \override Staff.BarLine.stencil = ##f"
    write(11,"(A)") "  \override Staff.BarLine.stencil = ##f"
    else
      write(*,"(A)") "  \revert Staff.BarLine.stencil"
      write(11,"(A)") "  \revert Staff.BarLine.stencil"
  endif
endif

if (present(hideTimeSignature)) then
  if (hideTimeSignature) then
    write(*,"(A)") "  \override Staff.TimeSignature.stencil = ##f"
    write(11,"(A)") "  \override Staff.TimeSignature.stencil = ##f"
    else
      write(*,"(A)") "  \revert Staff.TimeSignature.stencil"
      write(11,"(A)") "  \revert Staff.TimeSignature.stencil"
  endif
endif

if (present(spacingIncrement)) then
  write(*,"(A)") "  \newSpacingSection"
  write(11,"(A)") "  \newSpacingSection"
  write(*,"(A,F4.1)")"  \override Score.SpacingSpanner.spacing-increment = ", spacingIncrement
  write(11,"(A,F4.1)")"  \override Score.SpacingSpanner.spacing-increment = ", spacingIncrement
endif

if (present(spacingIncrementRevert)) then
  if (spacingIncrementRevert) then
    write(*,"(A)") "  \newSpacingSection"
    write(11,"(A)") "  \newSpacingSection"
    write(*,"(A,F4.1)")"  \revert Score.SpacingSpanner.spacing-increment"
    write(11,"(A,F4.1)")"  \revert Score.SpacingSpanner.spacing-increment"
  endif
endif

if (present(textLength)) then
  if (textLength) then
    write(*,"(A)") "  \textLengthOn"
    write(11,"(A)") "  \textLengthOn"
    else
      write(*,"(A)") "  \textLengthOff"
      write(11,"(A)") "  \textLengthOff"
  endif
endif

if (present(dynamicTextExtraSpacing)) then
  if (dynamicTextExtraSpacing) then
    write(*,"(A)") "  \override Staff.DynamicText.extra-spacing-width = #'(-0.5 . 0.5)"
    write(11,"(A)") "  \override Staff.DynamicText.extra-spacing-width = #'(-0.5 . 0.5)"
    else
      write(*,"(A)") "  \override Staff.DynamicText.extra-spacing-width = #'(+inf.0 . -inf.0)"
      write(11,"(A)") "  \override Staff.DynamicText.extra-spacing-width = #'(+inf.0 . -inf.0)"
  endif
endif

if (present(markFormatter)) then  

  markFormatter_AUX = TRIM(markFormatter)
  call LCASE(markFormatter_AUX)  
  
  select case(TRIM(markFormatter_AUX))
  
    case("")
    write(*,"(A)") "  \set Score.markFormatter = #format-mark-alphabet"
    write(11,"(A)") "  \set Score.markFormatter = #format-mark-alphabet"  
    
    case("default")
    write(*,"(A)") "  \set Score.markFormatter = #format-mark-alphabet"
    write(11,"(A)") "  \set Score.markFormatter = #format-mark-alphabet"  
    
    case("box")
    write(*,"(A)") "  \set Score.markFormatter = #format-mark-box-alphabet"
    write(11,"(A)") "  \set Score.markFormatter = #format-mark-box-alphabet"  
    
    case("circle")
    write(*,"(A)") "  \set Score.markFormatter = #format-mark-circle-alphabet"
    write(11,"(A)") "  \set Score.markFormatter = #format-mark-circle-alphabet"  
    
    case default
    write(*,"(A)") "  \set Score.markFormatter = #format-mark-alphabet"
    write(11,"(A)") "  \set Score.markFormatter = #format-mark-alphabet"  
    
  end select
  
endif

if (present(arpeggio)) then  

  arpeggio_AUX = TRIM(arpeggio)
  call LCASE(arpeggio_AUX)  
  
  select case(TRIM(arpeggio_AUX))
  
    case("")
    write(*,"(A)") "  \arpeggioNormal"
    write(11,"(A)") "  \arpeggioNormal"  
    
    case("default")
    write(*,"(A)") "  \arpeggioNormal"
    write(11,"(A)") "  \arpeggioNormal"
    
    case("normal")
    write(*,"(A)") "  \arpeggioNormal"
    write(11,"(A)") "  \arpeggioNormal"    
    
    case("arrowup")
    write(*,"(A)") "  \arpeggioArrowUp"
    write(11,"(A)") "  \arpeggioArrowUp"  
    
    case("arrowdown")
    write(*,"(A)") "  \arpeggioArrowDown"
    write(11,"(A)") "  \arpeggioArrowDown"  
    
    case("bracket")
    write(*,"(A)") "  \arpeggioBracket"
    write(11,"(A)") "  \arpeggioBracket"  
    
    case("parenthesis")
    write(*,"(A)") "  \arpeggioParenthesis"
    write(11,"(A)") "  \arpeggioParenthesis"  
    
    case("parenthesisdashed")
    write(*,"(A)") "  \arpeggioParenthesisDashed"
    write(11,"(A)") "  \arpeggioParenthesisDashed"  
    
    case default
    write(*,"(A)") "  \arpeggioNormal"
    write(11,"(A)") "  \arpeggioNormal"
    
  end select
  
endif

end subroutine STYLE

