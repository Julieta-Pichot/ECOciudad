import wollok.game.*
import personaje.*

class Arbol {
  const property position
  const property image = "arbolon.png"
}

object gestorArboles {
  var property arboles = []
  
  method plantarArbol(posicion) {
    const nuevoArbol = new Arbol(position = posicion)
    arboles.add(nuevoArbol)
    game.addVisual(nuevoArbol)
  }
  method posicionOcupada(pos) {
    return game.getObjectsIn(pos).size() > 1
  }
  
  method limpiar() {  
    arboles.forEach({ arbol => game.removeVisual(arbol) })
    arboles.clear()
  }
}
