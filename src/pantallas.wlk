import wollok.game.*
import personaje.*
import basura.*
import atmosfera.*
import arbol.*

object pantallaInicio {
  var property position = game.at(0, 0)
  method image() = "comienzo.png"
 

  method mostrar() {
    game.addVisual(self)
  }
  
  method ocultar() {
    if (game.hasVisual(self)) {
      game.removeVisual(self)
    }
  }
}

object pantallaFinal {
  var property position = game.at(0, 0)
  var property esVictoria = false 
  
  method image() = if (esVictoria) "victory.png" else "perdiste.png"
  
  method mostrarDerrota() {
    esVictoria = false
    controladorJuego.terminarJuego()
    musicaJuego.detener()
    self.ocultarTodo() 
    game.addVisual(self) 
  }
  
  method mostrarVictoria() {
    esVictoria = true
    atmosfera.detenerContador()
    controladorJuego.terminarJuego()
    musicaJuego.detener()
    self.ocultarTodo()  
    game.addVisual(self)
  }
  
  method ocultarTodo() {
    if (game.hasVisual(personaje)) game.removeVisual(personaje)
    if (game.hasVisual(superiorBarraHUD)) game.removeVisual(superiorBarraHUD)
    if (game.hasVisual(barraAtmosfera)) game.removeVisual(barraAtmosfera)
    if (game.hasVisual(infoSemillas)) game.removeVisual(infoSemillas)
    if (game.hasVisual(infoArboles)) game.removeVisual(infoArboles)
    generador.limpiar()
    gestorArboles.limpiar()
  }
  
  method ocultar() { 
    if (game.hasVisual(self)) {
      game.removeVisual(self)
    }
  }
}
object musicaJuego {
  const musica = game.sound("musicaJuego.mp3")
  
  method iniciar() {
    musica.shouldLoop(true)
    musica.volume(0.7)
    musica.play()
  }
  
  method detener() {
    musica.stop()
  }
}
object controladorJuego {
  var property juegoActivo = false
  var property juegoIniciado = false
  var property inicio = true 
  
  method terminarJuego() {
    juegoActivo = false
  }
  
  method iniciarJuego() {  
    if (!juegoIniciado) {
      juegoActivo = true
      juegoIniciado = true
      inicio = false
      pantallaInicio.ocultar()
      
      game.addVisual(superiorBarraHUD)
      game.addVisual(barraAtmosfera)
      game.addVisual(infoSemillas)
      game.addVisual(infoArboles)
      game.addVisual(personaje)
      game.addVisual(barraHUDinferior)
      game.addVisual(infoBanana)
      game.addVisual(infoManzana)
      game.addVisual(infoLata)
      game.addVisual(infoPapel)

      
      generador.basuraInicial()
      generador.iniciarRegeneracion()
      atmosfera.iniciarContador()
      
      musicaJuego.iniciar()
    }
  }
  
  method reiniciar() {
    if (!self.inicio() and !self.juegoActivo()){
      pantallaFinal.ocultar()
    
 
    if (!game.hasVisual(superiorBarraHUD)) game.addVisual(superiorBarraHUD)
    if (!game.hasVisual(barraAtmosfera)) game.addVisual(barraAtmosfera)
    if (!game.hasVisual(infoSemillas)) game.addVisual(infoSemillas)
    if (!game.hasVisual(infoArboles)) game.addVisual(infoArboles)
    if (!game.hasVisual(personaje)) game.addVisual(personaje)
    
    personaje.reiniciar()
    atmosfera.reiniciar()
    gestorArboles.limpiar()
    generador.limpiar()
    
    juegoActivo = true 
    
    generador.basuraInicial()
    generador.iniciarRegeneracion()
    atmosfera.iniciarContador()
    musicaJuego.iniciar()
  }
    }
}