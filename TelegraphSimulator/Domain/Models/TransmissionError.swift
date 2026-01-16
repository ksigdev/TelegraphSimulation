import Foundation

/// Definición de los errores
enum TransmissionError: Error {
    case signalLost(at: String)
    case componentFailure(id: String, details: String)
    case decodingError(details: String)
    case noBattery(id: String)
}

/// Separamos la lógica de presentación del error.
extension TransmissionError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .signalLost(at: let location):
            return "ERROR: Señal degradada irreversiblemente en \(location)"
        case .componentFailure(id: let id, details: let details):
            return "ERROR: El componente \(id) ha fallado: \(details)"
        case .decodingError(details: let details):
            return "ERROR: Error de decodificación: \(details)"
        case .noBattery(id: let id):
            return "ERROR: Batería insuficiente en el componente \(id)"
        }
    }
}
