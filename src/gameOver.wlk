import wollok.game.*
import personaje.*
import basura.*
import atmosfera.*
import arbol.*

object pantallaFinal {
  var property position = game.at(0, 0)
  var esVictoria = false
  
  method image() = if (esVictoria) "victo.png" else "perdi.png"
  
  method mostrarDerrota() {
    esVictoria = false
    game.addVisual(self)
    self.ocultarTodo()
  }
  
  method mostrarVictoria() {
    esVictoria = true
    game.addVisual(self)
    self.ocultarTodo()
  }
  method ocultarTodo() { 

    game.removeVisual(personaje)
    game.removeVisual(fondoBarraHUD)
    game.removeVisual(barraAtmosfera)
    game.removeVisual(infoSemillas)
    game.removeVisual(infoArboles)
    generador.limpiar()
    gestorArboles.limpiar()
}
}

object controladorJuego {
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
    
    // Empezar de nuevo
    generador.basuraInicial()
    atmosfera.iniciarContador()
  }
}