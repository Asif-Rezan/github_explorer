class ApiEndPoints {
  ApiEndPoints._();

  static String getUserInfo(String userName) => "users/$userName";
  static String getRepoInfo(String userName) => "users/$userName/repos";

}