//clase de tipo "Ground"
class Ground{
  float posX = width;//"width"=ancho, comenzara desde el extremo
  float posY = height - floor(random(groundHeight - 20, groundHeight + 30));
  int w = floor(random(1, 10));//variable w de width=ancho, random(x,y) devuelve un valor inesperado dentro del rango especificado
  
  Ground(){
  }
  
  void show(){
    stroke(0);
    strokeWeight(3);
    line(posX, posY, posX + w, posY);//grafico de linea
  }
  
  //movimiento Ground
  void move(float speed){
    posX -= speed;//representa posX=posX-speed
  }
}
