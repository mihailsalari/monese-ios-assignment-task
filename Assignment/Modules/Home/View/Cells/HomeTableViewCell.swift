import UIKit

final class HomeTableViewCell: UITableViewCell {
    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.sizeToFit()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        return label
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.sizeToFit()
        label.font = .systemFont(ofSize: 15, weight: .light)
        label.textAlignment = .right
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, timeLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 32.0
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .blue
        configureSubview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureSubview() {
        contentView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20.0),
            stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20)
        ])
    }
    
    func configure(with viewModel: HomeViewModel) {
        titleLabel.text = viewModel.name
        timeLabel.text = viewModel.simplifiedDate
    }
}
