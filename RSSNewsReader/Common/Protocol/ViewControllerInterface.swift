//
//  ViewControllerInterface.swift
//  RSSNewsReader
//
//  Created by 이승준 on 2018. 7. 10..
//  Copyright © 2018년 seungjun. All rights reserved.
//

import Cocoa

protocol ViewControllerInterface {
    // Empty
}

extension ViewControllerInterface where Self: NSViewController {
    static func instance() -> Self {
        fatalError("You must override and implement this method")
    }
    
    static func instance(storyboardName: String, identifier: String) -> Self {
        let storyboard = NSStoryboard(name: NSStoryboard.Name(storyboardName), bundle: nil)
        let vc = storyboard.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(identifier))
        
        guard let viewController = vc as? Self else {
            fatalError("Check your storyboad name and identifier. that is not matched to \(self)")
        }
        
        return viewController
    }
}
