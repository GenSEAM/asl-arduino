(module asl-arduino/tests/serial-test
  :d "Unit tests for embedded UART serial interface."
  :x [test-init-serial test-serial-println run-tests]
  :i [(serial :a s)])

(df test-init-serial [] -> Bool
  :d "Verifies serial port initialization."
  (let [(port (s/init-serial 115200))]
    (assert (= (.-baud port) 115200) "Serial port baud must equal 115200")
    (assert (.-open port) "Serial port must be open")
    true))

(df test-serial-println [] -> Bool
  :d "Verifies string payload formatted with trailing newline."
  (let [(port (s/init-serial 9600))
        (out (s/serial-println port "PING"))]
    (assert (= out "PING\n") "Serial println output must equal PING\\n")
    true))

(df run-tests [] -> Bool
  :d "Runs all Serial unit tests."
  (do
    (assert (test-init-serial) "test-init-serial must pass")
    (assert (test-serial-println) "test-serial-println must pass")
    true))
