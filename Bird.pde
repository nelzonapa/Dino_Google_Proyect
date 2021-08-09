//clase de tipo "Bird"
class Bird{
  float w = 60;//variable w de width=ancho
  float h = 50;//variable h de height=alto
  float posX, posY;//posición x,y
  int flapCount = 0; //contador de eleteo
  
  Bird(int t){//variable "t" depende de Obstacle
    posX = width;//"width"=ancho, comenzara desde el extremo
    switch(t){//lugares de aparición con respecto a la altura
      case 0: posY = 10 + h / 4;
              break;
      case 1: posY = 60;
              break;
      case 2: posY = 130;
              break;
    }
  }
  //Mando para mostrar las aves
  void show(){
    flapCount++; //contador de vuelo
    if(flapCount < 0){//si este es menor que 0
      image(bird, posX - bird.width / 2, height - groundHeight - (posY + bird.height - 20));//bird, posición x,posición y
      //en void draw o en este caso void show, se usa "image(img, x, y);"
    }
    else{//si flapcount es mayor que 0
      image(bird1, posX - bird1.width / 2, height - groundHeight - (posY + bird1.height - 20));//bird, posición x,posición y
    }
    if(flapCount > 15){//si este es mayor que 15
      flapCount = -15;//se convierte en -15
    }
  }
  
  //movimiento Bird
  void move(float speed){
    posX -= speed;//representa posX=posX-speed
  }
  //boolean es para dar V o F
  //collided es choque
  //aquí damos el código para los choques que se de en el juego
  boolean collided(float playerX, float playerY, float playerWidth, float playerHeight){
    float playerLeft = playerX - playerWidth / 2;
    float playerRight = playerX + playerWidth / 2;
    float thisLeft = posX - w / 2;
    float thisRight = posX + w / 2;
    
    if(playerLeft < thisRight && playerRight > thisLeft){
      float playerDown = playerY - playerHeight / 2;
      float playerUp = playerY + playerHeight / 2;
      float thisUp = posY + h / 2;
      float thisDown = posY - h / 2;
      if(playerDown <= thisUp && playerUp >= thisDown){
      
        //SONIDO DE IMPACTO
        Muerte.play();
        
        return true;
      }
    }
    return false;
  }
}
