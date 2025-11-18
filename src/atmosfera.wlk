import wollok.game.*
import personaje.*
import pantallas.*
import basura.*

object atmosfera {
  var property vidaAtmosfera = 7
  var property estaViva = true
  
  method decrementar() {
    if (vidaAtmosfera > 0) {
      vidaAtmosfera -= 1
      
      if (vidaAtmosfera == 3) game.say(
          personaje,
          "⚠️ La atmósfera esta citica"
        )
      if (vidaAtmosfera <= 0) self.gameOver()
    }
  }
  
  method aumentar() {
    vidaAtmosfera = (vidaAtmosfera + 1).min(7)
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
    vidaAtmosfera = 7
    estaViva = true
  }
}

object barraAtmosfera {
  var property position = game.at(0, 14)
  
  method image() = ("vida" + atmosfera.vidaAtmosfera()) + ".png"
}

object superiorBarraHUD {
  var property position = game.at(0, 14)
  
  method image() = "barra.png"
}

object infoSemillas {
  var property position = game.at(13, 14)
  
  method text() = "Semillas: " + personaje.cantSemillas()
  
  method textColor() {
    if (personaje.podesPlantar())
      return "00ff00ff"
    else
      return "FFFFFF"
  }
}

object infoArboles {
  var property position = game.at(18, 14)
  
  method text() = (("Arboles: " + personaje.arbolesPlantados()) + "/") + 10
  
  method textColor() = "FFFFFF"
}