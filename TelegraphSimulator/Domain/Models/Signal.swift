/// Representa el pulso que viaja por el sistema
/// Transporta información (payload) y posee una intensidad (strength)
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
