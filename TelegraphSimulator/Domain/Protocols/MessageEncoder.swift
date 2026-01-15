protocol MessageEncoder {
    /// Codifica el mensaje original y lo transforma a TelegraphData.
    func encode(_ message: String) -> TelegraphData
    /// Descodifica los datos y devuelve el mensaje original.
    func decode(_ data: TelegraphData) -> String
}
