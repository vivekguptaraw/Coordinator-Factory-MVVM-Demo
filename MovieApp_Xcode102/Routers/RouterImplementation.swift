//
//  RouterImplementation.swift
//  MovieApp_Xcode102
//
//  Created by Vivek Gupta on 08/03/20.
//  Copyright © 2020 Vivek Gupta. All rights reserved.
//

import UIKit

final class RouterImplementation: NSObject, Router {
    
    private weak var rootController: UINavigationController?
    private var completions: [UIViewController: () -> Void]
    
    init(root: UINavigationController?) {
        self.rootController = root
        self.completions = [:]
        super.init()
        self.rootController?.delegate = self
        
        self.rootController?.navigationBar.barStyle = .black
        self.rootController?.navigationBar.isTranslucent = true
        self.rootController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        self.rootController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 0.99997437, blue: 0.9999912977, alpha: 1)
    }
    
    func toPresent() -> UIViewController? {
        return rootController
    }
    
    func push(_ module: Presentable?) {
        self.push(module)
    }
    
    func push(_ module: Presentable?, animated: Bool)  {
        push(module, animated: animated, completion: nil)
    }
    
    func push(_ module: Presentable?, animated: Bool, completion: (() -> Void)?) {
        push(module, animated: animated, hideBottomBar: false, completion: completion)
    }
    
    func push(_ module: Presentable?, animated: Bool, hideBottomBar: Bool, completion: (() -> Void)?) {
        guard
            let controller = module?.toPresent(),
            (controller is UINavigationController == false)
            else { assertionFailure("Deprecated push UINavigationController."); return }
        
        if let completion = completion {
            completions[controller] = completion
        }
        controller.hidesBottomBarWhenPushed = hideBottomBar
        rootController?.pushViewController(controller, animated: animated)
    }
    
    func popModule() {
        self.popModule(animated: true)
    }
    
    func popModule(animated: Bool) {
        if let controllerToPop = self.rootController?.popViewController(animated: animated) {
            runCompletion(for: controllerToPop)
        }
    }
    
    func setRootModule(_ module: Presentable?) {
        self.setRootModule(module, hideBar: true)
    }
    
    func popToRootModule(animated: Bool) {
        if let controllers = rootController?.popToRootViewController(animated: animated) {
            controllers.forEach { controller in
                runCompletion(for: controller)
            }
        }
    }
    
    func setRootModule(_ module: Presentable?, hideBar: Bool) {
        guard let controller = module?.toPresent() else { return }
        rootController?.setViewControllers([controller], animated: false)
        rootController?.isNavigationBarHidden = hideBar
    }
    
    private func runCompletion(for controller: UIViewController) {
        guard let completion = completions[controller] else { return }
        completion()
        completions.removeValue(forKey: controller)
    }
}

extension RouterImplementation: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        
        guard let previousController = rootController?.transitionCoordinator?.viewController(forKey: .from),
            !navigationController.viewControllers.contains(previousController) else {
                return
        }
        runCompletion(for: previousController)
    }
}


