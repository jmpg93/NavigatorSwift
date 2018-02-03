
import Foundation

public enum Level: Int {
	case disable = 0
	case fatal = 1
	case error = 2
	case warn = 3
	case info = 4
	case debug = 5
	case trace = 6
	case all = 7

	var label: String {
		switch self {
		case .trace: return "✏️"
		case .info:  return "🔍"
		case .debug: return "🐛"
		case .error: return "❌❌❌"
		case .fatal: return "☠️☠️☠️"
		case .warn:  return "⚠️⚠️⚠️"
		default: return ""
		}
	}
}

// MARK: Global functions

public let NavigatorLogger = Logger()

public func logFatal(_ items: Any..., separator: String? = nil, terminator: String? = nil, file: String = #file, line: Int = #line, column: Int = #column, function: String = #function) {
	NavigatorLogger.logFatal(items, separator: separator, terminator: terminator, file: file, line: line, column: column, function: function)
}

public func logError(_ items: Any..., separator: String? = nil, terminator: String? = nil, file: String = #file, line: Int = #line, column: Int = #column, function: String = #function) {
	NavigatorLogger.logError(items, separator: separator, terminator: terminator, file: file, line: line, column: column, function: function)
}

public func logWarning(_ items: Any..., separator: String? = nil, terminator: String? = nil, file: String = #file, line: Int = #line, column: Int = #column, function: String = #function) {
	NavigatorLogger.logWarning(items, separator: separator, terminator: terminator, file: file, line: line, column: column, function: function)
}

public func logInfo(_ items: Any..., separator: String? = nil, terminator: String? = nil, file: String = #file, line: Int = #line, column: Int = #column, function: String = #function) {
	NavigatorLogger.logInfo(items, separator: separator, terminator: terminator, file: file, line: line, column: column, function: function)
}

public func logDebug(_ items: Any..., separator: String? = nil, terminator: String? = nil, file: String = #file, line: Int = #line, column: Int = #column, function: String = #function) {
	NavigatorLogger.logDebug(items, separator: separator, terminator: terminator, file: file, line: line, column: column, function: function)
}

public func logTrace(_ items: Any..., separator: String? = nil, terminator: String? = nil, file: String = #file, line: Int = #line, column: Int = #column, function: String = #function) {
	NavigatorLogger.logTrace(items, separator: separator, terminator: terminator, file: file, line: line, column: column, function: function)
}

// MARK: Class definition

public class Logger {
	public var level: Level = .disable
	public let separator: String = " "
	public let terminator: String = "\n"
	private let mFormatter = DateFormatter(dateFormat: "HH:mm:ss.SSS")

	init() {

	}

	fileprivate func logFatal(_ items: [Any], separator: String? = nil, terminator: String? = nil, file: String = #file, line: Int = #line, column: Int = #column, function: String = #function) {
		if level < .fatal { return }
		log(.fatal, items: items, separator: separator, terminator: terminator, file: file, line: line, column: column, function: function)
	}

	fileprivate func logError(_ items: [Any], separator: String? = nil, terminator: String? = nil, file: String = #file, line: Int = #line, column: Int = #column, function: String = #function) {
		if level < .error { return }
		log(.error, items: items, separator: separator, terminator: terminator, file: file, line: line, column: column, function: function)
	}

	fileprivate func logWarning(_ items: [Any], separator: String? = nil, terminator: String? = nil, file: String = #file, line: Int = #line, column: Int = #column, function: String = #function) {
		if level < .warn { return }
		log(.warn, items: items, separator: separator, terminator: terminator, file: file, line: line, column: column, function: function)
	}

	fileprivate func logInfo(_ items: [Any], separator: String? = nil, terminator: String? = nil, file: String = #file, line: Int = #line, column: Int = #column, function: String = #function) {
		if level < .info { return }
		log(.info, items: items, separator: separator, terminator: terminator, file: file, line: line, column: column, function: function)
	}

	fileprivate func logDebug(_ items: [Any], separator: String? = nil, terminator: String? = nil, file: String = #file, line: Int = #line, column: Int = #column, function: String = #function) {
		if level < .debug { return }
		log(.debug, items: items, separator: separator, terminator: terminator, file: file, line: line, column: column, function: function)
	}

	fileprivate func logTrace(_ items: [Any], separator: String? = nil, terminator: String? = nil, file: String = #file, line: Int = #line, column: Int = #column, function: String = #function) {
		if level < .trace { return }
		log(.trace, items: items, separator: separator, terminator: terminator, file: file, line: line, column: column, function: function)
	}

	fileprivate func log(_ logLevel: Level, items: [Any], separator: String?, terminator: String?, file: String, line: Int, column: Int, function: String, date: Date = Date()) {
		let separator = separator ?? self.separator
		let terminator = terminator ?? self.terminator

		let message = buildMessageForLogLevel(items, separator: separator)

		let stringToPrint = stringForCurrentStyle(logLevel: logLevel, message: message, terminator: terminator, file: file, line: line, column: column, function: function, date: date)
		print(stringToPrint, terminator: terminator)
	}

	private func buildMessageForLogLevel(_ items: [Any], separator: String) -> String {
		var message = ""

		for (index, item) in items.enumerated() {
			message += String(describing: item) + (index == items.count-1 ? "" : separator)
		}

		return message
	}

	private func stringForCurrentStyle(logLevel: Level, message: String, terminator: String, file: String, line: Int, column: Int, function: String, date: Date) -> String {
		let level = "\(logLevel.label)"

		let stringDate = "\(mFormatter.string(from: date))"
		let stringLocation = "[\((file as NSString).lastPathComponent):L\(line)]"
		return "\(stringDate) ◉ \(level) \(message) \(stringLocation)"
	}
}

// MARK: Utils

extension Level: Comparable {}

public func <(a: Level, b: Level) -> Bool {
	return a.rawValue < b.rawValue
}

public func <=(a: Level, b: Level) -> Bool {
	return a.rawValue <= b.rawValue
}

public func >(a: Level, b: Level) -> Bool {
	return a.rawValue > b.rawValue
}

public func >=(a: Level, b: Level) -> Bool {
	return a.rawValue >= b.rawValue
}

private extension DateFormatter {
	convenience init(dateFormat: String) {
		self.init()
		self.dateFormat = dateFormat
	}
}
