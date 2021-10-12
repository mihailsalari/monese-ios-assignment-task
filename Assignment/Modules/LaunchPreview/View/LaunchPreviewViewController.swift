import UIKit

protocol LaunchPreviewView: AnyObject {
    func configure(with viewModel: LaunchPreviewViewModel)
}

final class LaunchPreviewViewController: UIViewController, LaunchPreviewView {
    var presenter: LaunchPreviewPresenter!
    
    private lazy var textView: UITextView = {
        let textView = UITextView(frame: .zero)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .left
        textView.font = .systemFont(ofSize: 17, weight: .semibold)
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .backgroundColor
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .automatic
        
        view.addSubview(textView)
        setupConstraints()
        
        presenter.present()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            textView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20.0),
            textView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            textView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20.0)
        ])
    }
    
    func configure(with viewModel: LaunchPreviewViewModel) {
        title = viewModel.launch.name
        textView.text = viewModel.launch.details // TODO: do we need to show the wikipedia's article instead of webview?
    }
}
