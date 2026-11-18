const int SENSOR_PIN = A0;
const int FAN_PIN = 9;
const float T_ON = 30.0, T_OFF = 27.0;   /* degrees C */
int fan_on = 0;

void setup() {
    pinMode(FAN_PIN, OUTPUT);
    Serial.begin(9600);
}

void loop() {                             /* called again and again, forever */
    int raw = analogRead(SENSOR_PIN);     /* 0 ... 1023 */
    float volts = raw * 5.0 / 1023.0;
    float T = (volts - 0.5) * 100.0;      /* TMP36 sensor: 10 mV per degree */
    if (!fan_on && T > T_ON)  fan_on = 1;
    if (fan_on && T < T_OFF)  fan_on = 0;
    digitalWrite(FAN_PIN, fan_on ? HIGH : LOW);
    Serial.println(T);
    delay(500);                           /* wait 0.5 s */
}
