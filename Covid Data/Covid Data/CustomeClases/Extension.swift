//
//  Extension.swift
//  Covid Data
//
//  Created by Achyuth Bujjigadu  on 10/09/21.
//

import Foundation
import NVActivityIndicatorView
import UIKit

extension UIViewController: NVActivityIndicatorViewable {
    func btnTappedBack(viewController: Swift.AnyClass) {
        guard let navigationViews = navigationController?.viewControllers else { return }
        for controller in navigationViews as Array {
            if controller.isKind(of: viewController) {
                navigationController?.popToViewController(controller, animated: true)
                break
            }
        }
    }

    func startPreloader() {
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(ActivityData(type: NVActivityIndicatorType.lineScalePulseOut), NVActivityIndicatorView.DEFAULT_FADE_IN_ANIMATION)
    }

    func stopPreloder() {
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating(NVActivityIndicatorView.DEFAULT_FADE_OUT_ANIMATION)
    }

    func showPreloaderMsg(msg: String) {
        NVActivityIndicatorPresenter.sharedInstance.setMessage(msg)
    }
}
