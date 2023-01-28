//
//  File.swift
//  
//
//  Created by Dara Beng on 1/23/23.
//

import SwiftUI

struct ValueRowActions {
    var onImageTap: ValueRowActionType?
    var onImagePress: ValueRowActionType?
    
    var onLabelTap: ValueRowActionType?
    var onLabelPress: ValueRowActionType?
    
    var onValueTap: ValueRowActionType?
    var onValuePress: ValueRowActionType?
}

// MARK: ActionType

enum ValueRowActionType {
    
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
}

// MARK: - EnvironmentValues

extension EnvironmentValues {
    
    enum ValueRowActionsKey: EnvironmentKey {
        static let defaultValue = ValueRowActions()
    }
    
    var valueRowActions: ValueRowActions {
        get { self[ValueRowActionsKey.self] }
        set { self[ValueRowActionsKey.self] = newValue }
    }
}

// MARK: - View Extension

extension View {
    
    public func onVRImageTap(count: Int = 1, action: @escaping () -> Void) -> some View {
        environment(\.valueRowActions.onImageTap, .tap(count: count, action: action))
    }
    
    public func onVRImagePress(minDuration: Double = 0.5, maxDistance: Double = 10, action: @escaping () -> Void) -> some View {
        environment(\.valueRowActions.onImagePress, .press(minDuration: minDuration, maxDistance: maxDistance, action: { _ in action() }))
    }
    
    public func onVRLabelTap(count: Int = 1, action: @escaping () -> Void) -> some View {
        environment(\.valueRowActions.onLabelTap, .tap(count: count, action: action))
    }
    
    public func onVRLabelPress(minDuration: Double = 0.5, maxDistance: Double = 10, action: @escaping () -> Void) -> some View {
        environment(\.valueRowActions.onLabelPress, .press(minDuration: minDuration, maxDistance: maxDistance, action: { _ in action() }))
    }
    
    public func onVRValueTap(count: Int = 1, action: @escaping () -> Void) -> some View {
        environment(\.valueRowActions.onValueTap, .tap(count: count, action: action))
    }
    
    public func onVRValuePress(minDuration: Double = 0.5, maxDistance: Double = 10, action: @escaping () -> Void) -> some View {
        environment(\.valueRowActions.onValuePress, .press(minDuration: minDuration, maxDistance: maxDistance, action: { _ in action() }))
    }
}
