struct EmitterActor: MessageEmitter {
    let id: String
    var encoder: any MessageEncoder
    var isActive: Bool = false

    // Activa el emisor.
    mutating func turnOn() {
        isActive = true
        print("[\(id)] \(id) activado.")
    }

    // Desactiva el emisor.
    mutating func turnOff() {
        isActive = false
        print("[\(id)] \(id) desactivado.")
    }

    // Inicia el envío del mensaje.
    func emit(message: String) -> Signal {

        // Si el emisor está desactivado, "envía" una señal vacía y sin fuerza.
        guard isActive else {
            print("[\(id)] \(id) está desactivado")
            return Signal(payload: "", strength: 0.0)
        }
        
        let encodedMessage = encoder.encode(message)
        return Signal(payload: encodedMessage, strength: 1.0)
    }
}
