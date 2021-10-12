import UIKit
import WebKit

protocol LaunchPreviewView: AnyObject {
    func configure(with viewModel: LaunchPreviewViewModel)
}

final class LaunchPreviewViewController: UIViewController, LaunchPreviewView {
    var presenter: LaunchPreviewPresenter!
    
    private lazy var webView: WKWebView = {
        let webView = WKWebView(frame: .zero)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.navigationDelegate = self
        return webView
    }()
    
    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView(style: .large)
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.color = .themeColor
        activityIndicatorView.transform = CGAffineTransform(scaleX: 1.75, y: 1.75)
        return activityIndicatorView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .backgroundColor
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .automatic
        
        view.addSubview(webView)
        view.addSubview(activityIndicatorView)
        
        setupConstraints()
        
        presenter.present()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            webView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    func configure(with viewModel: LaunchPreviewViewModel) {
        title = viewModel.launch.name
        activityIndicatorView.startAnimating()
        guard let request = viewModel.webViewRequest else { return }
        webView.load(request)
    }
}

extension LaunchPreviewViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicatorView.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        activityIndicatorView.stopAnimating()
    }
}
