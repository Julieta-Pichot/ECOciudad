import wollok.game.*
import personaje.*
import basura.*
import atmosfera.*
import arbol.*

object pantallaFinal {
  var property position = game.at(0, 0)
  var esVictoria = false
  
  method image() = if (esVictoria) "victory.png" else "perdiste.png"
  
  method mostrarDerrota() {
    esVictoria = false
    controladorJuego.terminarJuego()
    game.addVisual(self)
    self.ocultarTodo()
  }
  
  method mostrarVictoria() {
    esVictoria = true
    controladorJuego.terminarJuego()
    game.addVisual(self)
    self.ocultarTodo()
  }
  
  method ocultarTodo() {
    // Usar hasVisual para evitar errores
    if (game.hasVisual(personaje)) game.removeVisual(personaje)
    if (game.hasVisual(fondoBarraHUD)) game.removeVisual(fondoBarraHUD)
    if (game.hasVisual(barraAtmosfera)) game.removeVisual(barraAtmosfera)
    if (game.hasVisual(infoSemillas)) game.removeVisual(infoSemillas)
    if (game.hasVisual(infoArboles)) game.removeVisual(infoArboles)
    
    generador.limpiar()
    gestorArboles.limpiar()
  }
}

object controladorJuego {
  var juegoActivo = true
  
  method juegoActivo() = juegoActivo
  
  method terminarJuego() {
    juegoActivo = false
  }
  
  method reiniciar() {
    // Ocultar pantalla
    game.removeVisual(pantallaFinal)
    game.addVisual(fondoBarraHUD)
    game.addVisual(barraAtmosfera)
    game.addVisual(infoSemillas)
    game.addVisual(infoArboles)
    game.addVisual(personaje)
    // Reiniciar valores
    personaje.reiniciar()
    atmosfera.reiniciar()
    gestorArboles.limpiar()
    generador.limpiar()
    
    juegoActivo = true
    // Empezar de nuevo
    generador.basuraInicial()
    generador.regenerarBasura()
    generador.iniciarRegeneracion()
    atmosfera.iniciarContador()
  }
}