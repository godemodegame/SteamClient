import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let profileViewController = ProfileViewController()
        profileViewController.tabBarItem.title = "Profile"
        profileViewController.tabBarItem.image = UIImage(named: "User")
        
        self.viewControllers = [UINavigationController(rootViewController: profileViewController)]
        
        self.view.tintColor = .red
    }
}
