class Plato {
  const cocinero

  method cocinero() = cocinero
  method azucar()
  method esBonito()
  method calorias() = 3 * self.azucar() + 100
}

class Entrada inherits Plato {
  override method azucar() = 0
  override method esBonito() = true
}

class Principal inherits Plato {
  const azucar = 0
  const esBonito

  override method azucar() = azucar
  override method esBonito() = esBonito
}

class Postre inherits Plato {
  const colores = 0

  override method azucar() = 120
  override method esBonito() = colores > 3
}

class Cocinero {
  var especialidad

  method catar(plato) = especialidad.calificar(plato)

  method cambiarEspecialidad(nuevaEspecialidad) {
    especialidad = nuevaEspecialidad
  }

  method cocinar() = especialidad.crearPlato(self)

  method participar(torneo) {
    torneo.platosPresentados().add(self.cocinar())
  }
}

class Pastelero {
  const dulzorDeseado

  method calificar(plato) = (5 * plato.azucar() / dulzorDeseado).min(10)
  method crearPlato(creador) = new Postre(colores = dulzorDeseado / 50, cocinero = creador)
}

class Chef {
  const caloriasAceptadas

  method acepta(plato) = plato.esBonito() && plato.calorias() <= caloriasAceptadas
  method calificar(plato) = if (self.acepta(plato)) 10 else 0
  method crearPlato(creador) = new Principal(azucar = caloriasAceptadas, esBonito = true, cocinero = creador)
}

class Souschef inherits Chef {
  override method calificar(plato) = if (self.acepta(plato)) 10 else (plato.calorias() / 100).min(6)
  override method crearPlato(creador) = new Entrada(cocinero = creador)
}

class Torneo {
  const catadores
  const property platosPresentados = []
  
  method puntuacion(plato) = catadores.sum({catador => catador.catar(plato)})
  method listaPuntuaciones() = platosPresentados.map({plato => self.puntuacion(plato)})
  method platoGanador() = platosPresentados.filter({plato => self.puntuacion(plato) == self.listaPuntuaciones().max()})
  method ganador() = if (platosPresentados.size() > 0) self.platoGanador().cocinero() else throw new DomainException()
}

const thom = new Cocinero(especialidad = new Pastelero(dulzorDeseado = 300))
const jonny = new Cocinero(especialidad = new Chef(caloriasAceptadas = 130))
const collin = new Cocinero(especialidad = new Souschef(caloriasAceptadas = 300))
const phil = new Cocinero(especialidad = new Pastelero(dulzorDeseado = 150))
const ed = new Cocinero(especialidad = new Chef(caloriasAceptadas = 200))
const kida = new Cocinero(especialidad = new Souschef(caloriasAceptadas = 330))

const bbo = new Torneo(catadores = [thom, jonny, collin])