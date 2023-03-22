import Foundation

public struct Currency: Identifiable, Codable, Hashable {

    public let id: String
    public let code: String
    public let description: String
    public let symbol: String

    private let locale: Locale

    public init(withCode code: String, localeType: LocaleType = .device) {
        id = code
        self.code = code.uppercased()
        self.description = Locale.current.localizedString(forCurrencyCode: code) ?? ""
        switch localeType {
        case .device: locale = Locale.current
        case .currency: locale = Currency.getLocale(fromCode: self.code)
        case .custom(let locale): self.locale = locale
        }
        let formatter = NumberFormatter()
        formatter.locale = locale
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

    static func getLocale(fromCode code: String) -> Locale {
        let code = code.uppercased()
        let identifiers = Locale.availableIdentifiers.filter({ Locale(identifier: $0).currencyCode == code })
        var identifier = identifiers.filter { $0.contains("en") }.first ?? ""

        for id in identifiers {
            let elements = id.components(separatedBy: "_")

            guard elements.count == 2 else { continue }
            guard let prefix = elements.first, let postfix = elements.last else { continue }

            if let prefixChar = prefix.first,
               let postfixChar = postfix.lowercased().first,
               prefixChar == postfixChar {
                identifier = id
            }
            if prefix == postfix.lowercased() {
                identifier = id
                break
            }
        }

        return identifier.isEmpty ? Locale(identifier: code) : Locale(identifier: identifier)
    }
}

public extension Currency {

    enum LocaleType {
        case device
        case currency
        case custom(Locale)
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
