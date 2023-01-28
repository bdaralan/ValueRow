import SwiftUI


/// A value row for list which contains an image, a leading label, and a trailing value.
///
/// Customization methods:
/// - ``withVRImageForeground(_:)``
/// - ``withVRLabelFont(_:)``
/// - ``onVRValueTap(count:action:)``
///
public struct ValueRow: View {
    
    private typealias Components = (image: Image?, label: Text, value: Text)
    
    @Environment(\.valueRowProperties) private var properties
    @Environment(\.valueRowActions) private var actions
    
    private let components: Components
    
    public init(label: Text, image: Image? = nil, value: Text) {
        components = Components(image: image, label: label, value: value)
    }

    public var body: some View {
        Label(title: titleView, icon: imageView)
    }
    
    private func titleView() -> some View {
        HStack(alignment: .firstTextBaseline, spacing: 8) {
            components.label
                .font(properties.label.font)
                .foregroundColor(properties.label.foreground)
                .lineLimit(properties.label.lineLimit)
                .gesture(actions.onLabelTap)
                .gesture(actions.onLabelPress)
            Spacer(minLength: 0)
            components.value
                .font(properties.value.font)
                .foregroundColor(properties.value.foreground)
                .lineLimit(properties.value.lineLimit)
                .multilineTextAlignment(.trailing)
                .gesture(actions.onValueTap)
                .gesture(actions.onValuePress)
        }
    }
    
    private func imageView() -> some View {
        components.image
            .foregroundColor(properties.image.foreground)
            .font(properties.image.font)
            .imageScale(properties.image.scale)
            .gesture(actions.onImageTap)
            .gesture(actions.onImagePress)
    }
}


// MARK: - Constructor

extension ValueRow {
    
    public init(_ label: LocalizedStringKey, image: Image? = nil, value: LocalizedStringKey) {
        self.init(label: Text(label), image: image, value: Text(value))
    }
    
    public init(_ label: LocalizedStringKey, image: Image? = nil, value: String) {
        self.init(label: Text(label), image: image, value: Text(value))
    }
    
    public init(_ label: String, image: Image? = nil, value: String) {
        self.init(label: Text(label), image: image, value: Text(value))
    }
    
    public init(_ label: LocalizedStringKey, symbol: String, value: LocalizedStringKey) {
        self.init(label: Text(label), image: Image(systemName: symbol), value: Text(value))
    }
    
    public init(_ label: LocalizedStringKey, symbol: String, value: String) {
        self.init(label: Text(label), image: Image(systemName: symbol), value: Text(value))
    }
    
    public init(_ label: String, symbol: String, value: String) {
        self.init(label: Text(label), image: Image(systemName: symbol), value: Text(value))
    }
}


// MARK: - Preview

struct ValueRow_Preview: PreviewProvider {
    static var previews: some View {
        Form {
            Section {
                ValueRow("LocalizedKey", image: Image(systemName: "photo"), value: "LocalizedKey")
                ValueRow("LocalizedKey", symbol: "person", value: String("String"))
                ValueRow(String("String"), symbol: "person.3", value: String("String"))
            }
            Section {
                ValueRow("LocalizedKey", image: nil, value: "LocalizedKey")
                ValueRow("LocalizedKey", image: nil, value: String("String"))
                ValueRow(String("String"), image: nil, value: String("String"))
            }
            Section {
                ValueRow("Label", image: nil, value: "Value\ncontinue on line 2\n and more on 3")
                ValueRow("Label", symbol: "photo", value: "Value\ncontinue on line 2\n and more on 3")
            }
        }
    }
}
