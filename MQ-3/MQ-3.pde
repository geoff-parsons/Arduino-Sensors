/*
 * MQ-3 Alcohol Gas Sensor
 *
 * Wiring (using Sparkfun breakout board):
 * 
 *      ()    ()
 *      ()    ()
 */

const int MQ3PIN = 0;

int _baseline = 0;

void setup() {
  Serial.begin(9600);
  pinMode(MQ3PIN, INPUT);
  
  // take 20 air samples when we first turn on the system
  Serial.println("Calibrating...");
  autoCalibrate(20);
}

void loop() {
  int val = getReading();
  Serial.print("VAL = ");
  Serial.println(val);
  delay(1000);
}

void autoCalibrate(int samples) {
  int val, i, firstcal, lastnum;
  firstcal = 1;
  for(i = 0; i < samples; i++) {
    val = analogRead(MQ3PIN);
    if(firstcal) {
      firstcal = 0;
      lastnum = val;
    } else {
      lastnum = (lastnum + val) / 2;
    }
    delay(100);
  }
  _baseline = lastnum + 20;
}

int getReading() {
  int val = analogRead(MQ3PIN);
  val -= _baseline;
  if(val > 0)
    return val;
  return 0;
}

