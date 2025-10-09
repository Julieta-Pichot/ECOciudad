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
  method crearBananas(cantidad) {
    cantidad.times({ i =>
      const b = new Banana(position = self.posicionAleatoria(), image = "bananita.png")
      game.addVisual(b)
    })
  }

  method crearManzanas(cantidad) {
    cantidad.times({ i =>
      const m = new Manzana(position = self.posicionAleatoria(), image = "manzanita.png")
      game.addVisual(m)
    })
  }

  method crearPapeles(cantidad) {
    cantidad.times({ i =>
      const p = new Papel(position = self.posicionAleatoria(), image = "papelito.png")
      game.addVisual(p)
    })
  }

  method crearLatas(cantidad) {
    cantidad.times({ i =>
      const l = new Lata(position = self.posicionAleatoria(), image = "latita.png")
      game.addVisual(l)
    })
  }

  method posicionAleatoria() {
    const x = 0.randomUpTo(game.width())
    const y = 0.randomUpTo(game.height())
    return game.at(x, y)
  }

  method basuraInicial() {
    self.crearBananas(6)
    self.crearManzanas(5)
    self.crearPapeles(4)
    self.crearLatas(3)
  }
}
