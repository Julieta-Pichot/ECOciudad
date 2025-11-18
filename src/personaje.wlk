import wollok.game.*
import basura.*
import arbol.*
import atmosfera.*
import pantallas.*

object personaje {
  var property position = game.at(13, 7)
  var property cantSemillas = 0
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
  pos.y() >= 1 && pos.y() < 14 
  
  method recolectarBasura(basura) {
    cantSemillas += basura.valorSemillas()
    if (self.podesPlantar()) game.say(self, "Ya podés plantar un arbolito!!")
  }

  method podesPlantar() = (cantSemillas >= semillasNecesarias) and atmosfera.estaViva()

method plantar() {
    if (!self.podesPlantar()) {
      const faltanSemillas = semillasNecesarias - cantSemillas
      game.say(
        self,
        ("No tenes suficientes semillas (Te faltan " + faltanSemillas) + ")"
      )
    } else {
      if (gestorArboles.posicionOcupada(position)) {
        game.say(self, "¡Ya hay un árbol en esta posición!")
      } else {
        gestorArboles.plantarArbol(self.position())
        cantSemillas -= semillasNecesarias
        arbolesPlantados += 1
        atmosfera.aumentar()
      }
    }
    if (arbolesPlantados >= objetivoPlantaciones)
      pantallaFinal.mostrarVictoria()
  }
  
  method reiniciar() {
    position = game.at(13, 7)
    cantSemillas = 0
    arbolesPlantados = 0
  }
}
object barraHUDinferior {
  var property position = game.at(0, 0)
  
  method image() = "inferiorBarra.png"
}
object infoBanana {
  var property position = game.at(5, 0)
  method text() = "🍎Manzanas: 10 semillas "
  method textColor() = "FFFFFF"
}
object infoManzana {
  var property position = game.at(10, 0)
  method text() = "📄Papeles: 15 semillas "
  method textColor() = "FFFFFF"
}
object infoLata {
  var property position = game.at(15, 0)
  method text() = "🍌Bananas: 20 semillas "
  method textColor() = "FFFFFF"
}
object infoPapel {
  var property position = game.at(19.5, 0)
  method text() = "🥫Latas: 30 semillas "
  method textColor() = "FFFFFF"
}