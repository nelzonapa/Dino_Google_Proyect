class Obstacle{
  float posX;
  int w, h;
  int type;
  
  Obstacle(int t){
    posX = width;//"width"=ancho, comenzara desde el extremo
    type = t;
    switch(type){//lugares de aparición con respecto a la altura
      case 0: w = 20;
              h = 40;
              break;
      case 1: w = 30;
              h = 60;
              break;
      case 2: w = 60;
              h = 40;
              break;
    }
  }
  //Mando para mostrar los cactus
  void show(){
    switch(type){
      case 0: image(smallCactus, posX - smallCactus.width / 2, height - groundHeight - smallCactus.height);//cactus, posición x,posición y
              break;
      case 1: image(bigCactus, posX - bigCactus.width / 2, height - groundHeight - bigCactus.height);//cactus, posición x,posición y
              break;
      case 2: image(manySmallCactus, posX - manySmallCactus.width / 2, height - groundHeight - manySmallCactus.height);//cactus, posición x,posición y
              break;
    }
  }
  
  //movimiento Ground
  void move(float speed){
    posX -= speed;//representa posX=posX-speed
  }
  
  //aquí damos el código para los choques que se de en el juego en el caso de los obstaculos
  boolean collided(float playerX, float playerY, float playerWidth, float playerHeight){
    float playerLeft = playerX - playerWidth / 2;
    float playerRight = playerX + playerWidth / 2;
    float thisLeft = posX - w / 2;
    float thisRight = posX + w / 2;
    
    if(playerLeft < thisRight && playerRight > thisLeft){
      float playerDown = playerY - playerHeight / 2;
      float thisUp = h;
      if(playerDown < thisUp){
        
        //SONIDO DE IMPACTO
        Muerte.play();
        
        return true;
      }
    }
    return false;
  }
}
