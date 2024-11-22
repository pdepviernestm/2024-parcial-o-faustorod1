class Persona {
  var edad
  const property emociones = []

  method cumplir_anios(){
    edad += 1
  }

  method es_adolescente() {
    return edad.between(12, 19)
  }

  method nueva(emocion){
    emociones.add(emocion)
  }

  method esta_por_explotar(){
    return emociones.all({emocion => emocion.puede_liberarse()})
  }

  method modificar_piso_de_intensidad_de_emociones(nuevo_piso){
    emociones.forEach({emocion => emocion.piso_de_intensidad(nuevo_piso)})
  }

  method vivir(evento){
    emociones.forEach({
      emocion => 
      emocion.liberarse(evento)
      emocion.incrementar_eventos_experimentados()
    })
  }

}

class Evento{
  var property impacto
  const property descripcion

  method impacto(){
    //El impacto de un evento se expresa con un número positivo
    //el getter funciona tambien como setter para corregir el impacto si era negativo 
    impacto = impacto.abs()
    return impacto
  }
}

class Emocion{
  var property piso_de_intensidad = 50 //fijado arbitrsriamente
  var property intensidad
  var property eventos_experimentados = 0

  method intensidad_elevada(){
    return intensidad > piso_de_intensidad
  }

  method incrementar_eventos_experimentados(){
    eventos_experimentados += 1
  }
}

class Furia inherits Emocion(intensidad = 100){
  var palabrotas = [] // es "var" para poder usar "drop". Asumo que pueden repetirse las palabrotas

  method puede_liberarse(){
    return self.intensidad_elevada() && self.conoce_palabrota_mayor_a_7_letras()
  }

  method liberarse(evento){
    if(self.puede_liberarse()){
      intensidad -= evento.impacto()
      palabrotas = palabrotas.drop(1) //olvida la 1er palabrota aprendida (esta al inicio)
    }
  }
  
  method conoce_palabrota_mayor_a_7_letras(){
    return palabrotas.any({palabrota => palabrota.size() > 7})
  }

  method aprender(palabrota){
    palabrotas.add(palabrota)
  }

  method olvidar(palabrota){
    palabrotas.remove(palabrota)
  }

}

class Alegria inherits Emocion{//la instensidad inicial depende de cada caso
  
  method puede_liberarse(){
    return self.intensidad_elevada() && self.eventos_experimentados_pares()
  }
  
  method liberarse(evento){
    if(self.puede_liberarse()){
      //disminuir intensidad manteniendola positiva
      intensidad = (intensidad - evento.impacto()).abs()
    }
  }

  method eventos_experimentados_pares(){
    return eventos_experimentados % 2 == 0
  }
}

class Tristeza inherits Emocion{
  //su intensidad puede variar sin limitaciones?
  
  var causa

  method puede_liberarse(){
    return self.intensidad_elevada() && !self.causa_es_melancolia()
  }

  method liberarse(evento){
    if(self.puede_liberarse()){
      causa = evento.descripcion()
      intensidad -= evento.impacto()
    }
  }

  method causa_es_melancolia(){
    return causa == "melancolia"
  }

}

class Desagrado_o_temor inherits Emocion{

  method liberarse(evento){ //ver de imlementar un super en todas las sub clases de emociones
    if(self.puede_liberarse()){
      intensidad -= evento.impacto()
    }
  }

  method puede_liberarse(){
    return self.intensidad_elevada() && eventos_experimentados > intensidad
  }
}

class Grupo{
  const property personas = []

  method agregar(persona){
    personas.add(persona)
  }

  method vivir(evento){
    personas.forEach({persona => persona.vivir(evento)})
  }


}
///////////////  Intensamente2  ///////////////

class Ansiedad inherits Emocion{
  var contador_de_consultas = 0

  method liberarse(evento){
    if(self.puede_liberarse()){
      intensidad -= evento.impacto()
      contador_de_consultas = 0
    }
  }

  method puede_liberarse(){
    return self.intensidad_elevada() && self.consultas_sobre_intensidad() > 5
    //la idea es que si la persona no se pregunta si esta ansiosa, no lo estara. Pero si empieza a preguntarse si esta ansiosa, se vuelve ansiosa
  }

  method consultas_sobre_intensidad(){
    contador_de_consultas += 1
    return contador_de_consultas
  }
  /*
  EXPLICACION

    Polimorfimo:
      - Se utilizo en el metodo "liberarse(evento)" para que cada emocion se libere de una forma distinta pero todas las emociones puedas recibir el mismo mensaje.
      - Todas las emociones tienen ese metodo y reciben el mismo parametro aunque su implementacion difiera.
    
    Herencia:
      - La clase Ansiedad (Sub Clase) hereda de la clase Emocion (Clase Padre) para utilizar mismos metodos, variables y constantes.
      - Fue util para reutuilizar codigo entre las emociones y no repetir dicho codigo.
  
  */
}


//separar el exaple.wlk en distintos archivos!!