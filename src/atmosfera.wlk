import wollok.game.*
import personaje.*
import gameOver.* 


object atmosfera {
  var property vidaAtmosfera = 7
  var property estaViva = true
  const vidaMaxima = 7
  const vidaMinima = 0

method decrementar() {
        if (vidaAtmosfera > vidaMinima) {
            vidaAtmosfera -= 1
            
            if (vidaAtmosfera == 3) {
                game.say(personaje, "La atmosfera está critica")
            }
        }        
}
method aumentar(cantidad) {
        vidaAtmosfera = (vidaAtmosfera + cantidad).min(vidaMaxima)
        game.say(personaje, "Atmosfera restaurada: " + vidaAtmosfera + "/" + vidaMaxima)
    }
 method iniciarContador() {
        game.onTick(5000, "atmosfera", {  
            self.decrementar()
        })
    }
    method detenerContador() {
        game.removeTickEvent("atmosfera")
    }
method gameOver() {
        estaViva = false
        self.detenerContador()
        pantallaFinal.mostrarDerrota()
    }
    method reiniciar() {  
        vidaAtmosfera = 7
        estaViva = true
    }

}
object barraAtmosfera {
    var property position = game.at(0, 14)
    method image() {
        return "vida" + atmosfera.vidaAtmosfera() + ".png"
    }
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
  
  method text() = "Arboles: " + personaje.arbolesPlantados() + "/" + 10
  method textColor() = "FFFFFF"
}

