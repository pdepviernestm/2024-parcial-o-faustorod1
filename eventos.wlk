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