import Foundation

class TelegraphCoordinator {
    private var emitter: any MessageEmitter
    private var receiver: any MessageReceiver
    private let network: [any SignalTransmitter]

    init(emitter: any MessageEmitter, receiver: any MessageReceiver, network: [any SignalTransmitter]) {
        self.emitter = emitter
        self.receiver = receiver
        self.network = network
    }

    func send(message: String) async {
        print("\nINICIANDO TRANSMISIÓN")

        // Comprobamos que el emisor está activado antes de comenzar la transmisión.
        guard emitter.isActive else {
            print("[\(emitter.id)]: \(emitter.id) está desactivado")
            print("ABORTANDO TRANSMISIÓN")
            return
        }

        // El emisor comienza el envío del mensaje.
        var currentSignal = emitter.emit(message: message)

        // La señal pasa através de la red de canales y relés.
        for component in network {

            let result = await component.transmit(currentSignal)

            // Se comprueba que la señal pasa a través de todos los componentes de la red, fallando en caso de error.
            switch result {
            case .success(let newSignal):
                currentSignal = newSignal
            case .failure(let error):
                print(error.localizedDescription)
                return
            }
        }

        // La señal llega al receptor
        let finalResult = receiver.receive(currentSignal)

        // Se obtiene el resultado final de la transmissión.
        switch finalResult {
        case .success(let decodedMessage):
            print("[\(receiver.id)]: Mensaje recibido correctamente: \(decodedMessage)")
        case .failure(let error):
            print(error.localizedDescription)
        }

        print("FIN DE LA TRANSMISIÓN")
    }
}
