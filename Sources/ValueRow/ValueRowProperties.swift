//
//  File.swift
//  
//
//  Created by Dara Beng on 1/23/23.
//

import SwiftUI

struct ValueRowProperties {
    
    var image = Image()
    var label = Label()
    var value = Value()

    struct Image {
        public var font: Font?
        public var scale: SwiftUI.Image.Scale = .medium
        public var foreground: Color = .accentColor
    }

    struct Label {
        public var font: Font?
        public var foreground: Color = .primary
        public var lineLimit: Int?
    }

    struct Value {
        public var font: Font?
        public var foreground: Color = .secondary
        public var lineLimit: Int?
    }
}

// MARK: - EnvironmentValues

extension EnvironmentValues {
    
    enum ValueRowPropertiesKey: EnvironmentKey {
        static let defaultValue = ValueRowProperties()
    }
    
    var valueRowProperties: ValueRowProperties {
        get { self[ValueRowPropertiesKey.self] }
        set { self[ValueRowPropertiesKey.self] = newValue }
    }
}

// MARK: - View Extension

extension View {
    
    fileprivate var defaults: ValueRowProperties { EnvironmentValues.ValueRowPropertiesKey.defaultValue }
    
    // MARK: Image
    
    public func withVRImageFont(_ value: Font?) -> some View {
        environment(\.valueRowProperties.image.font, value)
    }
    
    public func withVRImageForeground(_ value: Color?) -> some View {
        environment(\.valueRowProperties.image.foreground, value ?? defaults.image.foreground)
    }
    
    public func withVRImageScale(_ value: Image.Scale) -> some View {
        environment(\.valueRowProperties.image.scale, value)
    }
    
    // MARK: Label
    
    public func withVRLabelFont(_ value: Font?) -> some View {
        environment(\.valueRowProperties.label.font, value)
    }
    
    public func withVRLabelForeground(_ value: Color?) -> some View {
        environment(\.valueRowProperties.label.foreground, value ?? defaults.label.foreground)
    }
    
    public func withVRLabelLineLimit(_ value: Int?) -> some View {
        environment(\.valueRowProperties.label.lineLimit, value)
    }
    
    // MARK: Value
    
    public func withVRValueFont(_ value: Font?) -> some View {
        environment(\.valueRowProperties.value.font, value)
    }
    
    public func withVRValueForeground(_ value: Color?) -> some View {
        environment(\.valueRowProperties.value.foreground, value ?? defaults.value.foreground)
    }
    
    public func withVRValueLineLimit(_ value: Int?) -> some View {
        environment(\.valueRowProperties.value.lineLimit, value)
    }
}
