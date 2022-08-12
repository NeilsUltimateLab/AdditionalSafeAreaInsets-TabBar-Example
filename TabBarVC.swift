import UIKit

class TabBarVC: UITabBarController {
    
    private var bool = true
    
    private lazy var homeVC: UIViewController = {
        let vc = HomeVC(nibName: nil, bundle: nil)
        vc.tabBarItem = UITabBarItem(tabBarSystemItem: .topRated, tag: 0)
        return vc
    }()
    
    private lazy var settingsVC: UIViewController = {
        let vc = SettingsVC(nibName: nil, bundle: nil)
        vc.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 2)
        return vc
    }()
    
    private lazy var historyVC: UIViewController = {
        let vc = HistoryVC(nibName: nil, bundle: nil)
        vc.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 1)
        return vc
    }()
    
    private lazy var floatingView = CartFloatingView(frame: .zero)
    private var floatingHeightAnchor: NSLayoutConstraint!
    private var floatingBottonAnchor: NSLayoutConstraint!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        configureViewControllers()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureViewControllers()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureFloatingView()
    }
    
    private func configureViewControllers() {
        self.viewControllers = [
            AppNavigationController(rootViewController: homeVC),
            AppNavigationController(rootViewController: historyVC),
            AppNavigationController(rootViewController: settingsVC)
        ]
        self.delegate = self
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let height = self.floatingView.frame.height
        
        self.selectedViewController?.additionalSafeAreaInsets.bottom = height + 16
    }
    
    private func configureFloatingView() {
        floatingView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(floatingView)
        floatingView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16).isActive = true
        self.floatingBottonAnchor = floatingView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -16 - tabBar.frame.height)
        self.floatingBottonAnchor?.isActive = true
        floatingView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
        floatingView.configure(title: "Title", description: "Its very good\nIt's awesome that its working really good.", count: "z")
    }
    
    private func hidesFloatingView(_ reverse: Bool = false) {
        if reverse {
            self.floatingView.alpha = 1
            self.floatingView.transform = .identity
        } else {
            self.floatingView.transform = CGAffineTransform(translationX: -self.view.frame.width/1, y: 0)
            self.floatingView.alpha = 0.85
        }
    }
    
    func hidesFloatingView(_ reverse: Bool = false, animated: Bool) {
        guard animated else {
            self.hidesFloatingView(reverse)
            return
        }
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut) { 
            self.hidesFloatingView(reverse)
        }
    }
    
    func updatePosition(tabBarHiding: Bool) {
        let height: CGFloat = tabBarHiding ? 0 : (-16 - self.tabBar.frame.height + self.view.safeAreaInsets.bottom)
        self.floatingBottonAnchor.constant = height
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut) {
            self.view.layoutIfNeeded()
        }
    }
    
    func updateFloatingBarVisibility(_ visible: Bool, for viewController: UIViewController) {
        if visible {
            self.floatingView.alpha = 1
            let height = self.floatingView.frame.height
            viewController.additionalSafeAreaInsets.bottom = (-16 - 16 - height) * -1
        } else {
            self.floatingView.alpha = 0
            viewController.additionalSafeAreaInsets.bottom = 0
        }
    }
    
    func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if ((self.selectedViewController as? AppNavigationController)?.topViewController as? FloatingBarDisplaying)?.hidesFloatingBar ?? false {
            self.updateFloatingBarVisibility(false, for: viewController)
            return
        }
        if viewController.hidesBottomBarWhenPushed {
            if let coordinator = viewController.transitionCoordinator {
                coordinator.animate { context in
                    if (viewController as? FloatingBarDisplaying)?.hidesFloatingBar ?? false {
                        self.hidesFloatingView()
                    } else {
                        self.updatePosition(tabBarHiding: true)
                    }
                } completion: { context in
                    if context.isCancelled {
                        if (viewController as? FloatingBarDisplaying)?.hidesFloatingBar ?? false {
                            self.hidesFloatingView(false)
                        } else {
                            self.updatePosition(tabBarHiding: false)
                        }
                    }
                }
            } else {
                if (viewController as? FloatingBarDisplaying)?.hidesFloatingBar ?? false {
                    self.hidesFloatingView(animated: true)
                } else {
                    self.updatePosition(tabBarHiding: true)
                }
            }
            
        }
    }
    
    func popViewController(_ viewController: UIViewController?, animated: Bool) {
        if ((self.selectedViewController as? AppNavigationController)?.topViewController as? FloatingBarDisplaying)?.hidesFloatingBar ?? false {
            self.updateFloatingBarVisibility(false, for: viewController!)
            return
        }
        if viewController?.hidesBottomBarWhenPushed ?? false {
            if let coordinator = viewController?.transitionCoordinator {
                coordinator.animate { context in
                    if (viewController as? FloatingBarDisplaying)?.hidesFloatingBar ?? false {
                        self.hidesFloatingView(true)
                    } else {
                        self.updatePosition(tabBarHiding: false)
                    }
                } completion: { context in
                    if context.isCancelled {
                        if (viewController as? FloatingBarDisplaying)?.hidesFloatingBar ?? false {
                            self.hidesFloatingView(false)
                        } else {
                            self.updatePosition(tabBarHiding: true)
                        }
                    }
                }
            } else {
                if (viewController as? FloatingBarDisplaying)?.hidesFloatingBar ?? false {
                    self.hidesFloatingView(true)
                } else {
                    self.updatePosition(tabBarHiding: false)
                }
            }
        }
    }
}


extension TabBarVC: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if ((viewController as? AppNavigationController)?.topViewController as? FloatingBarDisplaying)?.hidesFloatingBar ?? false {
            self.updateFloatingBarVisibility(false, for: viewController)
        } else {
            self.updateFloatingBarVisibility(true, for: viewController)
        }
    }
}
