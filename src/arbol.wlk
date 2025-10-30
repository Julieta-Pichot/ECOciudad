import wollok.game.*
import personaje.*

class Arbol {
  const property position
  const property image = "arbolon.png"
  const aumentoAtmosfera = 1
  
//   method teAgarroPersonaje() {
//   }
}

object gestorArboles {
  const arboles = []
  
  method plantarArbol(posicion) {
    const nuevoArbol = new Arbol(position = posicion)
    arboles.add(nuevoArbol)
    game.addVisual(nuevoArbol)
    return nuevoArbol
  }
  
  method posicionOcupada(pos) {
    return game.getObjectsIn(pos).size() > 1
    // > 1 porque el personaje ya está en esa posición
  }
  
  method cantidadArboles() = arboles.size()
  
  method arboles() = arboles

  method limpiar() {  
    arboles.forEach({ arbol => game.removeVisual(arbol) })
    arboles.clear()
  }
}