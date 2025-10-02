import wollok.game.*
import basura.*

object juego {
  method iniciar() {
    game.addVisualCharacter(personaje)
    
    game.onCollideDo(personaje, { algo => algo.teAgarroPersonaje() })
    //disparador principal de logica, cuando el personaje choque con algo se ejecuta el "teAgarroPersonaje"
  }
}

object personaje {
  var property position = game.at(5, 10)
  var property inventario = []
  var property cantSemillas = 0
  var property arbolesPlantados = 0
  const objetivoArboles = 10
  
  method image() = "persona.png"
  
  method mover(nuevaPosicion) {
    if (self.posicionValida(nuevaPosicion)) {
      position = nuevaPosicion
    }
  }
  method posicionValida(
    pos
  ) = (((pos.x() >= 0) && (pos.x() < game.width())) && (pos.y() >= 0)) && (pos.y() < game.height())
  
  method recolectarBasura() {
    
  }
  
  method podesPlantar() {
    
  }
  
  method plantar() {
    
  }
}