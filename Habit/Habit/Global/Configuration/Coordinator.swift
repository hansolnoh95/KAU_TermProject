//
//  Coordinator.swift
//  Finut
//
//  Created by 노한솔 on 2021/09/06.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

}
