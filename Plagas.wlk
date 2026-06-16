class Elementos {

  method esBuenoParaLaVidaDeLosHumanos()
  method serAtacadoPor_(plaga)
}

class Hogar inherits Elementos {
  var nivelMugre
  const confort

  method nivelMugre() = nivelMugre
  method aumentarMugre(cantidad) {nivelMugre += cantidad}

  override method esBuenoParaLaVidaDeLosHumanos() = nivelMugre <= confort * 0.5

  override method serAtacadoPor_(plaga) {
    self.aumentarMugre(plaga.nivelDeDaño())
  }
}
class Huerta inherits Elementos {
  var capacidadProduccion
  var nivel

  override method esBuenoParaLaVidaDeLosHumanos() = capacidadProduccion > nivel
  method variarNivel(nivelNuevo) {nivel = nivelNuevo}

  override method serAtacadoPor_(plaga) {
    var puntosAdicionales = 0
    if (plaga.produceEnfermedades()) {puntosAdicionales = 10}

    capacidadProduccion -= plaga.nivelDeDaño() * 0.1 + puntosAdicionales
  }
}
class Mascota inherits Elementos {
  var nivelSalud

  method disminuirSalud(cantidad) {nivelSalud -= cantidad}

  override method esBuenoParaLaVidaDeLosHumanos() = nivelSalud > 250

  override method serAtacadoPor_(plaga) {
    var saludPerdida = 0
    if (plaga.produceEnfermedades()) {saludPerdida = plaga.nivelDeDaño()}
    self.disminuirSalud(saludPerdida)
  }
}

class Barrio {
  const elementos = []

  method agregarElemento(elemento) {elementos.add(elemento)}
  method quitarElemento(elemento) {elementos.remove(elemento)}

  method elementosNoBuenos() = elementos.count({e => !e.esBuenoParaLaVidaDeLosHumanos()})
  method elementosBuenos() = elementos.count({e => e.esBuenoParaLaVidaDeLosHumanos()})
  method esBarrioCopado() = self.elementosBuenos() > self.elementosNoBuenos()
}

class Plaga {
  var poblacion

  method variarPoblacion(cantidad) {poblacion = cantidad}

  method nivelDeDaño()
  method produceEnfermedades() = poblacion >= 10

  method atacarA_(elemento) {
    elemento.serAtacadoPor_(self);
    poblacion *= 1.1
  }
}

class Cucaracha inherits Plaga {
  var pesoPromedio

  method pesoPromedio() = pesoPromedio

  override method nivelDeDaño() = poblacion * 0.5
  override method produceEnfermedades() = super() and self.pesoPromedio() >= 10
  
  override method atacarA_(elemento) {
    super(elemento);
    pesoPromedio += 2
  }
}

class Pulga inherits Plaga {

  override method nivelDeDaño() = poblacion * 2
}

class Garrapata inherits Plaga {

  override method nivelDeDaño() = poblacion * 2

  override method atacarA_(elemento) {
    poblacion *= 1.2
  }
}

class Mosquito inherits Plaga {

  override method nivelDeDaño() = poblacion
  override method produceEnfermedades() = super() and poblacion % 3 == 0
}