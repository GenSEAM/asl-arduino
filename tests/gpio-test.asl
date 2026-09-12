(module asl-arduino/tests/gpio-test
  :d "Unit tests for GPIO pin modes and signal toggling."
  :x [test-make-pin test-write-pin test-read-pin test-blink-example run-tests]
  :i [(gpio :a g)
      (../examples/blink :a b)])

(df test-make-pin [] -> Bool
  :d "Verifies pin allocation defaults."
  (let [(p (g/make-pin 13 (g/pin-output)))]
    (assert (= (.-num p) 13) "Pin number must be 13")
    (assert (= (.-mode p) 1) "Pin mode must be 1 (output)")
    (assert (= (.-state p) 0) "Pin state must default to 0 (low)")
    true))

(df test-write-pin [] -> Bool
  :d "Verifies digital signal write updates state."
  (let [(p0 (g/make-pin 13 (g/pin-output)))
        (p1 (g/write-pin p0 (g/pin-high)))]
    (assert (= (.-state p1) 1) "Pin state must be 1 (high) after write")
    true))

(df test-read-pin [] -> Bool
  :d "Verifies reading pin voltage level."
  (let [(p0 (g/make-pin 2 (g/pin-input)))
        (p1 (g/write-pin p0 (g/pin-high)))]
    (assert (= (g/read-pin p1) 1) "Read pin must return 1 (high)")
    true))

(df test-blink-example [] -> Bool
  :d "Verifies standard Blink sketch state transitions."
  (let [(led0 (b/setup-blink))
        (led1 (b/step-blink led0 true))
        (led2 (b/step-blink led1 false))]
    (assert (= (.-state led1) 1) "Blink step on must set state to 1")
    (assert (= (.-state led2) 0) "Blink step off must set state to 0")
    true))

(df run-tests [] -> Bool
  :d "Runs all GPIO unit tests."
  (let [(t1 (test-make-pin))
        (t2 (test-write-pin))
        (t3 (test-read-pin))
        (t4 (test-blink-example))] (and t1 (and t2 (and t3 t4)))))
