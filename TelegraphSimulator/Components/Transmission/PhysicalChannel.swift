/// Representa un tramo de cable físico que degrada la señal en función del tipo de cable y de la distancia.
struct PhysicalChannel: SignalTransmitter {
    let id: String
    let length: Double  // Longitud en kms
    let type: ChannelType

    enum ChannelType {
        case land
        case submarine
        case simulated(degradationRate: Double)

        var degradationRate: Double {
            switch self {
            case .land: return 0.001
            case .submarine: return 0.002
            case .simulated(degradationRate: let degradationRate): return degradationRate
            }
        }
    }

    init(id: String, length: Double, type: ChannelType) {
        self.id = id
        self.length = length
        self.type = type
    }

    func transmit(_ signal: Signal) async -> Result<Signal, TransmissionError> {

        // Comprobamos que la señal nos llega es legible.
        guard signal.isReadable else {
            return .failure(.signalLost(at: "Entrada de \(id)"))
        }

        // Simulamos un retardo en función de la distancia (0,01s x km)
        try? await Task.sleep(nanoseconds: UInt64(length * 10_000_000))

        // Aplicamos degradación en función de la longitud del canal.
        let loss = length * type.degradationRate
        let newStrength = signal.strength - loss
        let newSignal = Signal(payload: signal.payload, strength: newStrength)

        // Comprobamos que la señal sigue siendo legible
        guard newSignal.isReadable else {

            // Calculamos en qué punto la señal ha perdido la mínima fuerza necesaria para ser legible.
            let availableStrength = newSignal.strength - 0.1
            let maxDistance = availableStrength / type.degradationRate
            let pointOfFailure = min(maxDistance, length)
            let failureDetail = "\(id) a los \(pointOfFailure)) km"
            return .failure(.signalLost(at: failureDetail))
        }

        print("[\(id)] - Transmisión exitosa")
        return .success(newSignal)
    }
}
