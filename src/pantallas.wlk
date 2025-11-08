import wollok.game.*
import personaje.*
import basura.*
import atmosfera.*
import arbol.*

// Pantalla de inicio
object pantallaInicio {
  var property position = game.at(0, 0)
  
  method image() = "inicio.png"
  
  method mostrar() {
    game.addVisual(self)
  }
  
  method ocultar() {
    if (game.hasVisual(self)) {
      game.removeVisual(self)
    }
  }
}

// Pantalla final (victoria o derrota)
object pantallaFinal {
  var property position = game.at(0, 0)
  var esVictoria = false
  
  method image() = if (esVictoria) "victory.png" else "perdiste.png"
  
  method mostrarDerrota() {
    esVictoria = false
    controladorJuego.terminarJuego()
    self.ocultarTodo()  // ← CAMBIO: primero ocultar
    game.addVisual(self)  // ← después mostrar pantalla
  }
  
  method mostrarVictoria() {
    esVictoria = true
    atmosfera.detenerContador()
    controladorJuego.terminarJuego()
    self.ocultarTodo()  // ← CAMBIO: primero ocultar
    game.addVisual(self)  // ← después mostrar pantalla
  }
  
  method ocultarTodo() {
    if (game.hasVisual(personaje)) game.removeVisual(personaje)
    if (game.hasVisual(fondoBarraHUD)) game.removeVisual(fondoBarraHUD)
    if (game.hasVisual(barraAtmosfera)) game.removeVisual(barraAtmosfera)
    if (game.hasVisual(infoSemillas)) game.removeVisual(infoSemillas)
    if (game.hasVisual(infoArboles)) game.removeVisual(infoArboles)
    generador.limpiar()
    gestorArboles.limpiar()
  }
  
  method ocultar() {  // ← AGREGAR para cuando se reinicia
    if (game.hasVisual(self)) {
      game.removeVisual(self)
    }
  }
}

// Controlador del flujo del juego
object controladorJuego {
  var property juegoActivo = false
  var property juegoIniciado = false
  
  method activarJuego() {
    juegoActivo = true
  }
  
  method terminarJuego() {
    juegoActivo = false
  }
  
  method iniciarJuego() {  // ← AGREGAR método para iniciar por primera vez
    if (!juegoIniciado) {
      juegoIniciado = true
      pantallaInicio.ocultar()
      
      // Mostrar elementos del juego
      game.addVisual(fondoBarraHUD)
      game.addVisual(barraAtmosfera)
      game.addVisual(infoSemillas)
      game.addVisual(infoArboles)
      game.addVisual(personaje)
      
      // Iniciar el juego
      generador.basuraInicial()
      generador.iniciarRegeneracion()
      atmosfera.iniciarContador()
      
      juegoActivo = true
    }
  }
  
  method reiniciar() {
    // Ocultar pantalla final
    pantallaFinal.ocultar()  // ← CAMBIO: usar método
    
    // Verificar y mostrar elementos del HUD
    if (!game.hasVisual(fondoBarraHUD)) game.addVisual(fondoBarraHUD)
    if (!game.hasVisual(barraAtmosfera)) game.addVisual(barraAtmosfera)
    if (!game.hasVisual(infoSemillas)) game.addVisual(infoSemillas)
    if (!game.hasVisual(infoArboles)) game.addVisual(infoArboles)
    if (!game.hasVisual(personaje)) game.addVisual(personaje)
    
    // Reiniciar valores
    personaje.reiniciar()
    atmosfera.reiniciar()
    gestorArboles.limpiar()
    generador.limpiar()
    
    juegoActivo = true  // ← ACTIVAR ANTES de iniciar contadores
    
    // Empezar de nuevo
    generador.basuraInicial()
    generador.iniciarRegeneracion()
    atmosfera.iniciarContador()
  }
}