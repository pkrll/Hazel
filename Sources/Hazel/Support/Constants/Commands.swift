enum Commands: String {
	case new

	init?(_ rawValue: String) {
		var rawValue = rawValue
 		guard rawValue.stripDashes() else { return nil }
		self.init(rawValue: rawValue)
	}
}
