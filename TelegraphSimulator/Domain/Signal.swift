///Representa el contenido crudo de la transmisión.
///Utilizamos un typealias para que el sistema sea agnóstico al formato utilizado.
typealias TelegraphData = String

struct Signal {
    let payload: TelegraphData
    var strength: Double

    init(payload: TelegraphData, strength: Double = 1.0) {
        self.payload = payload
        self.strength = strength
    }
    /// Valida si la señal sigue siendo legible.
    var isReadable: Bool {
        strength > 0.1
    }
}
