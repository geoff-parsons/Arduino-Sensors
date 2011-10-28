/*
 * HIH-4030 with temperature input from a TMP102 both using Sparkfun's breakout boards.
 * 
 * TMP102 Wiring:
 * 
 *              () Ground
 *        ()    () Analog 5
 * Ground ()    () Analog 4
 *              [] +3v
 *
 * HIH-4030 Wiring:
 * 
 *   Ground ()
 * Analog 3 ()
 *      +5v ()
 */

#define HIH4030PIN 3

#include <Wire.h>

byte res, byte1, byte2;
int val, sign_bit;
float temp;

int sensorValue;         // value coming from the sensor
float supplyVolt = 5.0;  // supply voltage for the HIH-4030
float voltage;           // sensor voltage
float sensorRH;          // sensor RH (at 25 degrees C)
float trueRH;            // RH % accounting for temperature

void setup() {
  Serial.begin(9600);
  pinMode(HIH4030PIN, INPUT);  // declare the analog pin as an input
  Wire.begin();
} 


void loop() {
  res = Wire.requestFrom(72,2); 
  if (res == 2) {
    byte1 = Wire.receive();
    byte2 = Wire.receive(); 
    
    val = (byte1<<4) + (byte2>>4);
    
    // Check for negative values
    sign_bit = val & 0x800;
    if (sign_bit) {
      val = (val ^ 0xFFF) + 1; // 2's comp
      val *= -1;
    }
    
    temp = val * 0.0625;
    Serial.print("Temperature: "); Serial.print(temp); Serial.print(" C ("); Serial.print(temp*9.0/5.0+32); Serial.println(" F)");
    
    
    sensorValue = analogRead(HIH4030PIN);
    voltage = sensorValue/1023.0 * supplyVolt;
    sensorRH = 161.0*voltage/supplyVolt - 25.8;
    trueRH = sensorRH / (1.0546 - 0.0026*temp);
    
    Serial.print("Humditiy: "); Serial.print(trueRH); Serial.println("%");
    
    Serial.println("");
    delay(2500); 
  }
}

