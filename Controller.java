import processing.core.PApplet;
import controlP5.*;

public class Controller extends PApplet {

  ControlP5 cp5;
  float time;
  float xfrequency;
  float yfrequency;
  
  int octaves;
  float warpTime;
  float roughness;
  float persistence;
  
  float warpStrength;
  float warpX;
  float warpY;
  
  float pv;
  
  boolean mapView = false;
  
  float color1Pos;
  float color2Pos;
  float color3Pos;
  
  float xOff;
  float yOff;
  
  boolean fullRange;

  public void settings() {
    size(1200, 1000);
  }

  public void setup() {
    cp5 = new ControlP5(this);
    cp5.addSlider("xfrequency")
       .setPosition(50, 70)
       .setRange(0, 0.1f)
       .setValue(0.005f)
       .setSize(400, 20);
       
     cp5.addSlider("yfrequency")
       .setPosition(50, 170)
       .setRange(0, 0.1f)
       .setValue(0.005f)
       .setSize(400, 20);
       
     cp5.addSlider("time")
       .setPosition(50, 270)
       .setRange(0, 10)
       .setValue(0)
       .setSize(400, 20);
       
     cp5.addSlider("octaves")
       .setPosition(50, 370)
       .setRange(1, 6)
       .setValue(4)
       .setSize(400, 20)
       .setNumberOfTickMarks(5) // The number of tick marks represents integer values
       .showTickMarks(true)
       .setSliderMode(Slider.FLEXIBLE);
       
     cp5.addSlider("warpTime")
       .setPosition(50, 470)
       .setRange(0, 10)
       .setValue(0)
       .setSize(400, 20);
       
     cp5.addSlider("roughness")
       .setPosition(50, 570)
       .setRange(0, 5f)
       .setValue(1)
       .setSize(400, 20);
       
     cp5.addSlider("persistence")
       .setPosition(50, 670)
       .setRange(0, 1.5f)
       .setValue(1)
       .setSize(400, 20);    
       
     cp5.addSlider("warpStrength")
       .setPosition(50, 770)
       .setRange(0, 7000)
       .setValue(1)
       .setSize(800, 20);
       
     cp5.addSlider("warpX")
       .setPosition(650, 70)
       .setRange(0, 0.3f)
       .setValue(0.005f)
       .setSize(400, 20);  
       
     cp5.addSlider("warpY")
       .setPosition(650, 170)
       .setRange(0, 0.3f)
       .setValue(0.005f)
       .setSize(400, 20); 
       
     cp5.addSlider("pv")
       .setPosition(650, 270)
       .setRange(-10f, 10f)
       .setValue(1f)
       .setSize(400, 20);
       
     cp5.addSlider("color1Pos")
       .setPosition(650, 470)
       .setRange(0f, 1f)
       .setValue(0.17f)
       .setSize(400, 20);
       
     cp5.addSlider("color2Pos")
       .setPosition(650, 570)
       .setRange(0f, 1f)
       .setValue(0.3f)
       .setSize(400, 20);
       
     cp5.addSlider("color3Pos")
       .setPosition(650, 670)
       .setRange(0f, 1f)
       .setValue(0.8f)
       .setSize(400, 20);
       
     cp5.addSlider("xOff")
       .setPosition(50, 870)
       .setRange(0f, 30000)
       .setValue(0f)
       .setSize(400, 20);
       
     cp5.addSlider("yOff")
       .setPosition(650, 870)
       .setRange(0f, 30000)
       .setValue(0f)
       .setSize(400, 20);
  }

  public void draw() {
    background(0);
    fill(255);
    textSize(18);
    text("xFreq: " + xfrequency, 50, 50);
    text("yFreq: " + yfrequency, 50, 150);
    text("Time: " + time, 50, 250);
    text("Octaves: " + octaves, 50, 350);
    text("Warp Time: " + warpTime, 50, 450);
    text("Roughness: " + roughness, 50, 550);
    text("Persistnece: " + persistence, 50, 650);
    text("Warp Strength: " + warpStrength, 50, 750);
    text("Warp X: " + warpX, 650, 50);
    text("Warp Y: " + warpY, 650, 150);
    text("PV: " + pv, 650, 250);
    text("Press M to toggle Map-View: " + mapView, 650, 350);
    text("Press F to toggle Full Range: " + fullRange, 650, 400);
    text("Color 1 Position: " + color1Pos, 650, 450);
    text("Color 2 Position: " + color2Pos, 650, 550);
    text("Color 3 Position: " + color3Pos, 650, 650);
    text("x Offset: " + xOff, 50, 850);
    text("Y Offset: " + yOff, 650, 850);
    
    
  }
  
  public void keyPressed() {
    if (key == 'f' || key == 'F') {
      fullRange = !fullRange;
    }
    
    if (key == 'm' || key == 'M') {
        mapView = !mapView;
    }
  }
}
