class Particle {
  
  PVector pos;
  float r = PI/2;
  float h = 255;
  
  //the particle constructor
  Particle(float radius, float angle) {
    pos = PVector.fromAngle(angle);
    pos.mult(radius);
    r = 3;
  }
  
  void update(){
    pos.x -= 1;
    pos.y += random (-9,9);
    
    //this slices the canvas into 6 sections, whereby no pvector can travel beyond that slice
    float angle = pos.heading();
    //constrains the angle to a specific slice
    angle = constrain(angle, 0, PI/6);
    float magnitude = pos.mag();
    pos = PVector.fromAngle(angle);
    
    //if you add subtraction here, you get really interesting shapes in a parameter less than the pos.y specified above
    pos.setMag(magnitude);
    h = h-0.6;
    //r += PI;
    
    //angle += 0.3;
  }
  
  void show () {
    noStroke();
    strokeWeight(0);
    fill(0, 0, h);  
    
    //the glitter command
    //rotate(PI/2);
    
    //posx, posy, diameter, diameter
    ellipse(pos.x, pos.y, r*2, r*3);
    fill(255);
    ellipse(pos.x, pos.y, r, r);
}

  //check to see if they intersect; assume they do not
  //to tell if they do, check the distance between snowflake x and snowflake y and x, y
  //if the result is less than diameter, keep going, if not, break 
  //this is inherently true because if you put two equal circles next to one another, their combined radii will be equal to the diameter of one circle
  boolean intersect(ArrayList <Particle> snowflake){
    boolean result = false;
    for (Particle s : snowflake){
      float d = dist(s.pos.x, s.pos.y, pos.x, pos.y);
      if (d < r*2){
        result = true;
        break;
      }
    }
    return result;
}

  //this function will return a true or false(is it done or not)
  boolean finished(){
    //the reason it's less than one and not 0 is because the vector angle will never get below 0
    //CONSOLE.LOG people!!!
    return(pos.x<1);
  }

}
