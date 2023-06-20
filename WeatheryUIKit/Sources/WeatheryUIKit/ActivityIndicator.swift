//
//  ActivityIndicator.swift
//  WeatheryUIKit
//
//  Created by Phu Phong Ngo on 5/6/2023.
//

import SwiftUI
import UIKit

public struct ActivityIndicator: UIViewRepresentable {
    @Binding var isAnimating: Bool
    let style: UIActivityIndicatorView.Style

    public func makeUIView(context: Context) -> some UIView {
        return UIActivityIndicatorView(style: style)
    }

    public func updateUIView(_ uiView: UIViewType, context: Context) {
        guard let indicatorView = uiView as? UIActivityIndicatorView else { return }
        isAnimating ? indicatorView.startAnimating() : indicatorView.stopAnimating()
    }
}
