#include "balena.h"
#include "power.h"

/******************************************************************************
 * @brief  Main function
 *
 *****************************************************************************/

int main(void)
{
  balenaInit(); // include balena libs

  digitalWrite(12,1);
  digitalWrite(14,1);

  PowerClass P;

  P.Init(1000, 10000, EM0, EM0);
  P.PowerDown();
}