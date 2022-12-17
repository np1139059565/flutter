class MyLog {
  static final inf = (str) {
    print("--------------------info:-----------------------");
    print(str);
  };
  static final err = (e) {
    print("====================error:=======================");
    
    if (e.message!=null) {
      print(e.message);
    } else if (e.error!=null){
      print(e.error);
    }
  };
}
