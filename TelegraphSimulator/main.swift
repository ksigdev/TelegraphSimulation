import Foundation

let encoder = MorseEncoder()
var emitter = EmitterActor(id: "Emisor-1", encoder: encoder)
var receiver = ReceiverActor(id: "Receptor-1", encoder: encoder)
let network: [any SignalTransmitter] = [
    PhysicalChannel(id: "Cable-Terrestre-1", length: 20, type: .land),
    SmartRelay(id: "Relay-1"),
    PhysicalChannel(id: "Cable-Submarino-1", length: 30, type: .submarine),
]
let coordinator = TelegraphCoordinator(
    emitter: emitter,
    receiver: receiver,
    network: network
)

print("INICIANDO SIMULACIÓN")

Task {
    // Simulación 1: Mensaje con símbolos conocidos.
    print("\n[Prueba 1: Mensaje con símbolos conocidos]: 'HOLA'")
    await coordinator.send(message: "HOLA")

    // Simulación 2: Mensaje con símbolos desconocidos: Producirá error de decodificación.
    print("\n[Prueba 2: Mensaje con símbolos desconocidos]: 'HE_L!!LO #@!'")
    await coordinator.send(message: "HE_L!!LO #@!")
}

// Esperamos a que el usuario pulse enter para finalizar la ejecución del programa.
_ = readLine()
