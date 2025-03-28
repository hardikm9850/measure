//
//  LifecycleManager.swift
//  MeasureSDK
//
//  Created by Adwin Ross on 27/10/24.
//

import Foundation
import UIKit

@objc(LifecycleManagerInternal)
final class LifecycleManager: NSObject {
    @objc static let shared = LifecycleManager()
    private var lifecycleCollector: LifecycleCollector?

    private override init() {}

    func setLifecycleCollector(_ collector: LifecycleCollector) {
        self.lifecycleCollector = collector
    }

    @objc func sendLifecycleEvent(_ event: VCLifecycleEventType, for viewController: UIViewController) {
        guard let lifecycleCollector = self.lifecycleCollector else {
            return
        }
        lifecycleCollector.processControllerLifecycleEvent(event, for: viewController)
    }

    func sendSwiftUILifecycleEvent(_ event: SwiftUILifecycleType, for viewName: String) {
        lifecycleCollector?.processSwiftUILifecycleEvent(event, for: viewName)
    }
}
