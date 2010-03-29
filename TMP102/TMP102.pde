/*
 * TMP102 Digital Temperature Sensor
 * 
 * Wiring:
 * 
 *              () Ground
 *        ()    () Analog 5
 * Ground ()    () Analog 4
 *              [] +3v
 */


#include <Wire.h>

byte res, byte1, byte2;
int val, sign_bit;
float temp;

void setup() {
  Serial.begin(9600); 
  Wire.begin(); 
} 


void loop() {
  res = Wire.requestFrom(72,2); 
  if (res == 2) {
    byte1 = Wire.receive();
    byte2 = Wire.receive(); 
    Serial.print(byte1,BIN); Serial.print(" "); Serial.println(byte2,BIN);
    
    val = (byte1<<4) + (byte2>>4);
    
    // Check for negative values
    sign_bit = val & 0x800;
    if (sign_bit) {
      val = (val ^ 0xFFF) + 1; // 2's comp
      val *= -1;
    }
    
    temp = val * 0.0625;
    Serial.print(temp); Serial.println(" C");
    
    Serial.print(temp*9/5+32); Serial.println(" F" );
    
    Serial.println("");
    delay(2500); 
  }
}

