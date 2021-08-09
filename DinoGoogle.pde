//En esta parte indicamos que almacenará las siguientes imágenes...
//   acompañadas de la función "loadImage(Nombre_de_la_imagen.jpg);"
//   puede mostrar imágenes .gif , .jpg , .tga y .png . 
PImage dinoRun1;
PImage dinoRun2;
PImage dinoJump;
PImage dinoDuck;
PImage dinoDuck1;
PImage smallCactus;
PImage bigCactus;
PImage manySmallCactus;
PImage bird;
PImage bird1;  
//SONIDO, IMPORTAMOS
import processing.sound.*; //BIBLIOTECA sound DESCARGADA
SoundFile Again;
SoundFile Salto;//jump
SoundFile Muerte;
SoundFile Agachado;

// Una "ArrayList" almacena un número variable de objetos. Esto es similar...
//   a crear una matriz de objetos, pero con una ArrayList , los elementos se...
//   pueden agregar y eliminar fácilmente de ArrayList y se cambia de tamaño dinámicamente.
//ESTRUCTURA:
// Declarando ArrayList, observe el uso de la sintaxis "<Obstacle>" para indicar 
// nuestra intención de llenar este ArrayList con objetos Obstacle
//ArrayList <Obstacle> obstaculos = new ArrayList <Obstacle> ();
//      En este caso, se llenará con datos de la carpeta extra "Obstacle", lo mismo con los demás
ArrayList<Obstacle> obstacles = new ArrayList<Obstacle>();
ArrayList<Bird> birds = new ArrayList<Bird>();
ArrayList<Ground> grounds = new ArrayList<Ground>();

//Aquí introducimos el valor de cada dato, de tipo int and float:
int obstacleTimer = 0; //Tiempo del obstaculo
int minTimeBetObs = 60; //Mini tiempo observación
int randomAddition = 0; //Adición aleatoria
int groundCounter = 0; //contador suelo
float speed = 10; //velocidad

int groundHeight = 50; //altura del suelo
int playerXpos = 100; //posición de jugador x
int highScore = 0; // puntuación más alta

Player dino;

void setup(){
  size(800, 400);//Tamaño de la pantalla
  frameRate(60);//Da a conocer la cantidad de fotogramas por segundo
  
 //SONIDOOOO
 Again = new SoundFile(this, "Again.wav");
 Muerte = new SoundFile(this, "Muerte.wav");
 Agachado = new SoundFile(this, "Agachado.wav");
 Salto = new SoundFile(this, "Salto.wav");
  
//Aquí es donde ejecuta las imágenes que tenemos disponibles en el sketch
//   función "loadImage(Nombre_de_la_imagen.jpg);"
  dinoRun1 = loadImage("dinorun0000.png");
  dinoRun2 = loadImage("dinorun0001.png");
  dinoJump = loadImage("dinoJump0000.png");
  dinoDuck = loadImage("dinoduck0000.png");
  dinoDuck1 = loadImage("dinoduck0001.png");
  smallCactus = loadImage("cactusSmall0000.png");
  bigCactus = loadImage("cactusBig0000.png");
  manySmallCactus = loadImage("cactusSmallMany0000.png");
  bird = loadImage("berd.png");
  bird1 = loadImage("berd2.png");

//Se crea un nuevo dino de Player()___Es decir se obtiene un nuevo dato de los mandos del doc "Player"
//new es un comando de obtner algo "nuevo"
  dino = new Player();
}

void draw(){
  background(250);//color de fondo
  stroke(0);//color del gráfico
  strokeWeight(2);//grosor de la imagen:
  line(0, height - groundHeight - 30, width, height - groundHeight - 30);//gráfico de linea
  
  //actualiza la parte del mando en "Obstacles()"
  updateObstacles();
  
  //Si el puntaje de dino es mayor que highScore=puntuación más alta o la última puntuación
  if(dino.score > highScore){
    highScore = dino.score;//la puntuación alta se reemplaza por el nuevo puntaje de dino
  }
  
  //textSize, define lo que es el tamaño de las letras, tamaño de fuente
  //  este se aplicara a todos los text que aparezcan más adelante
  textSize(20);
  fill(0);
  text("Score: " + dino.score, 5, 20); //escribe "Score_dato" ,coordenada x,coordenada y
  text("High Score: " + highScore, width - (140 + (str(highScore).length() * 10)), 20);//escribe "High score_dato" x,y);
  //"width"=ancho
  //El mando de str=>str(3) devolverá el valor de String de "3", en este caso el puntaje más alto
  //   Pasa de: booleano , byte , char , int o float, en su representación de cadena.
  // length()=>Devuelve el número total de caracteres incluidos en la cadena como un número entero.
  //   Necesita del dato str: "str.length()"
}

//Función a llamar cada vez que una tecla es presionada
//  esta tecla se almacena en "key", que es llave en inglés
void keyPressed(){
  //"switch" Funciona como una estructura if else , pero es
  // más conveniente cuando necesita seleccionar entre 
  //tres o más alternativas.Todo se ira ejecutando hasta que se interrumpa con "break"
  switch(key){
    case ' ': if(!dino.dead){
      //si dino no esta muerto
      dino.jump();//si se presiona ' '(espacio), dino salta
              
      //SONIDO
      Salto.play();
              
    }
    break;//ya no se ejecuta lo de abajo
    case 's': if(!dino.dead){
      //si dino no esta muerto
      dino.ducking(true);//dino se agacha
      
      //SONIDO
      Agachado.play();
      
    }
    break;
    case 'S': if(!dino.dead){
      //si dino no esta muerto
      dino.ducking(true);//dino se agacha
      Agachado.play();
    }
  }
}
 //La función keyReleased () se llama una vez, cada vez que se suelta una tecla. 
void keyReleased(){
  switch(key){
    //en el caso de liberar la tecla 's'
    case 's': if(!dino.dead){//si dino no esta muerto
                dino.ducking(false); //dino no se agacha
              }
              break;
    //en el caso de liberar la tecla 'S'(mayúscula)
    case 'S': if(!dino.dead){//si dino no esta muerto
                dino.ducking(false); //dino no se agacha
              }
              break;
    //en el caso de liberar la tecla 'r'
    case 'r': if(dino.dead){ //si dino esta muerto
                reset();//se reinicia todo
                Again.play();
              }
              break;
    //en el caso de liberar la tecla 'r'
    case 'R': if(dino.dead){ //si dino esta muerto
                reset();//se reinicia todo
                Again.play();
              }
              break;
  }
}
//Dibujaremos las actualizaciones de la parte del mando en "Obstacles()"
void updateObstacles(){
  showObstacles(); //muestra el mando Obstacles()
  dino.show(); //muestra dino
  if(!dino.dead){ //si dino no esta muerto
    obstacleTimer++; //Tiempo de obstaculo, avanza de uno en uno
    speed += 0.002; //velocidad
    //si el ObstacleTime es mayor que el definido anteriormente, se añade otro obstaculo
    if(obstacleTimer > minTimeBetObs + randomAddition){
      addObstacle();
    }
    
    //contador ground aumenta de 1 en 1
    groundCounter++;
    if(groundCounter > 10){//si contador ground es mayor que 10
      groundCounter = 0;//su valor cambia a 0
      grounds.add(new Ground());// y se agrega nuevo comando Ground()
    }
    moveObstacles();
    dino.update();
  }
  
  else{// de lo contrario
    textSize(32);
    fill(0);
    //se muestra todo este texto
    text("JUEGO TERMINADO, ESTAS MUERTO", 130, 200);//escribe "Me mataste shifu!" ,x,y
    textSize(15);
    text("(Press 'r' to restart!)", 330, 230);//escribe "(Press 'r' to restart!)" ,x,y
  }
}

//Dibujaremos obstaculos show=mostrar
void showObstacles(){
  for(int i = 0; i < grounds.size(); i++){ //i comienza desde 0, y contara de 1 a 1, hasta "i < grounds.size()"
    grounds.get(i).show();//comienza a obtener y mostrar el comando de grounds
  }
  for(int i = 0; i < obstacles.size(); i++){//i comienza desde 0, y contara de 1 a 1, hasta "i < grounds.size()"
    obstacles.get(i).show();//comienza a obtener y mostrar el comando de grobstacles
  }
  for(int i = 0; i < birds.size(); i++){//i comienza desde 0, y contara de 1 a 1, hasta "i < grounds.size()"
    birds.get(i).show();//comienza a obtener y mostrar el comando de birds
  }
}

//Dibujaremos, agregamos obstaculos
void addObstacle(){
  if(random(1) < 0.15){
    birds.add(new Bird(floor(random(3))));//random(x,y) devuelve un valor inesperado dentro del rango especificado
    //random es aleatorio:
    //  aleatorio( high), aleatorio( low,  high) 
  }
  else{
    obstacles.add(new Obstacle(floor(random(3))));
  }
  randomAddition = floor(random(50));
  obstacleTimer = 0;
}

//Aquí haremos el movimiento
void moveObstacles(){
  for(int i = 0; i < grounds.size(); i++){//i comienza desde 0, y contara de 1 a 1, hasta "i < grounds.size()"
    grounds.get(i).move(speed);//
    if(grounds.get(i).posX < -playerXpos){
      grounds.remove(i);
      i--;
    }
  }
  
  //moveremos obstaculos
  for(int i = 0; i < obstacles.size(); i++){
    obstacles.get(i).move(speed);
    if(obstacles.get(i).posX < -playerXpos){
      obstacles.remove(i);
      i--;
    }
  }
  
  //moveremos birds
  for(int i = 0; i < birds.size(); i++){
    birds.get(i).move(speed);
    if(birds.get(i).posX < -playerXpos){
      birds.remove(i);
      i--;
    }
  }
}

//aquí ponemos la parte de R, reset
void reset(){
  dino = new Player();//se carga un nuevo jugador
  obstacles = new ArrayList<Obstacle>();//se carga nuevos obstáculos
  birds = new ArrayList<Bird>();//se carga nuevas aves
  grounds = new ArrayList<Ground>();//se carga new grounds
  
  obstacleTimer = 0; //Se pone desde 0 el contador de obstáculos
  randomAddition = floor(random(50));//valor incial del randomAddition
  groundCounter = 0;//valor incial del GroundCounter
  speed = 10;//valor incial de la velocidad
}
