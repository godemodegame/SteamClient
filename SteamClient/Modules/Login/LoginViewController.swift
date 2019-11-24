import WebKit

protocol LoginViewProtocol: class {
    func loadWebView(request: URLRequest)
    func setButton()
}

class LoginViewController: UIViewController {
    
    var presenter: LoginPresenterProtocol!
    let configurator: LoginConfiguratorProtocol = LoginConfigurator()
    
    // MARK: Views
    
    private var webView: WKWebView!
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Cancel", for: .normal)
        button.sizeToFit()
        button.addTarget(self, action: #selector(self.cancelButtonTapped), for: .touchUpInside)
        button.setTitle("Cancel", for: .normal)
        return button
    }()
    
    // MARK: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter.configureView()
    }
    
    @objc private func cancelButtonTapped() {
        self.presenter.closeButtonClicked()
    }
    
    init(delegate: LoginDelegate?) {
        super.init(nibName: nil, bundle: nil)
        self.configurator.configure(with: self, delegate: delegate)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: -LoginViewProtocol

extension LoginViewController: LoginViewProtocol {
    func loadWebView(request: URLRequest) {
        self.webView = WKWebView(frame: .zero)
        self.view = self.webView
        self.webView.navigationDelegate = self
        self.webView.load(request)
    }
    
    func setButton() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: self.cancelButton)
    }
}

// MARK: -WKNavigationDelegate

extension LoginViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        guard let url = navigationAction.request.url else { return }
        let isSuccess = self.presenter.isFetched(url: url)

        if isSuccess {
            decisionHandler(.cancel)
        } else {
            decisionHandler(.allow)
        }
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.presenter.failConnection()
    }
}
