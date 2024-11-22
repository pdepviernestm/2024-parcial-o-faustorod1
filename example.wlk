class Persona {
  var edad //=0 ??
  const emociones = []

  method es_adolescente() {
    return edad.between(12, 19)
  }

  method nueva(emocion){
    emociones.add(emocion)
  }

  method esta_por_explotar(){
    return emociones.all({emocion => emocion.puede_liberarse()})
  }

  method vivir(evento){

  }

}

class Evento{
  const property impacto
  const descripcion //property?
}

class Emocion{//object??
  var property piso_de_intensidad //fijar arbitrsriamente?
  var property intensidad
  var eventos_experimentados = 0

  method intensidad_elevada(){
    return intensidad > piso_de_intensidad
  }
}

class Furia inherits Emocion(intensidad = 100){
  var palabrotas = [] // es "var" para poder usar "drop". Asumo que pueden repetirse las palabrotas

  method puede_liberarse(){
    return self.intensidad_elevada() && self.conoce_palabrota_mayor_a_7_letras()
  }

  method liberarse(evento){
    if(self.puede_liberarse()){
      intensidad =- evento.impacto()
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
      /*
      if (intensidad < evento.impacto()){
        intensidad =- evento.impacto()
      } else{
        intensidad = evento.impacto() - intensidad
      }
      */
    }
  }

  method eventos_experimentados_pares(){
    return eventos_experimentados % 2 == 0
  }
}

class Tristeza inherits Emocion{
  //su intensidad puede variar sin limitaciones?

}