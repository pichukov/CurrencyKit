import Foundation

public struct Currency: Identifiable, Codable {

    public let id: String
    public let code: String
    public let description: String
    public let symbol: String

    private let locale: Locale

    public init(withCode code: String, localeType: LocaleType = .device) {
        id = UUID().uuidString
        self.code = code.uppercased()
        switch localeType {
            case .device: locale = Locale.current
            case .currency: locale = Locale(identifier: code)
        }
        self.description = Locale.current.localizedString(forCurrencyCode: code) ?? ""
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: code)
        self.symbol = formatter.currencySymbol ?? ""
    }

    public func formattedString(from value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.locale = locale
        formatter.numberStyle = .currency
        return formatter.string(from: NSNumber(value: value)) ?? ""
    }
}

public extension Currency {

    static func countryCode(fromCurrencyCode currencyCode: String) -> String {
        if let code = Constants.currencyExceptions[currencyCode] {
            return code
        } else if !Constants.currencyFewOptions.contains(currencyCode) {
            return String(currencyCode.dropLast())
        } else {
            return ""
        }
    }
}

public extension Currency {

    enum LocaleType {
        case device
        case currency
    }
}

private extension Currency {

    enum Constants {
        static let currencyExceptions = [
            "RMB": "CN",
            "CU": "CU",
            "NID": "IQ"
        ]
        // The list of currencies that can't be used for getting the exact Flag for
        static let currencyFewOptions: Set<String> = [
            "ANG",
            "XPF",
            "XAF",
            "XOF",
            "XCD"
        ]
    }
}
