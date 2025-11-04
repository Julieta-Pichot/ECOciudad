import wollok.game.*
import personaje.*

class Basura {
  var property position
  var property image
  
  method valorSemillas()
  
  method serRecolectada() {
    game.removeVisual(self)
    personaje.recolectarBasura(self)
    generador.eliminarBasura(self)
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
  const max = 20
  
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
    const y = 0.randomUpTo(14).truncate(0)
    return game.at(x, y)
  }
  
  method basuraInicial() {
    self.crearBananas(6)
    self.crearManzanas(8)
    self.crearPapeles(7)
    self.crearLatas(5)
  }
  
  method iniciarRegeneracion() {
    game.onTick(3000, "regenerar basura", { self.regenerarBasura() })
  }
  
  method detenerRegeneracion() {
    game.removeTickEvent("regenerar basura")
  }
  
  method regenerarBasura() {
    // Solo regenerar si no hay demasiada basura
    if (basurasActivas.size() < max) {
      const prob = 1.randomUpTo(100)
      
      
      // Probabilidades según balance
      if (prob <= 35) {
        self.crearBananas(1) // 35% Banana
      } else {
        if (prob <= 70) {
          self.crearManzanas(1) // 35% Manzana
        } else {
          if (prob <= 90) self.crearPapeles(1) // 20% Papel
          else self.crearLatas(1) // 10% Lata
        }
      }
    }
  }
  
  method eliminarBasura(basura) {
    basurasActivas.remove(basura)
  }
  method limpiar() {
    basurasActivas.forEach({ basura => 
      if (game.hasVisual(basura)) game.removeVisual(basura)
    })
    basurasActivas.clear()
    self.detenerRegeneracion()
  }
}