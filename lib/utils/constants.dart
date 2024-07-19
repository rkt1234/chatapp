final RegExp EMAIL_VALIDATION_REGEX =
    RegExp(r"^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$");
final RegExp PASSWORD_VALIDATION_REGEX =
    RegExp(r"^(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$");
final RegExp NAME_VALIDATION_REGEX = RegExp(r"^[a-zA-Z]+(([',.-][a-zA-Z ])?[a-zA-Z]*)*$");