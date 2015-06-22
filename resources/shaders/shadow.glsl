  extern number lightX;
  extern number lightY;
  extern number lightRadius;
    
  extern number screenH;
  vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords ){
    screen_coords.y = screenH - screen_coords.y;
    vec2 light= vec2(lightX, lightY);
    number lum = float(1) - distance(screen_coords, light)/lightRadius;
    vec4 pixel = vec4(color.r, color.g, color.b, lum);
    return pixel;
  }