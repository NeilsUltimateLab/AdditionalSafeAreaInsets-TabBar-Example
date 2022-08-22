# AdditionalSafeAreaInsets-TabBar-Example
An use case of additional safe area insets. 


https://user-images.githubusercontent.com/23612211/185951604-aaf76e0f-a42f-4ac5-aa6c-82343a87656e.mov

## Key-classes
- FloatingBarDisplaying: UIViewController (protocol)
  - Provides a uniform way to provide floating-view visibility information for specific view controller.
- TabBarVC: UITabBarController
  - A sublcass of UITabBarController which 
    - adds `floatingView` above all child view-controllers.
    - Adjusts `additionalSafeAreaInsets` for selected child view-controller.
    - Updates `floatingView`'s visibility with respect to `viewController.hidesBottomBarWhenPushed` also with pop interactive animation (with help of `AppNavigationController`)
- AppNavigationController: UINavigationController
  - Provides a way to interact with navigationController's push and pop animation for `TabBarVC`.
