import UIKit

class AppNavigationController: UINavigationController {
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        (self.tabBarController as? TabBarVC)?.pushViewController(viewController, animated: animated)
        super.pushViewController(viewController, animated: true)
    }
    
    override func popViewController(animated: Bool) -> UIViewController? {
        let controller = super.popViewController(animated: animated)
        (self.tabBarController as? TabBarVC)?.popViewController(controller, animated: animated)
        return controller
    }
}

