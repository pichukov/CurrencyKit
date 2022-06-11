import SwiftUI

public struct ImageFlagView: View {

    private let countryCode: String
    private let style: Style
    private let contentMode: ContentMode

    public init(
        countryCode: String,
        style: Style = .default,
        contentMode: ContentMode = .fill
    ) {
        self.countryCode = countryCode.uppercased()
        self.style = style
        self.contentMode = contentMode
    }

    public init(
        currencyCode: String,
        style: Style = .default,
        contentMode: ContentMode = .fill
    ) {
        self.init(
            countryCode: Currency.countryCode(fromCurrencyCode: currencyCode),
            style: style,
            contentMode: contentMode
        )
    }

    public var body: some View {
        switch style {
        case .default:
            Image(countryCode.lowercased(), bundle: .currentModule)
                .resizable()
                .aspectRatio(contentMode: contentMode)
        case .circle:
            Image(countryCode.lowercased(), bundle: .currentModule)
                .resizable()
                .aspectRatio(contentMode: contentMode)
                .clipShape(Circle())
        }
    }
}

public extension ImageFlagView {

    enum Style {
        case `default`
        case circle
    }
}

struct ImageFlagView_Previews: PreviewProvider {
    static var previews: some View {
        ImageFlagView(
            countryCode: "eu",
            style: .circle,
            contentMode: .fill
        )
            .frame(width: 100, height: 100)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
