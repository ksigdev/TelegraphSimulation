class ReceiverActor: MessageReceiver {
    let id: String
    let encoder: any MessageEncoder
    let maximumErrorRate: Double // Porcentaje máximo de símbolos desconocidos permitidos en el mensaje.

    init(id: String, encoder: any MessageEncoder, maximumErrorRate: Double = 0.3) {
        self.id = id
        self.encoder = encoder
        self.maximumErrorRate = maximumErrorRate
    }

    func receive(_ signal: Signal) -> Result<String, TransmissionError> {
        
        guard signal.isReadable else {
            return .failure(.signalLost(at: id))
        }

        // Decodificamos el mensaje.
        let decodedMessage = encoder.decode(signal.payload)

        // Si el mensaje tiene más símbolos desconocidos de los permitidos, lo rechazamos.
        if isMessageCorrupted(decodedMessage) {
            return .failure(.decodingError(details: "El número de símbolos desconocidos supera el umbral permitido."))
        }

        return .success(decodedMessage)
    }

    // Comprueba si el mensaje contiene más símbolos de los permitidos.
    private func isMessageCorrupted(_ message: String) -> Bool {

        let unknownSymbolsCount = message.filter  { $0 == "?" }.count
        let errorRate = Double(unknownSymbolsCount) / Double(message.count)
        return errorRate > maximumErrorRate
    }
}
