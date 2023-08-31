//
//  MainQueue.swift
//  MapX
//
//  Created by Tokyo on 01/09/23.
//

import Foundation

func onMainQueue(_ action: @escaping () -> Void) {
    DispatchQueue.main.async {
        action()
    }
}
