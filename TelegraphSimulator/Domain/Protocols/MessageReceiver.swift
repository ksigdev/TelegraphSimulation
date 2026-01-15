protocol MessageReceiver: TelegraphComponent {
    var encoder: MessageEncoder { get }
    /// Recibe la señal y devuelve el resultado con el texto original o un error.
    func receive(_ signal: Signal) -> Result<String, TransmissionError>
}
