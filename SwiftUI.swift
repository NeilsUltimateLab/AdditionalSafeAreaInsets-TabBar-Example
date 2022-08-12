import SwiftUI

struct ToSwiftUI: UIViewControllerRepresentable {
    var viewController: ()->UIViewController
    
    init(_  viewController: @escaping @autoclosure ()->UIViewController) {
        self.viewController = viewController
    }
    
    func makeUIViewController(context: Context) -> UIViewController {
        viewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
}

extension UIViewController {
    var toSwiftUI: ToSwiftUI {
        ToSwiftUI(self)
    }
}

struct ToSwiftUIView: UIViewRepresentable {
    let view: ()->UIView
    init(_ view: @escaping @autoclosure ()->UIView) {
        self.view = view
    } 
    
    func makeUIView(context: Context) -> UIView {
        view()
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
}

extension UIView {
    var toSwiftUI: ToSwiftUIView {
        ToSwiftUIView(self)
    }
}


