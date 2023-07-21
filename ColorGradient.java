import processing.core.PApplet;
import java.util.Arrays;

public class ColorGradient { //Generated fully by ChatGPT, im gonna loose my job lol

  private int[] colors;
  private float[] positions;

  public ColorGradient(int[] colors, float[] positions) {
    if (colors.length != positions.length || colors.length < 2) {
      throw new IllegalArgumentException("Invalid colors or positions array");
    }

    this.colors = colors;
    this.positions = positions;
    Arrays.sort(this.positions);
  }

  public int getInterpolatedColor(float position) {
    if (position <= positions[0]) {
      return colors[0];
    }

    if (position >= positions[positions.length - 1]) {
      return colors[colors.length - 1];
    }

    for (int i = 1; i < positions.length; i++) {
      if (position <= positions[i]) {
        float percent = (position - positions[i - 1]) / (positions[i] - positions[i - 1]);
        return lerpColor(colors[i - 1], colors[i], percent);
      }
    }

    // Should not reach here, but return the last color as a fallback
    return colors[colors.length - 1];
  }

  private int lerpColor(int c1, int c2, float amount) {
    int r1 = (c1 >> 16) & 0xFF;
    int g1 = (c1 >> 8) & 0xFF;
    int b1 = c1 & 0xFF;
    int a1 = (c1 >> 24) & 0xFF;

    int r2 = (c2 >> 16) & 0xFF;
    int g2 = (c2 >> 8) & 0xFF;
    int b2 = c2 & 0xFF;
    int a2 = (c2 >> 24) & 0xFF;

    int r = (int) (r1 + (r2 - r1) * amount);
    int g = (int) (g1 + (g2 - g1) * amount);
    int b = (int) (b1 + (b2 - b1) * amount);
    int a = (int) (a1 + (a2 - a1) * amount);

    return (a << 24) | (r << 16) | (g << 8) | b;
  }
}
