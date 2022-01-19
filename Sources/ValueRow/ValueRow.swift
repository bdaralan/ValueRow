import SwiftUI


/// A value row for list which contains an image, a leading label, and a trailing value.
///
/// Customization methods:
/// - ``withProperties(_:)``
/// - ``withContent(alignment:)``
/// - ``withImage(foreground:)``
/// - ``withLabel(font:)``
/// - ``withValue(action:)``
///
public struct ValueRow: View {
    
    private var components = ValueRowComponents()
    
    private var properties = ValueRowProperties()
    
    private var actions = ValueRowActions()
        
    public var body: some View {
        Label(title: titleView, icon: imageView)
    }
    
    private func titleView() -> some View {
        HStack(alignment: properties.content.alignment, spacing: 0) {
            components.label
                .font(properties.label.font)
                .foregroundColor(properties.label.foreground)
                .lineLimit(properties.label.lineLimit)
                .gesture(actions.label)
            Spacer(minLength: properties.content.spacing)
            components.value
                .font(properties.value.font)
                .foregroundColor(properties.value.foreground)
                .lineLimit(properties.value.lineLimit)
                .multilineTextAlignment(.trailing)
                .gesture(actions.value)
        }
    }
    
    private func imageView() -> some View {
        components.image
            .foregroundColor(properties.image.foreground)
            .font(properties.image.font)
            .imageScale(properties.image.scale)
            .gesture(actions.image)
    }
}


// MARK: - Constructor

extension ValueRow {
    
    public init(label: Text, image: Image? = nil, value: Text) {
        components.image = image
        components.label = label
        components.value = value
    }
    
    public init(_ label: LocalizedStringKey, image: Image? = nil, value: LocalizedStringKey) {
        self.init(label: Text(label), image: image, value: Text(value))
    }
    
    public init(_ label: LocalizedStringKey, image: Image? = nil, value: String) {
        self.init(label: Text(label), image: image, value: Text(value))
    }
    
    public init(_ label: LocalizedStringKey, symbol: String, value: LocalizedStringKey) {
        self.init(label: Text(label), image: Image(systemName: symbol), value: Text(value))
    }
    
    public init(_ label: LocalizedStringKey, symbol: String, value: String) {
        self.init(label: Text(label), image: Image(systemName: symbol), value: Text(value))
    }
}


// MARK: - Configuration

extension ValueRow {
    
    // MARK: Properties
    
    private func withProperties<T>(_ keyPath: WritableKeyPath<ValueRowProperties, T>, _ value: T) -> ValueRow {
        var current = self
        current.properties[keyPath: keyPath] = value
        return current
    }
    
    public func withProperties(_ properties: ValueRowProperties) -> ValueRow {
        withProperties(\.self, properties)
    }
    
    public func withContent(alignment: VerticalAlignment) -> ValueRow {
        withProperties(\.content.alignment, alignment)
    }
    
    public func withContent(spacing: CGFloat?) -> ValueRow {
        withProperties(\.content.spacing, spacing)
    }
    
    public func withImage(font: Font?) -> ValueRow {
        withProperties(\.image.font, font)
    }
    
    public func withImage(scale: Image.Scale) -> ValueRow {
        withProperties(\.image.scale, scale)
    }
    
    public func withImage(foreground: Color) -> ValueRow {
        withProperties(\.image.foreground, foreground)
    }
    
    public func withLabel(font: Font?) -> ValueRow {
        withProperties(\.label.font, font)
    }
    
    public func withLabel(foreground: Color) -> ValueRow {
        withProperties(\.label.foreground, foreground)
    }
    
    public func withLabel(lineLimit: Int?) -> ValueRow {
        withProperties(\.label.lineLimit, lineLimit)
    }
    
    public func withValue(font: Font?) -> ValueRow {
        withProperties(\.value.font, font)
    }
    
    public func withValue(foreground: Color) -> ValueRow {
        withProperties(\.value.foreground, foreground)
    }
    
    public func withValue(lineLimit: Int?) -> ValueRow {
        withProperties(\.value.lineLimit, lineLimit)
    }
    
    // MARK: Actions
    
    private func withActions<T>(_ keyPath: WritableKeyPath<ValueRowActions, T>, _ value: T) -> ValueRow {
        var current = self
        current.actions[keyPath: keyPath] = value
        return current
    }
    
    public func withImage(action: ValueRowActions.ActionType?) -> ValueRow {
        withActions(\.image, action)
    }
    
    public func withLabel(action: ValueRowActions.ActionType?) -> ValueRow {
        withActions(\.label, action)
    }
    
    public func withValue(action: ValueRowActions.ActionType?) -> ValueRow {
        withActions(\.value, action)
    }
}


// MARK: - ValueRowComponents

private struct ValueRowComponents {
    var image: Image?
    var label: Text?
    var value: Text?
}


// MARK: - ValueRowProperties

public struct ValueRowProperties {
    
    public var content = Content()
    public var image = Image()
    public var label = Label()
    public var value = Value()
    
    public init() {}
    
    public struct Content {
        public var alignment: VerticalAlignment = .center
        public var spacing: CGFloat?
    }

    public struct Image {
        public var font: Font?
        public var scale: SwiftUI.Image.Scale = .medium
        public var foreground: Color = .accentColor
    }

    public struct Label {
        public var font: Font?
        public var foreground: Color = .primary
        public var lineLimit: Int?
    }

    public struct Value {
        public var font: Font?
        public var foreground: Color = .secondary
        public var lineLimit: Int?
    }
}


// MARK: - ValueRowActions

public struct ValueRowActions {
    
    var image: ActionType?
    var label: ActionType?
    var value: ActionType?
    
    public enum ActionType {
        
        /// A tap action.
        ///
        /// - Parameters:
        ///   - count: The required number of tap events.
        ///   - action: The action to perform.
        case tap(count: Int = 1, action: () -> Void)
        
        /// A long press action.
        ///
        /// - Parameters:
        ///   - minDuration: The minimum duration of the long press that must elapse before the gesture succeeds.
        ///   - maxDistance: The maximum distance that the long press can move before the gesture fails.
        ///   - action: The action to perform.
        case press(minDuration: Double = 0.5, maxDistance: Double = 10, action: (LongPressGesture.Value) -> Void)
        
        /// A long press action.
        ///
        /// - Parameters:
        ///   - minDuration: The minimum duration of the long press that must elapse before the gesture succeeds.
        ///   - maxDistance: The maximum distance that the long press can move before the gesture fails.
        ///   - action: The action to perform.
        public static func press(minDuration: Double = 0.5, maxDistance: Double = 10, action: @escaping () -> Void) -> ActionType {
            .press(minDuration: minDuration, maxDistance: maxDistance, action: { _ in action() })
        }
    }
}


// MARK: - View Helper

private extension View {
    
    @ViewBuilder func gesture(_ type: ValueRowActions.ActionType?) -> some View {
        switch type {
        case nil:
            self
        case let .tap(count, action):
            self.gesture(TapGesture(count: count).onEnded(action))
        case let .press(duration, distance, action):
            self.gesture(LongPressGesture(minimumDuration: duration, maximumDistance: distance).onEnded(action))
        }
    }
}
