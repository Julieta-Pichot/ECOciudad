import wollok.game.*
import basura.*
import arbol.*
import atmosfera.*

object juego {
  method iniciar() {
    game.onCollideDo(personaje, {basura => basura.serRecolectada()})
    game.onCollideDo(personaje, { algo => algo.teAgarroPersonaje() })
    //disparador principal de logica, cuando el personaje choque con algo se ejecuta el "teAgarroPersonaje"
  }
}

object personaje {
  var property position = game.at(13, 7)
  const inventario = []
  var property cantSemillas = 0
  var property basuraRecolectada = 0 
  var property arbolesPlantados = 0
  const objetivoPlantaciones = 10
  const semillasNecesarias = 70

  method image() = "persona.png"

  method mover(nuevaPosicion) {
    if (self.posicionValida(nuevaPosicion)) {
      position = nuevaPosicion
    }
  }
  method posicionValida(pos) = 
  pos.x() >= 0 && pos.x() < game.width() && 
  pos.y() >= 0 && pos.y() < 14 

  method recolectarBasura(basura) {
    cantSemillas += basura.valorSemillas()
    basuraRecolectada += 1
    game.say(self, "semillas: " + cantSemillas)
    inventario.add(basura)
    if (self.podesPlantar()){
      game.say(self, "Ya podes planta un arbolito!!")
    } else{
      const faltanSemillas = semillasNecesarias - cantSemillas
    }
  }
  method verInventario() {
    const cantBananas = inventario.count({b => b.imagen() == "bananita.png"})
    const cantManzanas = inventario.count({b => b.imagen() == "manzanita.png"})
    const cantPapel = inventario.count({b => b.imagen() == "papelito.png"})
    const cantLata = inventario.count({b => b.imagen() == "latita.png"})

    game.say(self, "Banana" + cantBananas + "Manzana" + cantManzanas + "Papel" + cantPapel + "Lata" + cantLata)
  }
  method decir() {
    return
    basuraRecolectada
  }
  method podesPlantar() {
    return cantSemillas >= semillasNecesarias
  }
method plantar() {
  if(!self.podesPlantar()) {
    const faltanSemillas = semillasNecesarias - cantSemillas
    game.say(self, "No tenEs suficientes semillas (Tenés: " + cantSemillas + ", necesitás: " + semillasNecesarias + ")")
  } 
  else if(gestorArboles.posicionOcupada(position)) {
    game.say(self, "¡Ya hay un árbol en esta posición!")
  }
  else if (arbolesPlantados >= objetivoPlantaciones) {
    game.say(self, "¡Ganaste! La ciudad está salvada ")
  } 
  else {
    gestorArboles.plantarArbol(self.position())
    cantSemillas -= semillasNecesarias
    arbolesPlantados += 1
    atmosfera.aumentar(1) 
  }
}
}

