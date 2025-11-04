import wollok.game.*
import personaje.*
import gameOver.*
import basura.*

object atmosfera {
  var property vidaAtmosfera = 7
  var property estaViva = true
  const vidaMaxima = 7
  const vidaMinima = 0
  
  method decrementar() {
    if (vidaAtmosfera > vidaMinima) {
      vidaAtmosfera -= 1
      
      if (vidaAtmosfera == 3) game.say(
          personaje,
          "⚠️ La atmósfera está crítica"
        )
      
      // Verificar si llegó a 0
      if (vidaAtmosfera <= 0) self.gameOver()
    }
  }
  
  method aumentar(cantidad) {
    vidaAtmosfera = (vidaAtmosfera + cantidad).min(vidaMaxima)
    game.say(
      personaje,
      (("Atmosfera restaurada: " + vidaAtmosfera) + "/") + vidaMaxima
    )
  }
  
  method iniciarContador() {
    game.onTick(5000, "atmosfera", { self.decrementar() })
  }
  
  method detenerContador() {
    game.removeTickEvent("atmosfera")
  }
  
  method gameOver() {
    estaViva = false
    self.detenerContador()
    generador.detenerRegeneracion()
    pantallaFinal.mostrarDerrota()
  }
  
  method reiniciar() {
    self.detenerContador()
    vidaAtmosfera = 7
    estaViva = true
  }
}

object barraAtmosfera {
  var property position = game.at(0, 14)
  
  method image() = ("vida" + atmosfera.vidaAtmosfera()) + ".png"
}

object fondoBarraHUD {
  var property position = game.at(0, 14)
  
  method image() = "barra.png"
}

object infoSemillas {
  var property position = game.at(13, 14)
  
  method text() = "Semillas: " + personaje.cantSemillas()
  
  method textColor() = "FFFFFF"
}

object infoArboles {
  var property position = game.at(18, 14)
  
  method text() = (("Arboles: " + personaje.arbolesPlantados()) + "/") + 10
  
  method textColor() = "FFFFFF"
}