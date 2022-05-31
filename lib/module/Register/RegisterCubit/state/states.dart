// ignore: camel_case_types

abstract class RegisterStates{}

// ignore: camel_case_types
class RegisterInitial extends RegisterStates{}
// ignore: camel_case_types
class RegisterLoading extends RegisterStates{}
// ignore: camel_case_types
class RegisterSuccess extends RegisterStates{
  // ignore: non_constant_identifier_names

}
// ignore: camel_case_types
class RegisterError extends RegisterStates{
  final String? error;
  RegisterError(this.error){
    print(" the error is ${error.toString()}");

  }
}
class CreateUserSuccess extends RegisterStates{
  // ignore: non_constant_identifier_names

}
// ignore: camel_case_types
class CreateUserError extends RegisterStates{
  final String? error;
  CreateUserError(this.error){
    print(" the error is ${error.toString()}");
  }
}

class RegisterVisiblePassword extends RegisterStates{}

class ChangeError extends RegisterStates{}

class Changechecked extends RegisterStates{}