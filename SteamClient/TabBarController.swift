import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let profileViewController = ProfileViewController()
        profileViewController.tabBarItem.title = "Profile"
        profileViewController.tabBarItem.image = UIImage(named: "user")
        
        let friendsViewController = FriendsViewController()
        friendsViewController.tabBarItem.title = "Friends"
        friendsViewController.tabBarItem.image = UIImage(named: "users")
        
        self.viewControllers = [UINavigationController(rootViewController: profileViewController),
                                UINavigationController(rootViewController: friendsViewController)]
        
        self.view.tintColor = .red
    }
}
