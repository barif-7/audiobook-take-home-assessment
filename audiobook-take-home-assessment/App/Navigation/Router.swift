//
//  Router.swift
//  audiobook-take-home-assessment
//
//  Created by Basil Arif on 2025-11-26.
//

import UIKit

public protocol Router: AnyObject {
    var navigationController: UINavigationController? { get }
    
    func push(_ viewController: UIViewController, animated: Bool)
}
