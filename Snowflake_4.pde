//https://www.youtube.com/redirect?q=https%3A%2F%2Fcodegolf.stackexchange.com%2Fquestions%2F42506%2Fdraw-a-snowflake&event=video_description&v=XUA8UREROYE&redir_token=QUFFLUhqbkdCWHEtWnVMSDNTeGMzTTZtNUt4SGJUa2tXd3xBQ3Jtc0ttMEVibFdTOXkzbzhNWUNySlZIZnVzbGFidXlKVzFNNXlacHVxMEhjcnhuX0x0V3Vfb25hWUhESGROdVNMQVJtVkw2SDlPOWVpbmQyUzB5djYxVk9hd052bVA2SkxqaTA4WUphUTYyYnNEdlJobmJGRQ%3D%3D

//diffusion limited aggregation: https://www.youtube.com/watch?v=Cl_Gjj80gPE
//This works by generating a random walk from some random point on the x axis and making it stop at a certain point
//you then draw another line and make it do the same thing


//https://www.youtube.com/watch?v=XUA8UREROYE&list=PL66OTUY5p60A-C4rp00EKT5wcYn4UtCvm&index=9&t=2s
//you get the symmetrical snowflake pattern by creating this pattern on a slice of a hexagon, then mirroring it, and then copying and rotating its mirrored form

Particle current;

float r;
float s = 0.07;
float a1;

//array list full of particles
ArrayList<Particle> snowflake;

void setup(){
  ellipseMode(CENTER);
  //colorMode(HSB);
  size(800, 800);
  //fullScreen();
  
  //DEFINITIONS
  
  //where the particle stops
  //also start at random height
  current = new Particle(width/2, random(10));
  
  //defines the array list full of particles
  snowflake = new ArrayList <Particle>();
}


void draw(){
  translate (width/2, height/2);
  
  //ZOOM IN
  scale(s);
  s= s+0.002;
  //println(s);
  
  if (s > 0.89){
    s = 0.89;
  }

  
  //CALLING INSTANCES OF PARTICLE and ROTATIO
  
  background(0);
  rotate(a1);
  current.update();
  current.show();
  
  a1 = a1+0.03;

  //println(a1);
  
  
  //MOTION
  
  //stops in the center
  //this makes sure that it stops when you intersect the cirrent particle(snowflake
  //while current is not finished and it's not intersecting
  while (!current.finished() && !current.intersect(snowflake)) {
    current.update();
  }
    snowflake.add(current);
    //if you change the second number, it draws new dots
    current = new Particle(width/2, 0);
  
  for (int i = 0; i < 6; i++){
    //this messes with the amount of the circle which is filled out
    rotate(PI/3);
    current.show();
    for (Particle p: snowflake){
      p.show();
  }
  
  //REFLECTION 
  
  pushMatrix();
  
  //making thie (1, -3) gives you a blur effect
  scale(1, -1);
  current.show();
  //for every particle, show them all
  //for every particle wandering, make a new particle
  for (Particle p : snowflake) {
    p.show();
  }
  
  popMatrix();
}

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

}
