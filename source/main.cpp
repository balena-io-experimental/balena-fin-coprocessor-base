#include "balena.h"
#include "Serial.h"
// #include "rtcdriver.h"
#define BUFFER 7
#define SLEEP 0x61
#define END   0xFF
#define ACK   0x00

SerialClass Serial;

uint8_t data[BUFFER] = {0};
uint32_t data_len = BUFFER;

struct command {
   uint32_t  period;
   uint8_t  pin;
   uint8_t  state;
} Sleep; 

/******************************************************************************
 * @brief  Wake event function
 *
 *****************************************************************************/

void wakeEvent( RTCDRV_TimerID_t id, void * user )
{
  digitalWrite(Sleep.pin, !Sleep.state);
}

/******************************************************************************
 * @brief  Serial parsing function
 *
 *****************************************************************************/

void processSerial(){
  Serial.readBytes(data, data_len);
  Serial.write(data, data_len);

  Sleep.period = data[3] << 24 | data[2] << 16 | data[1] << 8 | data[0];
  Sleep.pin = data[4];
  Sleep.state = data[5];

  if(data[6] == END){
    digitalWrite(Sleep.pin, Sleep.state);
    triggerEvent(rtcdrvTimerTypeOneshot, Sleep.period, wakeEvent, NULL);
  } else {
    delay(100);
  }
}

/******************************************************************************
 * @brief  Main function
 *
 *****************************************************************************/
int main(void)
{
	balenaInit();
	Serial.begin(57600);
 
	while(1){
    if(Serial.available() > 0){
      if(Serial.read() == SLEEP){
        Serial.write(ACK);
        processSerial();
      }
    }
	}
}



