import serial
import serial.tools.list_ports
import struct
import time
import sys

START       = 0xF0
BALENA_COMMAND = 0x0B
SLEEP_COMMAND = 0x01
END         = 0xF7
ACK         = 0x00
POWER       = 16
POWER_STATE = 0
PAYLOAD_LEN = 7
HIGH        = 1
LOW         = 0

class Sleep(object):
    def __init__(self, port=serial.tools.list_ports.comports()[0].device):
        """Init sleep class
        The default values for the Serial interface match the default config on the coprocessor
        """
        self.ser = serial.Serial(
            port=port,
            baudrate=57600,
            parity=serial.PARITY_NONE,
            stopbits=serial.STOPBITS_ONE,
            bytesize=serial.EIGHTBITS,
            timeout=None
        )
        self.data = []

    def set(self, time, pin=POWER, state=POWER_STATE):
        """Set sleep params
        time  - period of time until the pin state is toggled (time is in milliseconds and should be uint32_t)
        pin   - gpio pin on the coprocessor
        state - initial state of pin (when timer expired this will invert)
        """
        try:
            assert sys.getsizeof(time) <= 32
        except AssertionError as error:
            print("Invalid: time must be uint32_t or smaller")
        print(time)
        self.data = list((time >> i) & 0xFF for i in range(0,32,8))
        self.data.insert(0,0x05) # initial period until delay starts
        self.data.append(END)

    def trigger(self):
        """Trigger sleep event
        Sends command over serial interface
        """
        # try:
        #     assert len(self.data) == PAYLOAD_LEN
        # except AssertionError as error:
        #     print("Missing Params: (time, pin, state)")
        print([START, BALENA_COMMAND, SLEEP_COMMAND])
        print(self.data)
        self.ser.write(bytearray([START, BALENA_COMMAND, SLEEP_COMMAND]))
        self.ser.write(bytearray(self.data))
        while(True):
            print(self.ser.read())

if __name__ == '__main__':
    s = Sleep()
    if len(sys.argv) > 1:
        time = int(sys.argv[1])
        pin = int(sys.argv[2])
        state = int(sys.argv[3])
        s.set(time, pin, state)
    else:
        s.set(10, POWER, POWER_STATE) # e.g. sleep (initial state HIGH) for 10000 milliseconds
    s.trigger()