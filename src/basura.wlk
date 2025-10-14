import wollok.game.*
import personaje.*

class Basura {
  var property position
  var property image
  
  method valorSemillas()
  
  method serRecolectada() {
    game.removeVisual(self)
    personaje.recolectarBasura(self)
  }
}

class Banana inherits Basura {
  override method valorSemillas() = 20
}

class Manzana inherits Basura {
  override method valorSemillas() = 10
}

class Papel inherits Basura {
  override method valorSemillas() = 15
}

class Lata inherits Basura {
  override method valorSemillas() = 30
}

object generador {
  const basurasActivas = []
  
  method posicionLibre() {
    const posicion = self.posicionAleatoria()
    
    if (game.getObjectsIn(posicion).isEmpty()) {
      return posicion
    } else {
      return self.posicionLibre()
    }
  }
  
  method crearBananas(cantidad) {
    cantidad.times(
      { i =>
        const b = new Banana(
          position = self.posicionLibre(),
          image = "bananita.png"
        )
        basurasActivas.add(b)
        return game.addVisual(b)
      }
    )
  }
  
  method crearManzanas(cantidad) {
    cantidad.times(
      { i =>
        const m = new Manzana(
          position = self.posicionLibre(),
          image = "manzanita.png"
        )
        basurasActivas.add(m)
        return game.addVisual(m)
      }
    )
  }
  
  method crearPapeles(cantidad) {
    cantidad.times(
      { i =>
        const p = new Papel(
          position = self.posicionLibre(),
          image = "papelito.png"
        )
        basurasActivas.add(p)
        return game.addVisual(p)
      }
    )
  }
  
  method crearLatas(cantidad) {
    cantidad.times(
      { i =>
        const l = new Lata(
          position = self.posicionLibre(),
          image = "latita.png"
        )
        basurasActivas.add(l)
        return game.addVisual(l)
      }
    )
  }
  
  method posicionAleatoria() {
    const x = 0.randomUpTo(game.width()).truncate(0)
    const y = 0.randomUpTo(game.height()).truncate(0)
    return game.at(x, y)
  }
  
  method basuraInicial() {
    self.crearBananas(6)
    self.crearManzanas(5)
    self.crearPapeles(4)
    self.crearLatas(3)
  }
}