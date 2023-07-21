import processing.core.PApplet;
import controlP5.*;

public class NoiseArt extends PApplet {

  Controller controller;
  

  public void settings() {
    size(1000, 500);
  }

  public void setup() {
    controller = new Controller();
    PApplet.runSketch(new String[] { "Controller" }, controller);
    noiseSeed(42);
  }

  public void draw() {
    noise2D();
  }
  
  public void mouseClicked(){
    controller.mapView = !controller.mapView;
  }

  public static void main(String[] args) {
    PApplet.main("NoiseArt");
  }
  
  public void noise2D() {
    loadPixels();
    for (int y = 0; y < height; y++) {
        for (int x = 0; x < width; x++) {
            // get pixel position in pixels array
            int i = x + y * width;

            
            float n = manipulate(domianWarp(x,y,controller.time));
            if(controller.mapView){
              n = toMapView(n);
            }
            
            
            
            int[] gradientColors = {color(3, 65, 89), color(2, 115, 94), color(12, 242, 93)};
            float[] positions = {0.0, 0.5, 1.0};
            ColorGradient colorGradient = new ColorGradient(gradientColors, positions);
            pixels[i] = colorGradient.getInterpolatedColor(n);
        }
    }
    updatePixels();
    controller.time += 0.005;
  }
  
  
  public float fractal(float x, float y, float z){
    float noiseResult = 0;
    
    float xfreq = controller.xfrequency;
    float yfreq = controller.yfrequency;
    float amp = controller.amplitude;
    float rough = controller.roughness;
    float pers = controller.persistence;
    
    for(int i = 0; i<controller.octaves; i++){
        float n = noise((x*xfreq),(y*yfreq),z);
        
        noiseResult += n*amp;
        xfreq *= rough;
        yfreq *= rough;
        amp *= pers;
    }
    
    return noiseResult;
  
  }
  
  private float domianWarp(float x, float y, float z){
    float xhelp = x+5000;
    float yhelp = y+5000;
    float offsetX = noise(xhelp*controller.warpX, yhelp*controller.warpY,25);
    float offsetY = noise(xhelp*controller.warpX, yhelp*controller.warpY,50);
     
    return fractal(x+5000+controller.warpStrength*offsetX, y+5000+controller.warpStrength*offsetY, z);
  }
  
  
    private float toMapView(float x){
    if (x>1)
      x=1;
    if(x<0)
      x=0;


    if(x%0.1<0.05) // < shadows; > lighs
      x = (float) Math.round(x * 10) / 10;
    
    if (x>1)
      x=1;
    if(x<0)
      x=0;
      
    return x;
  }
  
  private float manipulate(float x){
    if (x>1)
      x=1;
    if(x<0)
      x=0;
    //return 1/(1+((float)Math.pow((x/(1-x)),-controller.pv)));
    x = 1/(1+(float)Math.pow((x/(1-x)),-controller.pv));
    
    if (x>1)
      x=1;
    if(x<0)
      x=0;
      
    return x;
  }
  
    
    
}
