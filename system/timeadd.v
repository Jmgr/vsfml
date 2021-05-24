module system

fn (a Time) < (b Time) bool {
	return a.microseconds < b.microseconds
}
