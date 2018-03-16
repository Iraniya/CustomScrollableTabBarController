//
//  CustomeSwipableTabBarController.swift
//  CustomModules
//
//  Created by Iraniya Naynesh on 15/03/18.
//  Copyright © 2018 Iraniya Naynesh. All rights reserved.
//

import UIKit

public enum SwipeTabError: Error {
    case viewControllerOutOfBounds
}

public enum SwipeDirection {
    case left
    case right
    case none
}

public enum SwipeTabBehaviour {
    
    case common(skipIntermediateViewControllers: Bool)
    case progressive(skipIntermediateViewControllers: Bool, elasticIndicatorLimit: Bool)
    
    public var skipIntermediateViewControllers: Bool {
        switch self {
        case .common(let skipIntermediateViewControllers):
            return skipIntermediateViewControllers
        case .progressive(let skipIntermediateViewControllers, _):
            return skipIntermediateViewControllers
        }
    }
    
    public var isProgressiveIndicator: Bool {
        switch self {
        case .common:
            return false
        case .progressive:
            return true
        }
    }
    
    public var isElasticIndicatorLimit: Bool {
        switch self {
        case .common:
            return false
        case .progressive(_, let elasticIndicatorLimit):
            return elasticIndicatorLimit
        }
    }
}

// ------------------------------------- Indicator Infor Started ----------------------- //

public struct IndicatorInfo {
    
    public var title: String?
    public var image: UIImage?
    public var highlightedImage: UIImage?
    public var userInfo: Any?
    
    public init(title: String?) {
        self.title = title
    }
    
    public init(image: UIImage?, highlightedImage: UIImage? = nil, userInfo: Any? = nil) {
        self.image = image
        self.highlightedImage = highlightedImage
    }
    
    public init(title: String?, image: UIImage?, highlightedImage: UIImage? = nil, userInfo: Any? = nil) {
        self.title = title
        self.image = image
        self.highlightedImage = highlightedImage
    }
}

extension IndicatorInfo : ExpressibleByStringLiteral {
    
    public init(stringLiteral value: String) {
        title = value
    }
    
    public init(extendedGraphemeClusterLiteral value: String) {
        title = value
    }
    
    public init(unicodeScalarLiteral value: String) {
        title = value
    }
}

// ------------------------------------- Indicator Infor Ended ----------------------- //

public protocol IndicatorInfoProvider {
    func indicatorInfo(for swipeTabController: SwipableTabController) -> IndicatorInfo
}

public protocol SwipeTabDelegate: class {
    func updateIndicator(for viewController: SwipableTabController, fromIndex: Int, toIndex: Int)
}

public protocol SwipeTabIsProgressiveDelegate: SwipableTabDelegate {
    
    func updateIndicator(for viewController: SwipableTabController, fromIndex: Int, toIndex: Int, withProgressPercentage progressPercentage: CGFloat, indexWasChanged: Bool)
}


public protocol SwipableTabDelegate: class {
    
    func updateIndicator(for viewController: SwipableTabController, fromIndex: Int, toIndex: Int)
}

public protocol SwipableTabDatasource: class {
     func viewControllers(for swipeTabController: SwipableTabController) -> [UIViewController]
}

open class SwipableTabController: UIViewController, UIScrollViewDelegate  {
    
    @IBOutlet weak var containerView: UIScrollView!
    
    open weak var delegate: SwipableTabDelegate?
    open weak var datasource: SwipableTabDatasource?
    
    @IBOutlet weak var tabView: UITabBarController!
    
    open var pagerBehaviour =  SwipeTabBehaviour.progressive(skipIntermediateViewControllers: true, elasticIndicatorLimit: true)
    
    open private(set) var viewControllers = [UIViewController]()
    open private(set) var currentIndex = 0
    open private(set) var preCurrentIndex = 0
    
    open var pageWidth: CGFloat {
        return containerView.bounds.width
    }
    
}


