/*
Augmentr MIDI Controller
 by David Cihelna & Gabe Weintraub
 ITP Fall 2014 - PComp Midterm
 
 Uses Hairless Serial - MIDI and Massive to manipulate a sounds (like an autoharp) and Processing sketch.
 
 Suggested Massive Patches: Apex Jeff Strings, Hot Wired, Devilfish Cloned
 
 */

//the switches
const int switchPin13 = 13;  // The switch is on Arduino pin 13
const int switchPin12 = 12;  // The switch is on Arduino pin 12
const int switchPin11 = 11;  // The switch is on Arduino pin 11
const int switchPin10 = 10;  // The switch is on Arduino pin 10
const int switchPin9 = 9;  // The switch is on Arduino pin 9
const int switchPin8 = 8;  // The switch is on Arduino pin 8


float finger1 = A0; //FSR thumb 1
float finger2 = A1; //FSR finger 2
float finger3 = A2; //FSR finger 3
float finger4 = A3; //FSR finger 4
float finger5 = A4; //FSR finger 5


void setup() {
  //  set the states of the switches
  pinMode(switchPin13, INPUT);
  pinMode(switchPin12, INPUT);
  pinMode(switchPin11, INPUT);
  pinMode(switchPin10, INPUT);
  pinMode(switchPin9, INPUT);
  pinMode(switchPin8, INPUT);


  //the FSRs
  pinMode(finger1, INPUT);
  pinMode(finger2, INPUT);
  pinMode(finger3, INPUT);
  pinMode(finger4, INPUT);
  pinMode(finger5, INPUT);

  Serial.begin(38400);
  Serial.println("0,0,0");
}


void loop() {
  playing();
  fingers();
}


//pressing and releasing the switches
void playing(){

  if (digitalRead(switchPin13) == HIGH){ //3 Bm
    noteOn(0x90, 0x3B, 100); // commands: note on, note/pitch, velocity
    noteOn(0x90, 0x3E, 100);
    noteOn(0x90, 0x42, 100);

  } 
  else{
    noteOFF(0x80, 0x3B, 0);
    noteOFF(0x80, 0x3E, 0);
    noteOFF(0x80, 0x42, 0);

  }

  if (digitalRead(switchPin12) == HIGH){ //3 D
    noteOn(0x90, 0x3E, 100);
    noteOn(0x90, 0x42, 100);
    noteOn(0x90, 0x45, 100);
  } 
  else{
    noteOFF(0x80, 0x3E, 0);
    noteOFF(0x80, 0x42, 0);
    noteOFF(0x80, 0x45, 0);

  }

  if (digitalRead(switchPin11) == HIGH){ //3 G
    noteOn(0x90, 0x37, 100);
    noteOn(0x90, 0x3B, 100);
    noteOn(0x90, 0x3E, 100);
  } 
  else{
    noteOFF(0x80, 0x37, 0);
    noteOFF(0x80, 0x3B, 0);
    noteOFF(0x80, 0x3E, 0);

  }

  if (digitalRead(switchPin10) == HIGH){ //3 Am
    noteOn(0x90, 0x39, 100);
    noteOn(0x90, 0x3C, 100);
    noteOn(0x90, 0x40, 100);
  } 
  else{
    noteOFF(0x80, 0x39, 0);
    noteOFF(0x80, 0x3C, 0);
    noteOFF(0x80, 0x40, 0);

  }
  if (digitalRead(switchPin9) == HIGH){ //4 Bm
    noteOn(0x90, 0x47, 100);
    noteOn(0x90, 0x4A, 100);
    noteOn(0x90, 0x4E, 100);
  } 
  else{
    noteOFF(0x80, 0x47, 0);
    noteOFF(0x80, 0x4A, 0);
    noteOFF(0x80, 0x4E, 0);

  }
  if (digitalRead(switchPin8) == HIGH){ //4 Fm
    noteOn(0x90, 0x41, 100);
    noteOn(0x90, 0x45, 100);
    noteOn(0x90, 0x48, 100);
  } 
  else{
    noteOFF(0x80, 0x41, 0);
    noteOFF(0x80, 0x45, 0);
    noteOFF(0x80, 0x48, 0);

  }
  delay(100);
}


//this sends the serial data out from the data chosen in playing
void noteOn(byte cmd, byte data1, byte  data2) {
  //  Serial.write(cmd);
  //
  //  Serial.write(data1);
  //
  //  Serial.write(data2);

  if (Serial.available() > 0) {
    Serial.print(String(cmd));
    Serial.print(",");
    Serial.print(String(data1));
    Serial.print(",");
    Serial.print(String(data2));
    Serial.println("");
  }
}

void noteOFF(byte bcmd, byte bdata1, byte  bdata2) {
  //  Serial.write(bcmd);
  //
  //  Serial.write(bdata1);
  //
  //  Serial.write(bdata2);

if (Serial.available() > 0) {
  Serial.print(String(bcmd));
  Serial.print(",");
  Serial.print(String(bdata1));
  Serial.print(",");
  Serial.print(String(bdata2));
  Serial.println("");
}
}


void fingers(){

  // map(analogRead(finger1),0,900,0,127);

  //change channel or change controller number? -- if no work use B1 instead of B0
  conCon(0xB0, 0x01 , analogRead(finger1)); //commands: continuous controller, channel 1, value
  conCon(0xB0, 0x02 , analogRead(finger2)); //commands: continuous controller, channel 1, value
  conCon(0xB0, 0x03 , analogRead(finger3)); //commands: continuous controller, channel 1, value
  conCon(0xB0, 0x04 , analogRead(finger4)); //commands: continuous controller, channel 1, value
  conCon(0xB0, 0x05 , analogRead(finger5)); //commands: continuous controller, channel 1, value

  //Serial.println(analogRead(finger1));

}


//sends the controller data out
void conCon(byte ccmd, byte cdata1, byte  cdata2) {
  //  Serial.write(ccmd);
  //
  //  Serial.write(cdata1);
  //
  //  Serial.write(cdata2);

  // String out = (String(ccmd) + ', ' + String(cdata1) + ', ' + String(cdata2));


  //Serial.println(out);
if (Serial.available() > 0) {
  Serial.print(String(ccmd));
  Serial.print(",");
  Serial.print(String(cdata1));
  Serial.print(",");
  Serial.print(String(cdata2));
  Serial.println("");
}


  delay(10);

}

