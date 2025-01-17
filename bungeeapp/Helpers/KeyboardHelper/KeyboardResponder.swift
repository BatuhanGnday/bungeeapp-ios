//
//  KeyboardResponde.swift
//  bungeeapp
//
//  Created by Batuhan Günday on 6.06.2020.
//  Copyright © 2020 Bungee Inc. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class KeyboardObserver: ObservableObject {

  private var cancellable: AnyCancellable?

  @Published private(set) var keyboardHeight: CGFloat = 0

  let keyboardWillShow = NotificationCenter.default
    .publisher(for: UIResponder.keyboardWillShowNotification)
    .compactMap { ($0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height }

  let keyboardWillHide = NotificationCenter.default
    .publisher(for: UIResponder.keyboardWillHideNotification)
    .map { _ -> CGFloat in 0 }

  init() {
    cancellable = Publishers.Merge(keyboardWillShow, keyboardWillHide)
      .subscribe(on: RunLoop.main)
      .assign(to: \.keyboardHeight, on: self)
  }
}

