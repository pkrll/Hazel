
extension String {

	mutating func stripDashes() -> Bool {
		guard self.hasPrefix("--") else { return false }
		self.removeFirst(2)
		return true
	}

}
