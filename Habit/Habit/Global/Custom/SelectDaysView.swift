//
//  SelectDaysView.swift
//  Habit
//
//  Created by hansol on 2021/11/29.
//

import UIKit

import SnapKit
import Then

// MARK: - SelectDaysView

final class SelectDaysView: UIView {
    
    // MARK: - Lazy Components
    
    private lazy var daysTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isScrollEnabled = false
        tableView.backgroundColor = .clear
        
        return tableView
    }()
    
    // MARK: - Variables
    
    var days: [(Days, Bool)] =
    [
        (.MONDAY, false),
        (.TUESDAY, false),
        (.WEDNESDAY, false),
        (.THURSDAY, false),
        (.FRIDAY, false),
        (.SATURDAY, false),
        (.SUNDAY, false)
    ]
    
    var rootViewController: UIViewController?
    
    // MARK: - LifeCycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        register()
        configDelegate()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

extension SelectDaysView {
    
    // MARK: - Layout Helpers
    
    private func layout() {
        self.backgroundColor = .clear
        self.add(daysTableView)
        
        daysTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(350.adjusted)
        }
    }
    
    // MARK: - General Helpers
    
    private func register() {
        daysTableView.register(DaysTableViewCell.self, forCellReuseIdentifier: DaysTableViewCell.identifier)
    }
    
    private func configDelegate() {
        daysTableView.delegate = self
        daysTableView.dataSource = self
    }
}

// MARK: - UITableViewDelegate

extension SelectDaysView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.adjusted
    }
}

// MARK: - UITableViewDataSource

extension SelectDaysView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return days.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let dayCell = tableView.dequeueReusableCell(
            withIdentifier: DaysTableViewCell.identifier, for: indexPath)
                as? DaysTableViewCell else { return UITableViewCell() }
        
        dayCell.dataBind(title: "\(days[indexPath.row].0.stringValue)요일", isSelect: days[indexPath.row].1)
        return dayCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        days[indexPath.row].1.toggle()
        daysTableView.reloadData()
        if days[indexPath.row].1 {
            if let rootVC = rootViewController as? AddHabitSecondViewController {
                rootVC.habitModel.days.append(days[indexPath.row].0)
                rootVC.reloadCollectionView()
            }
        }
    }
}
