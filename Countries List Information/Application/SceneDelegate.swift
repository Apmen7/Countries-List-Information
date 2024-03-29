import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else {
            return
        }

        let viewController = CountriesListView()
        let dataManager = APIManager()
        let presenter = CountriesListPresenter(view: viewController, apiManager: dataManager)
        viewController.presenter = presenter

        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = UINavigationController(rootViewController: viewController)
        self.window = window
        window.makeKeyAndVisible()
    }
}
