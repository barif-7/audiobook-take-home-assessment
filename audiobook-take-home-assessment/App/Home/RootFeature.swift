//
//  RootFeature.swift
//  audiobook-take-home-assessment
//
//  Created by Basil Arif on 2025-11-26.
//

import UIKit

// A simple abstraction for features that can produce a root view controller.
protocol RootFeature {
    func make() -> UIViewController
}
