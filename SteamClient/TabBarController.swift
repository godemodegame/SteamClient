import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let profileViewController = ProfileViewController()
        profileViewController.tabBarItem.title = "Profile"
        profileViewController.tabBarItem.image = UIImage(named: "black")
        
        let friendsViewController = FriendsViewController()
        friendsViewController.tabBarItem.title = "Friends"
        friendsViewController.tabBarItem.image = UIImage(named: "users")
        
        let recentlyPlayedViewController = RecentlyPlayedViewController()
        recentlyPlayedViewController.title = "Recently Played"
        recentlyPlayedViewController.tabBarItem.image = UIImage(named: "time")
        
        self.viewControllers = [UINavigationController(rootViewController: profileViewController),
                                UINavigationController(rootViewController: friendsViewController),
                                UINavigationController(rootViewController: recentlyPlayedViewController)]
        
        self.view.tintColor = .red
    }
}
