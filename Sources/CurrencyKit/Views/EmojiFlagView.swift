import SwiftUI

public struct EmojiFlagView: View {

    private let countryCode: String
    private let fontSize: CGFloat

    public init(
        countryCode: String,
        fontSize: CGFloat = 20
    ) {
        self.countryCode = countryCode.uppercased()
        self.fontSize = fontSize
    }

    public init(
        currencyCode: String,
        fontSize: CGFloat = 20
    ) {
        self.init(
            countryCode: Currency.countryCode(fromCurrencyCode: currencyCode),
            fontSize: fontSize
        )
    }

    public var body: some View {
        return Text(
            EmojiFlagView.flagEmoji(for: countryCode)
        )
            .font(.system(size: fontSize))
    }

    public static func flagEmoji(for countryCode: String) -> String {
        guard !countryCode.isEmpty else { return "🏳️" }
        let base: UInt32 = 127_397
        var code = ""
        for scalar in countryCode.unicodeScalars {
            if let unicode = UnicodeScalar(base + scalar.value) {
                code.unicodeScalars.append(unicode)
            }
        }
        return String(code)
    }

    public static func flagEmoji(forCurrencyCode code: String) -> String {
        return flagEmoji(for: String(code.dropLast()))
    }
}

struct EmojiFlagView_Previews: PreviewProvider {

    static var previews: some View {
        Group {
            EmojiFlagView(countryCode: "US")
                .previewLayout(.sizeThatFits)
            EmojiFlagView(currencyCode: "EUR")
                .previewLayout(.sizeThatFits)
        }
    }
}
