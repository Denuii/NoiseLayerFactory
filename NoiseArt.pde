import processing.core.PApplet;
import controlP5.*;

public class NoiseArt extends PApplet {
    
    Controller controller;
    
    float maxHeight;
    float minHeight;
    

    
  ColorGradient colorGradient;
    
    public void settings() {
        size(800, 400);
        noiseSeed(42);
    }
    
    public void setup() {
        controller = new Controller();
        PApplet.runSketch(new String[] { "Controller" } , controller);
        
    }
    
    public void draw() {
        int[] gradientColors = {color(1, 14, 42), color(7, 84, 69), color(6, 143, 101), color(3, 153, 210), color(0, 241, 255)};
        float[] positions = {0.0f, controller.color1Pos, controller.color2Pos, controller.color3Pos, 1.0f};
        colorGradient = new ColorGradient(gradientColors, positions);
        noise2D();
    }
    
    public void mouseClicked() {
        controller.mapView = !controller.mapView;
    }
    
    public void keyPressed() {
        if (keyCode == ENTER || keyCode == RETURN) {
            saveFrame("C:\\Users\\denni\\Documents\\AACode\\git\\NoiseLayerFactory\\output-####.png");
            System.out.println("Saved!");
        }
    }
    
    public static void main(String[] args) {
        PApplet.main("NoiseArt");
    }
    
    public void noise2D() {
        loadPixels();
      
        
        maxHeight = Float.MIN_VALUE;
        minHeight = Float.MAX_VALUE;
        
        float[][] noiseValues = new float[width][height];
        for (int y = 0; y < height; y++) {
            for (int x = 0; x < width; x++) {
                float n = domianWarp(x,y,controller.time);
                noiseValues[x][y] = n;
            }
        }
        
        
        for (int y = 0; y < height; y++) {
            for (int x = 0; x < width; x++) {
                noiseValues[x][y] = mapTo0And1(noiseValues[x][y], minHeight, maxHeight);
            }
        }
        
        if (controller.mapView) {
            for (int y = 0; y < height; y++) {
                for (int x = 0; x < width; x++) {      
                    noiseValues[x][y] = toMapView(noiseValues[x][y]);
                }
            }
        }
        
        
        
        for (int y = 0; y < height; y++) {
            for (int x = 0; x < width; x++) {
                int i = x + y * width;

                //pixels[i] = colorGradient.getInterpolatedColor(manipulate(noiseValues[x][y]));
                pixels[i] = lerpColor(color(0),color(255),manipulate(noiseValues[x][y]));
            }
        }
        
        
        
        
        updatePixels();
        //controller.time += 0.005;
    }
    
    
    public float fractal(float x, float y, float z) {
        float noiseResult = 0;
        
        
        float xfreq = controller.xfrequency;
        float yfreq = controller.yfrequency;
        float amp = 1;
        float rough = controller.roughness;
        float pers = controller.persistence;
        
        
        for (int i = 0; i < controller.octaves; i++) {
            float n = noise((x * xfreq),(y * yfreq),z)*2-1;
            n*=amp;
            noiseResult += n;
            
            
            xfreq *= rough;
            yfreq *= rough;
            amp *= pers;
            
        }
        
        if (noiseResult < minHeight)
            minHeight = noiseResult;
        if (noiseResult > maxHeight)
            maxHeight = noiseResult;
        
        return noiseResult;
        
    }
    
    private float domianWarp(float x, float y, float z) {
        float xhelp = x + 5000;
        float yhelp = y + 5000;
        float offsetX = noise(xhelp * controller.warpX, yhelp * controller.warpY,controller.warpTime);
        float offsetY = noise(xhelp * controller.warpX, yhelp * controller.warpY,controller.warpTime);
        
        return fractal(x + 500 + controller.xOff + controller.warpStrength * offsetX, y + 500 + controller.yOff + controller.warpStrength * offsetY, z);
    }
    
    
    private float toMapView(float x) {
        if (x > 1)
            x = 1;
        if (x < 0)
            x = 0;
        
        
        if (x % 0.1 < 0.05) // < shadows; > lighs
            x = (float) Math.round(x * 10) / 10;
        
        if (x > 1)
            x = 1;
        if (x < 0)
            x = 0;
        
        return x;
    }
    
    private float manipulate(float x) {
        if (x > 1)
            x = 1;
        if (x < 0)
            x = 0;
        //return 1/(1+((float)Math.pow((x/(1-x)),-controller.pv)));
        x = 1 / (1 + (float)Math.pow((x / (1 - x)), - controller.pv));
        
        if (x > 1)
            x = 1;
        if (x < 0)
            x = 0;
        
        return x;
    }
    
    private float mapTo0And1(float x, float start, float end) {
        return map(x,start,end,0,1);
    }
    
    
    
}
