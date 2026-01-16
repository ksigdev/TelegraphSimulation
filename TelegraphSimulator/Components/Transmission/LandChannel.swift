struct LandChannel: SignalTransmitter {
    let id: String
    let length: Double  // Longitud en kms
    private let degradationRate: Double = 0.001 // Ratio de degradación por km. (0,1% x km)

    init(id: String, length: Double) {
        self.id = id
        self.length = length
    }

    func transmit(_ signal: Signal) async -> Result<Signal, TransmissionError> {

        // Comprobamos que la señal nos llega es legible.
        guard signal.isReadable else {
            return .failure(.signalLost(at: "Entrada de \(id)"))
        }

        // Simulamos un retardo en función de la distancia (0,01s x km)
        try? await Task.sleep(nanoseconds: UInt64(length * 10_000_000))

        // Aplicamos degradación en función de la longitud del canal.
        let loss = length * degradationRate
        let newStrength = signal.strength - loss
        let newSignal = Signal(payload: signal.payload, strength: newStrength)

        // Comprobamos que la señal sigue siendo legible.
        guard newSignal.isReadable else {
            return .failure(.signalLost(at: id))
        }

        print("[\(id)] - Transmisión exitosa")
        return .success(newSignal)
    }
}
