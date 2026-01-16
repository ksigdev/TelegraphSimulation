class SimpleRelay: SignalTransmitter {
    let id: String

    init(id: String) {
        self.id = id
    }

    func transmit(_ signal: Signal) async -> Result<Signal, TransmissionError> {

        guard signal.isReadable else {
            return .failure(.signalLost(at: "Entrada de \(id)"))
        }

        try? await Task.sleep(nanoseconds: 10_000_000)

        // Restauramos completamente la fuerza de la señal.
        let restoredSignal = Signal(payload: signal.payload, strength: 1.0)

        print("[\(id)] Señal restaurada.")
        return .success(restoredSignal)
    }
}


class BatteryRelay: SimpleRelay {
    var batteryLevel: Int = 100
    let consumption: Int = 10 // Utiliza un 10% de la batería para regenerar fuerza de la señal.

    override func transmit(_ signal: Signal) async -> Result<Signal, TransmissionError> {

        // Comprobamos que la batería sea suficiente para regenerar la fuerza de la señal.
        guard batteryLevel >= consumption else {
            return .failure(.noBattery(id: id))
        }

        let result = await super.transmit(signal)

        if case .success = result {
            batteryLevel -= consumption
        }
        return result
    }
}

class SmartRelay: BatteryRelay {
    private let enoughStrength: Double = 0.7 // Nivel de fuerza de la señal a partir del cual no necesita ser restaurada.

    override func transmit(_ signal: Signal) async -> Result<Signal, TransmissionError> {
        // Comprobamos si la fuerza de la señal recibida es suficiente.
        if signal.strength >= enoughStrength {
            print("[\(id)] Modo ahorro - Fuerza de la señal en rango óptimo, no necesita ser restaurada.")
            return .success(signal)
        } else {
            return await super.transmit(signal)
        }
    }
}
