importar wollok.game. *

const blastoise =  new TipoAgua (position = game.at ( 1 , 3 ), vida =  100 , vidaMax =  100 , nombre =  " blastoise " , imagen =  " blastoise.png " , tipo =  " agua " )

const charizard =  new TipoFuego (position = game.at ( 10 , 3 ), vida =  150 , vidaMax =  150 , nombre =  " charizard " , imagen =  " charizard2.png " , tipo =  " fuego " )

const mega =  new PiedraMega (position = game.at ( 5 , 3 ))

objeto reinicio {
	 posición de la propiedad var = juego.at ( 1 , 5 )
	
	método image () =  " reinicio.png "
}

object juego {
	
	método restablecer () {
		charizard.Inicial ()
		blastoise.Inicial ()
	}
	
	método inicio () {
		
		// Objetos
		self .restablecer ()
		game.addVisual (blastoise)
		game.addVisual (charizard)
		game.addVisual (mega)
		
		// Movimiento
		keyboard.a (). onPressDo ({movimiento.moveteIzquierda (blastoise)})
		keyboard.d (). onPressDo ({movimiento.moveteDerecha (blastoise)})
		keyboard.w (). onPressDo ({movimiento.moveteArriba (blastoise)})
		keyboard.s (). onPressDo ({movimiento.moveteAbajo (blastoise)})
		keyboard.j (). onPressDo ({movimiento.moveteIzquierda (charizard)})
		keyboard.k (). onPressDo ({movimiento.moveteAbajo (charizard)})
		keyboard.l (). onPressDo ({movimiento.moveteDerecha (charizard)})
		keyboard.i (). onPressDo ({movimiento.moveteArriba (charizard)})
		
		// Poderes
		keyboard.space (). onPressDo ({blastoise.ataque ()})
		keyboard.enter (). onPressDo ({charizard.ataque ()})
		
		// Colisiones
		game.whenCollideDo (blastoise, {objeto => objeto.colisionar (blastoise)})
		game.whenCollideDo (charizard, {objeto => objeto.colisionar (charizard)})
		
		// Musica
		const musicaPokemon = game.sound ( " Musica.mp3 " )
		game.schedule ( 100 , {musicaPokemon.play ()})
		musicaPokemon.volumen ( 0.5 )
		
		// REINICIO DEL JUEGO
		keyboard.r (). onPressDo ({ self .reiniciar ()})
		
		// FINALIZAR JUEGO
		keyboard.t (). onPressDo ({ self .terminar ()})
	
	}
	
	método reiniciar () {  
		juego.clear ()
		self .inicio ()
		game.addVisual (reinicio)
		game.schedule ( 500 , {game.removeVisual (reinicio)})
	}
	
	método terminar () {
		game.stop ()
	}
}

clase Pokémon {
	var  property vida
	 posición de la propiedad var
	var  propiedad nombre
	var  propiedad vidaMax
	var cargaAtqMax =  0
 	var megaEvol =  0
	var imagen
	
	método imagen () = imagen
	
	método Inicial () {
		
	}
	
	método morir () {
		const ganador = game.sound ( " Winner.mp3 " )
			ganador.play ()
			game.removeVisual ( self )
			// añadir imagen para reinicio de juego
	}
	
	método restarVida (ataque) {
		vida = vida - (ataque.danio () /  10 )
		if ( self .vida () <=  0 ) {
			yo .morir ()
		} más {
			game.say ( self , " mi vida actual: "  +  self .vida (). toString ())
		}
	}
	
	método restaurarS (ataque) {
		var auxi
		si (vida < vidaMax) {
			auxi = vida + vida * ataque.restaurarS ()
			if (auxi > vidaMax) {	
				vida = vidaMax
			}
			else {
				vida = auxi
			}
		}
	}
	
	método miAtaque () {
      var ataque
 		if ((cargaAtqMax <  2 ) y (megaEvol ==  0 )) {
			  ataque =  self .generarAtaque ()
			  cargaAtqMax = cargaAtqMax +  1
			  regreso ataque
			  }
		else {
			ataque =  self .generarAtaqueFuerte ()
			cargaAtqMax =  0
			regreso ataque
		}
	}
	
	método ataque () {
		const ataque =  self .miAtaque ()
		self .restaurarS (ataque)
		game.say ( self , ataque.nombre ())
		game.addVisual (ataque) 
		ataque.moveteHaciaAdelante ( yo )
		game.onTick ( 500 , " movimientoAtaque " , {ataque.moverAtaque ()})
	}
	
	método generarAtaque () {
		volver  0
	}
	
	método generarAtaqueFuerte () {
		volver  0
	}

	método rebotarHaciaAtras () {
		
	}
	
	método colisionar (pokemon) {
		pokemon.rebotarHaciaAtras ()
		self .rebotarHaciaAtras ()
	}

	método megaEvolucion () {
		game.schedule ( 15000 , { =>  self .quitarMega ()})
	}
	
	método quitarMega () {
		game.addVisual (mega)
	}
	
}
 clase TipoAgua hereda Pokémon {
 	var  tipo de propiedad
 
 	anular  método rebotarHaciaAtras () {
 		movimiento.moveteIzquierda ( self )
 	}
 
 	anular  método Inicial () {
 		posición = juego.at ( 1 , 3 )
 		vida = vidaMax
 		cargaAtqMax =  0
 	}
 
 	anular  método generarAtaque () {
 		const hidrocanion =  new AtqTipoAgua (nombre =  " Hidrocanion " , danio =  70 , position =  self .position (), imagen =  " hidrocañon.png " , bonificacionA =  0 )
 		retorno hidrocanion
 	}
 	anular  método generarAtaqueFuerte () {
 		const hidrocanionMaximo =  new AtqTipoAgua (nombre = " Hidrocanion Maximo " , danio =  100 , position =  self .position (), imagen = " BolaDeAgua.png " , bonificacionA =  3 )
 		retorno hidrocanionMaximo
 	}
	
	anular  método megaEvolucion () {
		imagen =  " MegaBlastoise.png "
		vida =  300
		vidaMax =  300
		megaEvol =  1
		game.say ( self , " Mega Evolucion " )
		game.schedule ( 15000 , { =>  self .quitarMega ()})
	}
	anular  método quitarMega () {
		imagen =  " blastoise.png "
		vida =  100
		vidaMax =  100
		megaEvol =  0
		game.addVisual (mega)
	}
 		
 }
 clase TipoFuego hereda Pokémon {
 	var  tipo de propiedad
 
 	anular  método rebotarHaciaAtras () {
 		movimiento.moveteDerecha ( self )
 	}
 	
 	anular  método Inicial () {
 		posición = juego.at ( 10 , 3 )
 		vida = vidaMax
 		cargaAtqMax =  0
 	}
 
 	anular  método generarAtaque () {
 		const llamarada =  new AtqTipoFuego (nombre =  " Llamarada " , danio =  40 , position =  self .position (), imagen =  " llamarada.png " , bonificacionF =  0 )
 		volver llamarada
 	}
 	anular  método generarAtaqueFuerte () {
 		const llamaradaMaxima =  new AtqTipoFuego (nombre = " Llamarada Maxima " , danio =  110 , position =  self .position (), imagen = " BolaDeFuego.png " , bonificacionF =  30 )
 		volver llamaradaMaxima
 	}
 	
 	anular  método megaEvolucion () {
		imagen =  " MegaCharizard.png "
		vida =  400
		vidaMax =  400
		megaEvol =  1
		game.say ( self , " Mega Evolucion " )
		game.schedule ( 15000 , { =>  self .quitarMega ()})
	}
	
	anular  método quitarMega () {
		imagen =  " charizard2.png "
		vida =  150
		vidaMax =  150
		megaEvol =  0
		game.addVisual (mega)
	}
 }
 
clase Ataque {
	var  propiedad nombre
	var  propiedad danio
	 posición de la propiedad var
	var imagen
	
	método imagen () = imagen
	
	método restaurarS () {
		volver  0.15
	}
	
	método colisionar (pokemon) {
		pokemon.restarVida ( yo )
		game.removeVisual ( self )
	}
	
}

class AtqTipoFuego hereda Ataque {
	var bonificacionF
	
	anular el  método restaurarS () {
		retorno bonificacionF / 100
	}
	
	método moverAtaque () {
		posición = posición izquierda ( 1 )
	}
	
	método moveteHaciaAdelante (pokemon) {
		const x = pokemon.position (). x () -  1
		const y = pokemon.position (). y ()
		posición = juego.at (x, y)
	}
}

class AtqTipoAgua hereda Ataque {
	var bonificacionA
	
	 método de anulación danio () {
		return danio + ((bonificacionA * danio) / 6 )
	}
	
	método moverAtaque () {
		posición = posición derecha ( 1 )
	}
	
	método moveteHaciaAdelante (pokemon) {
		const x = pokemon.position (). x () +  1
		const y = pokemon.position (). y ()
		posición = juego.at (x, y)
	}
}

class PiedraMega {
	
	 posición de la propiedad var = game.center ()
	
	imagen del método () =  " PiedraMega.png "
	
	método colisionar (pokemon) {
		pokemon.megaEvolucion ()
		game.removeVisual ( self )
	}
}

movimiento del objeto {

	método moverL (objeto) {
		objeto.position (objeto.position (). left ( 1 ))
	}

	método moverDown (objeto) {
		objeto.position (objeto.position (). down ( 1 ))
	}

	método moverR (objeto) {
		objeto.position (objeto.position (). right ( 1 ))
	}

	método moverUp (objeto) {
		objeto.position (objeto.position (). up ( 1 ))
	}

	método moveteIzquierda (objeto) {
		if (objeto.position (). x () >  0  y objeto.position (). x () <=  11 ) self .moverL (objeto)
	}

	método moveteDerecha (objeto) {
		if (objeto.position (). x () > =  0  y objeto.position (). x () <  11 ) self .moverR (objeto)
	}

	método moveteArriba (objeto) {
		if (objeto.position (). y () > =  0  y objeto.position (). y () <  5 ) self .moverUp (objeto)
	}

	método moveteAbajo (objeto) {
		if (objeto.position (). y () >  0  y objeto.position (). y () <=  6 ) self .moverDown (objeto)
	}


}
