class DefaultException implements Exception {
	String errorMessage() {
		return "Something went wrong.";
	}
}

class BadRequestException implements Exception {
	String errorMessage() {
		return "400.";
	}
}

class AuthorizationException implements Exception {
	String errorMessage() {
		return "401.";
	}
}

class PermissionException implements Exception {
	String errorMessage() {
		return "403.";
	}
}

// Exceptions should get the error message from the API. (TO DO)