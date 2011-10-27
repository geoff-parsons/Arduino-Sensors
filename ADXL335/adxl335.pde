/*
 * ADXL335 3-axis accelerometer.
 *
 * Analog 0 ()
 * Analog 1 ()
 * Analog 2 ()
 *   Ground ()
 *       3v ()
 *
 */

#define XPIN 0
#define YPIN 1
#define ZPIN 2

int x, y, z; 

void setup() {
  Serial.begin(9600);      // sets the serial port to 9600
}

void loop() {
  x = analogRead(XPIN);
  y = analogRead(YPIN);
  z = analogRead(ZPIN);
  
  Serial.print("X: "); Serial.print(x, DEC);
  Serial.print(", Y: "); Serial.print(y, DEC);
  Serial.print(", Z: "); Serial.println(z, DEC);
  
  delay(250);
}
