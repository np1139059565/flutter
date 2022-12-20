class MyLogUtils {
  static final inf = (str) {
    print("--------------------info:-----------------------");
    print(str);
  };
  static final err = (e) {
    print("====================error:=======================");

    if (e.message != null) {
      print(e.message);
    }
    if (e.error != null) {
      print(e.error);
    }
    if (e.response != null) {
      print(e.response);
    }
  };
}
