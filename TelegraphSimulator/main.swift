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

print("------------------------------------------------")
print("SISTEMA DE TELÉGRAFO ACTIVADO")
print("------------------------------------------------")
print("Comandos disponibles:")
print(" - 'enviar' : Enviar un mensaje.")
print(" - 'on'    : Encender el emisor.")
print(" - 'off'     : Apagar el emisor.")
print(" - 'status' : Ver estado del emisor.")
print(" - 'salir'  : Cerrar el simulador.")
print("------------------------------------------------")

var isRunning = true

// Mantenemos el simulador vivo hasta que lo decida el usuario.
while isRunning {
    print("\n Comando > ", terminator: "")

    if let input = readLine()?.trimmingCharacters(in: .whitespacesAndNewlines), !input.isEmpty {

        switch input.lowercased() {

        case "salir":
            isRunning = false
            print("Apagando simulador...")

        case "enviar":

            // Pedimos el contenido del mensaje
            print("Introduce el mensaje a transmitir: ", terminator: "")
            if let mensaje = readLine(), !mensaje.isEmpty {

                // Creamos un semáforo para bloquear al hilo principal evitando que el bucle
                // pida el siguiente comando antes de que finalice la transmisión asíncrona.
                let semaphore = DispatchSemaphore(value: 0)
                Task {
                    await coordinator.send(message: mensaje)
                    semaphore.signal() // Indicamos al semáforo que ha finalizado la transmisión.
                }
                semaphore.wait() // El hilo principal espera aquí hasta recibir "signal()".
            }

        case "on":
            emitter.turnOn()

        case "off":
            emitter.turnOn()

        case "status":
            print("ESTADO: \(emitter.id) está \(emitter.isActive ? "activado" : "desactivado")")

        default:
            print("Comando desconocido. Escribe 'enviar', 'on', 'off', 'status' o 'salir'.")
        }
    }
}
