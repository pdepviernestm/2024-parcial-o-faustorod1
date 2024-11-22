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

class Grupo{
  const property personas = []

  method agregar(persona){
    personas.add(persona)
  }

  method vivir(evento){
    personas.forEach({persona => persona.vivir(evento)})
  }
}