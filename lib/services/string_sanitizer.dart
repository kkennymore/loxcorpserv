class StringSanitizer {
  /**space remover*/
  Future spaceRemover(String? text) async {
    return text!.trim().replaceAll(' ', '');
  }

  /* Phone number formatting
   * and
   */

  Future phoneNumberFormatter(phoneNumber, {bool isWithPlus = false}) async {
    var num = "";
    if (phoneNumber.startsWith('2340') || phoneNumber.startsWith('+2340')) {
      phoneNumber.startsWith('2340')
          ? num = await spaceRemover(phoneNumber.substring(4))
          : num = await spaceRemover(phoneNumber.substring(5));
    }
    if (phoneNumber.startsWith('+')) {
      num = await spaceRemover("234${phoneNumber.substring(4)}");
    }

    if (phoneNumber.startsWith('234')) {
      num = await spaceRemover("234${phoneNumber.substring(3)}");
    }

    if (phoneNumber.startsWith('00234')) {
      num = await spaceRemover("234${phoneNumber.substring(5)}");
    }

    if (phoneNumber.startsWith('0')) {
      num = await spaceRemover("234${phoneNumber.substring(1)}");
    }
    /**check if it is a number */
    if (await checkNumber(num)) {
      /**if is with plus is true */
      if (isWithPlus) {
        var isPhoneNumb =
            RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$')
                .hasMatch(num);
        if (isPhoneNumb) {
          return "+$num";
        }
        return false;
      }
      var isPhoneNumb =
          RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$').hasMatch(num);
      if (isPhoneNumb) {
        return num;
      }
      return false;
    }
    return false;
  }

  /*Email formatting */
  Future emailFormatter(email) async {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(await spaceRemover(email));
  }

  /*check if it is a number */
  Future checkNumber(number) async {
    return RegExp(r"^[0-9]+$").hasMatch(await spaceRemover(number));
  }
}
