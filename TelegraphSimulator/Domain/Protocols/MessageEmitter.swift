protocol MessageEmitter: TelegraphComponent {
    var encoder: MessageEncoder { get }
    var isActive: Bool { get }

    func turnOn()
    func turnOff()
    /// Inicia el envío. Convierte el texto inicial en Signal.
    func emit(message: String) -> Signal
}
