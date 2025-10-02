import personaje.*


class Basura{
    var property position = game.at(0,0)
    var property valorSemillas = 0 

    method imagen() {}
    method serRecolectada() {
      self.teAgarroPersoanje()
    }
    self.generarBasura()
    method generarBasura() {
        game.onTick(1000, "aparece basura", {new Basura().aparecer()})
   }

}
class Banana inherits Basura(valorSemillas = 20){
    override method imagen() {}
    game.addVisual()

}
class Manzana inherits Basura(valorSemillas = 10){
    override method imagen() {}

}
class Papel inherits Basura(valorSemillas = 15){
    override method imagen() {}

}
class Lata inherits Basura(valorSemillas = 30){
    override method imagen() {}

}