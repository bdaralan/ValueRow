//
//  File.swift
//  
//
//  Created by Dara Beng on 1/24/23.
//

import SwiftUI

extension View {
    
    @ViewBuilder func gesture(_ type: ValueRowActionType?) -> some View {
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
