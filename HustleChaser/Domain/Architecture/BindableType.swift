//
//  BindableType.swift
//  HustleChaser
//
//  Created by Hoang Linh Nguyen on 24/10/2023.
//
import UIKit
import RxSwift

public protocol BindableType: AnyObject {
    associatedtype ViewModelType

    var viewModel: ViewModelType! { get set }

    func bindViewModel()
}

extension BindableType where Self: UIViewController {
    public func bindViewModel(to model: Self.ViewModelType) {
        viewModel = model
        loadViewIfNeeded()
        bindViewModel()
    }
}
