struct EmitterActor: MessageEmitter {
    let id: String
    var encoder: any MessageEncoder
    var isActive: Bool = false

    // Activa el emisor.
    mutating func turnOn() {
        isActive = true
        print("[\(id)] Emisor activado.")
    }

    // Desactiva el emisor.
    mutating func turnOff() {
        isActive = false
        print("[\(id)] Emisor desactivado.")
    }

    // Inicia el envío del mensaje.
    func emit(message: String) -> Signal {
        let encodedMessage = encoder.encode(message)
        return Signal(payload: encodedMessage, strength: 1.0)
    }
}
