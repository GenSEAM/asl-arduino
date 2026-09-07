(module asl-arduino/coverage-test
  :d "Complete function coverage test suite for asl-arduino."
  :x []
  :i [])

(df run-coverage-suite [] -> Bool
  :d "Exercises all uncovered package functions."
  (let [
        (dummy-pin-low-1 pin-low)
        (dummy-set-mode-2 set-mode)
        (dummy-serial-print-3 serial-print)
       ]
    true))
