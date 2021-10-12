import UIKit

protocol HomeView: AnyObject {
    func startAnimating()
    func stopAnimating()
    func setViewModels(_ viewModels: [HomeViewModel])
}

final class HomeViewController: UIViewController, HomeView {
    private struct Constants {
        static let title = "Launches"
        static let estimatedRowHeight: CGFloat = 70.0
    }
    
    var presenter: HomePresenter!
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: .zero, style: .insetGrouped)
        tableView.estimatedRowHeight = Constants.estimatedRowHeight
        tableView.rowHeight = 64.0
        tableView.separatorStyle = .singleLine
        tableView.alwaysBounceVertical = true
        tableView.keyboardDismissMode = .onDrag
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(HomeTableViewCell.self,forCellReuseIdentifier: HomeTableViewCell.nameOfClass)
        tableView.refreshControl = refreshControl
        return tableView
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshWeatherData(_:)), for: .valueChanged)
        refreshControl.tintColor = .themeColor
        let attributedStringColor = [NSAttributedString.Key.foregroundColor: UIColor.themeColor]
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching New Launches", attributes: attributedStringColor)
        return refreshControl
    }()
    
    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView(style: .large)
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.color = .themeColor
        activityIndicatorView.transform = CGAffineTransform(scaleX: 1.75, y: 1.75)
        return activityIndicatorView
    }()
    
    private var viewModels: [HomeViewModel] = []

    private var menuItems: [UIAction] {
        return [
            UIAction(title: "Default", image: UIImage(systemName: "checklist"), handler: { (_) in
                self.presenter.set(sortedBy: .default)
            }),
            UIAction(title: "Successful only", image: UIImage(systemName: "checklist.rtl"), handler: { (_) in
                self.presenter.set(sortedBy: .successLaunches)
            })
        ]
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        view.backgroundColor = .backgroundColor
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .automatic
        
        let sortingMenu = UIMenu(title: "Sort launches by:", options: [], children: menuItems)
        let sortMenuBarButtonItem = UIBarButtonItem(title: nil,
                                                    image: UIImage(systemName: "line.horizontal.3.decrease.circle"),
                                                    primaryAction: nil, menu: sortingMenu)
        navigationItem.setRightBarButton(sortMenuBarButtonItem, animated: true)
        
        title = Constants.title
        
        view.addSubview(tableView)
        view.addSubview(activityIndicatorView)
        
        setupConstraints()
    
        presenter.present()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
    
    func startAnimating() {
        tableView.isHidden = true
        activityIndicatorView.startAnimating()
    }
    
    func stopAnimating() {
        tableView.isHidden = false
        activityIndicatorView.stopAnimating()
        refreshControl.endRefreshing()
    }
    
    func setViewModels(_ viewModels: [HomeViewModel]) {
        self.viewModels = viewModels
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }
    
    @objc private func refreshWeatherData(_ sender: UIRefreshControl) {
        presenter.present()
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.nameOfClass, for: indexPath) as! HomeTableViewCell
        let viewModel = viewModels[indexPath.row]
        cell.configure(with: viewModel)
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.onPreviewTapped(with: viewModels[indexPath.row].launch)
    }
}
