class SituationEnum < EnumerateIt::Base
  associate_values(
    to_do: 1,
    in_progress: 2,
    test: 3,
    done: 4
  )
end
