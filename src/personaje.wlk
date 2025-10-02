import wollok.game.*
import basura.*

object juego{
    method iniciar() {
      game.addVisualCharacter(personaje)

      game.onCollideDo(personaje, {algo=>algo.teAgarroPersonaje()})//disparador principal de logica, cuando el personaje choque con algo se ejecuta el "teAgarroPersonaje"
      
    }
}
object personaje {
    var property position = game.at(0,0)
    var property inventario = []
    var property cantSemillas = 0
    var property arbolesPlantados = 0
    const objetivoArboles = 10

    method image() = "gato.png"
    method mover(nuevaPosicion) { 
        self.position(nuevaPosicion)
    }
    method recolectarBasura(basura) {

     }
    method podesPlantar() {
      
    }
    method plantar() {
      
    }
}