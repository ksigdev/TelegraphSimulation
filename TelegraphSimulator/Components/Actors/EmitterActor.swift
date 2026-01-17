class EmitterActor: MessageEmitter {
    let id: String
    var encoder: any MessageEncoder
    var isActive: Bool

    init(id: String, encoder: any MessageEncoder, isActive: Bool = false) {
        self.id = id
        self.encoder = encoder
        self.isActive = isActive
    }

    // Activa el emisor.
    func turnOn() {
        isActive = true
        print("[\(id)] Emisor activado.")
    }

    // Desactiva el emisor.
    func turnOff() {
        isActive = false
        print("[\(id)] Emisor desactivado.")
    }

    // Inicia el envío del mensaje.
    func emit(message: String) -> Signal {
        let encodedMessage = encoder.encode(message)
        return Signal(payload: encodedMessage, strength: 1.0)
    }
}
