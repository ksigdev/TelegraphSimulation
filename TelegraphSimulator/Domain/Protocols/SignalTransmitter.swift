protocol SignalTransmitter: TelegraphComponent {
    /// Transporta la señal o un error de transmisión.
    func transmit(_ signal: Signal)  async -> Result<Signal, TransmissionError>
}
