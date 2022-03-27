import SwiftUI


/// A value row for list which contains an image, a leading label, and a trailing value.
///
/// Customization methods:
/// - ``withContent(alignment:)``
/// - ``withImage(foreground:)``
/// - ``withLabel(font:)``
/// - ``withValue(action:)``
///
public struct ValueRow: View {
    
    private var components = Components()
    private var properties = Properties()
    private var actions = Actions()
        
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
        components = Components(image: image, label: label, value: value)
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


// MARK: - Setter

extension ValueRow {
    
    private func withKeyPath<T>(_ path: WritableKeyPath<ValueRow, T>, _ value: T) -> ValueRow {
        var current = self
        current[keyPath: path] = value
        return current
    }
    
    public func withProperties<T>(_ path: WritableKeyPath<Properties, T>, _ value: T) -> ValueRow {
        withKeyPath((\Self.properties).appending(path: path), value)
    }
    
    public func withActions<T>(_ path: WritableKeyPath<Actions, T>, _ value: T) -> ValueRow {
        withKeyPath((\Self.actions).appending(path: path), value)
    }
}


// MARK: - Convenient Setter

extension ValueRow {
    
    // MARK: Content
    
    public func withContent(alignment: VerticalAlignment) -> ValueRow {
        withProperties(\.content.alignment, alignment)
    }
    
    public func withContent(spacing: CGFloat?) -> ValueRow {
        withProperties(\.content.spacing, spacing)
    }
    
    // MARK: Image
    
    public func withImage(font: Font?) -> ValueRow {
        withProperties(\.image.font, font)
    }
    
    public func withImage(scale: Image.Scale) -> ValueRow {
        withProperties(\.image.scale, scale)
    }
    
    public func withImage(foreground: Color) -> ValueRow {
        withProperties(\.image.foreground, foreground)
    }
    
    // MARK: Label
    
    public func withLabel(font: Font?) -> ValueRow {
        withProperties(\.label.font, font)
    }
    
    public func withLabel(foreground: Color) -> ValueRow {
        withProperties(\.label.foreground, foreground)
    }
    
    public func withLabel(lineLimit: Int?) -> ValueRow {
        withProperties(\.label.lineLimit, lineLimit)
    }
    
    // MARK: Value
    
    public func withValue(font: Font?) -> ValueRow {
        withProperties(\.value.font, font)
    }
    
    public func withValue(foreground: Color) -> ValueRow {
        withProperties(\.value.foreground, foreground)
    }
    
    public func withValue(lineLimit: Int?) -> ValueRow {
        withProperties(\.value.lineLimit, lineLimit)
    }
    
    // MARK: Action
    
    public func withImage(action: ActionType?) -> ValueRow {
        withActions(\.image, action)
    }
    
    public func withLabel(action: ActionType?) -> ValueRow {
        withActions(\.label, action)
    }
    
    public func withValue(action: ActionType?) -> ValueRow {
        withActions(\.value, action)
    }
}


extension ValueRow {
    
    // MARK: Components
 
    private struct Components {
        var image: Image?
        var label: Text?
        var value: Text?
    }
    
    // MARK: Properties

    public struct Properties {
        public var content = ContentProperties()
        public var image = ImageProperties()
        public var label = LabelProperties()
        public var value = ValueProperties()
        public init() {}
    }

    public struct ContentProperties {
        public var alignment: VerticalAlignment = .center
        public var spacing: CGFloat?
        public init() {}
    }

    public struct ImageProperties {
        public var font: Font?
        public var scale: Image.Scale = .medium
        public var foreground: Color = .accentColor
        public init() {}
    }

    public struct LabelProperties {
        public var font: Font?
        public var foreground: Color = .primary
        public var lineLimit: Int?
        public init() {}
    }

    public struct ValueProperties {
        public var font: Font?
        public var foreground: Color = .secondary
        public var lineLimit: Int?
        public init() {}
    }
    
    // MARK: Actions

    public struct Actions {
        var image: ActionType?
        var label: ActionType?
        var value: ActionType?
    }
    
    // MARK: ActionType
    
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

fileprivate extension View {
    
    @ViewBuilder func gesture(_ type: ValueRow.ActionType?) -> some View {
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
