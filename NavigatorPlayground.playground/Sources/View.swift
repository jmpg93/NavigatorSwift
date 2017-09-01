import Foundation
import UIKit

public protocol View {
	func apply(transition: Transition)
}

extension UIViewController: View {
	public func apply(transition: Transition) {
		
	}
}
