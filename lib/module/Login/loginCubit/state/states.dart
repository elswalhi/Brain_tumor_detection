// ignore: camel_case_types
abstract class LoginStates{}
// ignore: camel_case_types
class LoginInitial extends LoginStates{}
// ignore: camel_case_types
class LoginLoading extends LoginStates{}
// ignore: camel_case_types
class LoginSuccess extends LoginStates{
  final String? uId;

  LoginSuccess(this.uId);
  // ignore: non_constant_identifier_names

}
// ignore: camel_case_types
class LoginError extends LoginStates{
  final String? error;
  LoginError(this.error){
    print(" the error is ${error.toString()}");
  }
}
class LoginVisiblePassword extends LoginStates{}

class ChangeErrorState extends LoginStates{}

class GetUserSuccess extends LoginStates{
  final String uId;
  GetUserSuccess(this.uId);
}

class GetUserLoading extends LoginStates{}

class GetUserError extends LoginStates{}

// ignore: camel_case_types
class RegisterInitial extends LoginStates{}
// ignore: camel_case_types
class RegisterLoading extends LoginStates{}
// ignore: camel_case_types
class RegisterSuccess extends LoginStates{
  // ignore: non_constant_identifier_names

}
// ignore: camel_case_types
class RegisterError extends LoginStates{
  final String? error;
  RegisterError(this.error){
    print(" the error is ${error.toString()}");

  }
}
class CreateUserSuccess extends LoginStates{
  // ignore: non_constant_identifier_names

}
// ignore: camel_case_types
class CreateUserError extends LoginStates{
  final String? error;
  CreateUserError(this.error){
    print(" the error is ${error.toString()}");
  }
}

class RegisterVisiblePassword extends LoginStates{}

class ChangeErrorr extends LoginStates{}

class Changechecked extends LoginStates{}
