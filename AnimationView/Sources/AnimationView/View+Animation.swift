//
//  File.swift
//  
//
//  Copyright (c) 2016 kt corp. All rights reserved.
//  This is a proprietary software of kt corp, and you may not use this file
//  except in compliance with license agreement with kt corp. Any redistribution
//  or use of this software, with or without modification shall be strictly
//  prohibited without prior written approval of kt corp, and the copyright
//  notice above does not evidence any actual or intended publication of such
//  software.
//

import SwiftUI

public extension View {
    /// animate view's visible
    /// - Parameters:
    ///  - visible: view's visible condition
    @ViewBuilder
    func animateVisible(visible: Bool) -> some View {
        AnimateVisibleView(content: {
            self
        }, visible: visible)
    }
}


public extension View {
    /// Adds an animated shimmering effect to any view, typically to show that
    /// an operation is in progress.
    /// - Parameters:
    ///   - active: Convenience parameter to conditionally enable the effect. Defaults to `true`.
    ///   - duration: The duration of a shimmer cycle in seconds. Default: `1.5`.
    ///   - bounce: Whether to bounce (reverse) the animation back and forth. Defaults to `false`.
    ///   - delay:A delay in seconds. Defaults to `0`.
    @ViewBuilder func shimmering(
        active: Bool = true, duration: Double = 1.5, bounce: Bool = false, delay: Double = 0
    ) -> some View {
        if active {
            modifier(ShimmerModifier(duration: duration, bounce: bounce, delay: delay))
        } else {
            self
        }
    }

    /// Adds an animated shimmering effect to any view, typically to show that
    /// an operation is in progress.
    /// - Parameters:
    ///   - active: Convenience parameter to conditionally enable the effect. Defaults to `true`.
    ///   - animation: A custom animation. The default animation is
    ///   `.linear(duration: 1.5).repeatForever(autoreverses: false)`.
    @ViewBuilder func shimmering(active: Bool = true, animation: Animation = ShimmerModifier.defaultAnimation) -> some View {
        if active {
            modifier(ShimmerModifier(animation: animation))
        } else {
            self
        }
    }
}
