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

        let restoredSignal = Signal(payload: signal.payload, strength: 1.0)

        print("[\(id)] Señal restaurada.")
        return .success(restoredSignal)
    }
}


class BatteryRelay: SimpleRelay {
    var batteryLevel: Int = 100
    let consumption: Int = 10 // Utiliza un 10% de la batería para regenerar la señal.

    override func transmit(_ signal: Signal) async -> Result<Signal, TransmissionError> {

        guard signal.isReadable else {
            return .failure(.signalLost(at: "Entrada de \(id)"))
        }

        guard batteryLevel >= consumption else {
            return .failure(.noBattery(id: id))
        }

        let restoredSignal = Signal(payload: signal.payload, strength: 1.0)
        batteryLevel -= consumption
        return .success(restoredSignal)
    }
}

class SmartRelay: BatteryRelay {
    private let enoughStrength: Double = 0.7

    override func transmit(_ signal: Signal) async -> Result<Signal, TransmissionError> {

        guard signal.isReadable else {
            return .failure(.signalLost(at: "Entrada de \(id)"))
        }

        guard batteryLevel >= consumption else {
            return .failure(.noBattery(id: id))
        }

        if signal.strength >= enoughStrength {
            print("[\(id)] Modo ahorro - Fuerza de la señal suficiente en rango óptimo")
            return .success(signal)
        } else {
            let restoredSignal = Signal(payload: signal.payload, strength: 1.0)
            batteryLevel -= consumption
            print("[\(id)] Señal restaurada.")
            return .success(restoredSignal)
        }
    }
}
