  #include <Wire.h>
  #include <Adafruit_GFX.h>
  #include <Adafruit_SSD1306.h>

  #define SCREEN_WIDTH 128
  #define SCREEN_HEIGHT 64

  Adafruit_SSD1306 display(SCREEN_WIDTH, SCREEN_HEIGHT, &Wire, -1);

  char SerialVal; 

  int btech = A6; 
  int Rthere = A1; 
  int range; 
  int there; 

  int potBpm = A3; 
  int potFrBpm = A2; 

  int buzzer1 = 3; 
  int buzzer2 = 6; 
  
  int BT1 = 12; 
  int BT2 = 11; 
  int BT3 = 10; 
  int BT4 = 9; 
  int BT5 = 8; 
  int BT6 = 7; 
  int BT7 = 4; 

  int SBT1 = 0; 
  int SBT2 = 0; 
  int SBT3 = 0; 
  int SBT4 = 0; 
  int SBT5 = 0; 
  int SBT6 = 0; 
  int SBT7 = 0; 

  int frBpm; 
  int reading2; 

  int frBT; 
  int reading; 
  int bpm;  
  int x; 

  int metronome = 200; 

  int Do[] = {261, 523, 1046, 2093, 4186};
  int Re[] = { 293, 587, 1174, 2348, 4698};
  int Mi[] = { 329, 659, 1318, 2137, 5274}; 
  int Fa[] = { 349, 698, 1396, 2793, 5587};
  int Sol[] = { 392, 784, 1568, 3136, 6271};
  int La[] = { 440, 880, 1760, 3520, 7040};
  int Si[] = { 493, 987, 1975, 3951, 7902};

  long temps1; 
  long temps2; 

  bool etatbpm = 1;
  bool etatbpm2 = 1;


void setup() {

  if(!display.begin(SSD1306_SWITCHCAPVCC,0x3C)) {
    Serial.println(F("SSD1306 allocation failed"));
  for(;;);  } 

  Serial.begin(9600);

  pinMode(btech, INPUT);

  pinMode(BT1, INPUT); 
  pinMode(BT2, INPUT); 
  pinMode(BT3, INPUT); 
  pinMode(BT4, INPUT); 
  pinMode(BT5, INPUT); 
  pinMode(BT6, INPUT);
  pinMode(BT7, INPUT);  

  pinMode(buzzer1, OUTPUT);
  pinMode(buzzer2, OUTPUT);

  temps1 = millis(); 

  pinMode(LED_BUILTIN, OUTPUT);
  digitalWrite(LED_BUILTIN, LOW);

}

void loop() {

 frBT = analogRead(btech); 
 there = analogRead(Rthere); 

 Serial.print(there); 
 Serial.println("th");
 Serial.print(frBT); 
 Serial.println("bt");

 int min = 400; 
 int max= 580; 

 range = map(there, 200, 400, 0, 4);

 SBT1 = digitalRead(BT1); 
 SBT2 = digitalRead(BT2); 
 SBT3 = digitalRead(BT3); 
 SBT4 = digitalRead(BT4); 
 SBT5 = digitalRead(BT5); 
 SBT6 = digitalRead(BT6); 
 SBT7 = digitalRead(BT7); 


  if (SBT1 == HIGH) {
    Serial.print("1");
    Serial.print(","); 

    tone(buzzer2, Do[range]); 
  }
  else if (SBT2 == HIGH){
    Serial.print("2");
    Serial.print(","); 

    tone(buzzer2, Re[range]);  
  }
  else if (SBT3 == HIGH) {
    Serial.print("3");
    Serial.print(","); 

    tone(buzzer2, Mi[range]); 
  }
  else if (SBT4 == HIGH) {
    Serial.print("4");
    Serial.print(","); 

    tone(buzzer2, Fa[range]); 
  }
  else if (SBT5 == HIGH){
    Serial.print("5");
    Serial.print(","); 

    tone(buzzer2, Sol[range]); 
  }
  else if (SBT6 == HIGH){
    Serial.print("6");
    Serial.print(","); 

    tone(buzzer2, La[range]); 
  }
  else if (SBT7 == HIGH){
    Serial.print("7");
    Serial.print(",");

    tone(buzzer2, Si[range]); 
  }
  else {
    Serial.print("0");
    Serial.print(","); 

    noTone(buzzer2); 
  }

  if (frBT > min && frBT < max) { // bouton 1 

      etatbpm = !etatbpm; 

      if (etatbpm) {
        buzzer1 = 3; 
      }
      else {
        buzzer1 = 100; 
      }

    delay(100); 

  }
  else if (frBT > max) { // bouton 2

      etatbpm2 = !etatbpm2; 

      if (etatbpm2) {
        buzzer2 = 5; 
      }
      else {
        buzzer2 = 100; 
      }

    delay(100); 
  }

    SerialVal = Serial.read(); 
    if(SerialVal == 'a') musique(); 

        temps2 = millis(); 

    if (bpm == 0) {
        noTone(buzzer1); 
    }
    else if ((temps2 - temps1) >= 60000 / bpm ) {
        tone(buzzer1, frBpm); 
        temps1 = millis(); 
        delay(50);
        noTone(buzzer1); 
    }

  Bpm(); 

}

void Bpm(){

    reading = analogRead(potBpm); 
    x = map(reading, 0, 1023, 3, 120); 
    bpm = map(reading, 0, 1023, 0, 200); 

    reading2 = analogRead(potFrBpm); 
    frBpm = map(reading2, 0, 1023, 31, 2000); 

    display.clearDisplay();

    display.drawRoundRect(4,4,124,19,5,WHITE); //je fais la jauge avec un variable pour la longeur 
    display.fillRoundRect(6,6,x,15,5,WHITE);

    display.setTextSize(1); //je definie la taille du texte et la position de celui ci 
    display.setTextColor(WHITE);
        display.setCursor(18,34);

        display.print("BPM ");
        display.setCursor(50,34);
        display.println(bpm);

    display.setCursor(18, 45); 
    display.print("Frequence ");
    display.setCursor(85, 45); 
    display.print(frBpm); 

    display. display();

    Serial.print(bpm); 
    Serial.print(","); 
    Serial.print(frBpm);
    Serial.print(",");
    Serial.print(etatbpm);  
    Serial.print(",");
    Serial.print(etatbpm2);  
    Serial.print(",");
    Serial.print(range);  
    Serial.println(",");
 
}

void musique(){
  digitalWrite(LED_BUILTIN, HIGH);
}  