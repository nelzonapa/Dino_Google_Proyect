//Player, jugador
class Player{
  float posY = 0;
  float velY = 0;
  float gravity = 1.2;//gravedad
  int size = 20;
  boolean duck = false;//agacharse
  boolean dead = false;
  
  int runCount = -5; 
  int lifespan;
  int score;
  
  Player(){
  }
  
  //movimiento Salto
  void jump(){
    if(posY == 0){
      gravity = 1.2;
      velY = 16;//velocidad
    }
  }
  
  //mostramos imagenes
  void show(){
    if(duck && posY == 0){//si dino esta agachado y posición en "y" son 0
      if(runCount < 0){//si conteo de corrida es menor de 0
        image(dinoDuck, playerXpos - dinoDuck.width / 2, height - groundHeight - (posY + dinoDuck.height));//dino imagen agachado ,posición x,posición y
      }
      else{//si no
        image(dinoDuck1, playerXpos - dinoDuck1.width / 2, height - groundHeight - (posY + dinoDuck1.height));
      }
    }
    else{
      if(posY == 0){//si dino tiene posición 0 en "y"
        if(runCount < 0){//si conteo de corrida es menor de 0
          image(dinoRun1, playerXpos - dinoRun1.width / 2, height - groundHeight - (posY + dinoRun1.height));
        }
        else{//si conteo de corrida NO es menor de 0
          image(dinoRun2, playerXpos - dinoRun2.width / 2, height - groundHeight - (posY + dinoRun2.height));
        }
      }
      else{//si dino NO tiene posición 0 en "y"
        image(dinoJump, playerXpos - dinoJump.width / 2, height - groundHeight - (posY + dinoJump.height));
      }
    }
    
    if(!dead){//si no esta muerto
      runCount++;//conteo de 1 en 1
    }
    if(runCount > 5){
      runCount = -5;
    }
  }
  
  //mostramos movimiento
  void move(){
    posY += velY;//representa posy=posy+gravity
    if(posY > 0){
      velY -= gravity;//representa vely=vely-gravity
    }
    else{
      velY = 0;
      posY = 0;
    }
    
    //Para cuando impacte con los cactus
    for(int i = 0; i < obstacles.size(); i++){
      if(dead){
        if(obstacles.get(i).collided(playerXpos, posY + dinoDuck.height / 2, dinoDuck.width * 0.5, dinoDuck.height)){//impacta
          dead = true;
        }
      }
      else{
        if(obstacles.get(i).collided(playerXpos, posY + dinoRun1.height / 2, dinoRun1.width * 0.5, dinoRun1.height)){
          dead = true;
        }
      }
    }
    //Para cuando impacte con las aves
    for(int i = 0; i < birds.size(); i++){
      if(duck && posY == 0){
        if(birds.get(i).collided(playerXpos, posY + dinoDuck.height / 2, dinoDuck.width * 0.5, dinoDuck.height)){
          dead = true;
        }
      }
      else{
        if(birds.get(i).collided(playerXpos, posY + dinoRun1.height / 2, dinoRun1.width * 0.5, dinoRun1.height)){
          dead = true;
        }
      }
    }
  }
  
  //reglas con gravedad
  void ducking(boolean isDucking){
    if(posY != 0 && isDucking){
      gravity = 3;
    }
    duck = isDucking;
  }
  
  //actualiza incrementCounter() y move()
  void update(){
    incrementCounter();
    move();
  }
  
  void incrementCounter(){
    lifespan++;
    if(lifespan % 3 == 0){
      score += 1;//representa score=score+1
    }
  }
}
