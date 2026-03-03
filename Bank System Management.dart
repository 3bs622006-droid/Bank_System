import 'dart:io';

class Account {
  String _accountNumber;
  String _owner;
  String _password;
  double _balance;

  Account(this._accountNumber, this._owner, this._password, this._balance);

  String get accountNumber => _accountNumber;
  String get owner => _owner;

  bool login(String pass) {
    return pass == _password;
  }

  void deposit(double amount) {
    _balance += amount;
    print("Deposit successful. New balance: $_balance");
  }

  void withdraw(double amount) {
    if (amount <= _balance) {
      _balance -= amount;
      print("Withdraw successful. New balance: $_balance");
    } else {
      print("Insufficient balance.");
    }
  }

  double getBalance() {
    return _balance;
  }
}

class Bank {
  List<Account> accounts = [];

  void createAccount() {
    stdout.write("Enter Account Number: ");
    String number = stdin.readLineSync()!;

    stdout.write("Enter Owner Name: ");
    String name = stdin.readLineSync()!;

    stdout.write("Create Password: ");
    String pass = stdin.readLineSync()!;

    stdout.write("Initial Balance: ");
    double balance = double.parse(stdin.readLineSync()!);

    accounts.add(Account(number, name, pass, balance));
    print("Account created successfully.");
  }

  Account? findAccount(String number) {
    for (var acc in accounts) {
      if (acc.accountNumber == number) return acc;
    }
    return null;
  }

  void transfer() {
    stdout.write("From Account: ");
    String from = stdin.readLineSync()!;

    stdout.write("To Account: ");
    String to = stdin.readLineSync()!;

    var sender = findAccount(from);
    var receiver = findAccount(to);

    if (sender == null || receiver == null) {
      print("Account not found.");
      return;
    }

    stdout.write("Amount: ");
    double amount = double.parse(stdin.readLineSync()!);

    if (sender.getBalance() >= amount) {
      sender.withdraw(amount);
      receiver.deposit(amount);
      print("Transfer successful.");
    } else {
      print("Not enough balance.");
    }
  }
}

void main() {
  Bank bank = Bank();

  while (true) {
    print("\n===== Bank System =====");
    print("1. Create Account");
    print("2. Login");
    print("3. Transfer");
    print("4. Exit");

    stdout.write("Choose: ");
    int choice = int.parse(stdin.readLineSync()!);

    if (choice == 1) {
      bank.createAccount();
    }

    else if (choice == 2) {
      stdout.write("Enter Account Number: ");
      String number = stdin.readLineSync()!;

      var acc = bank.findAccount(number);

      if (acc == null) {
        print("Account not found.");
        continue;
      }

      stdout.write("Enter Password: ");
      String pass = stdin.readLineSync()!;

      if (acc.login(pass)) {
        while (true) {
          print("\nWelcome ${acc.owner}");
          print("1. Deposit");
          print("2. Withdraw");
          print("3. Check Balance");
          print("4. Logout");

          stdout.write("Choose: ");
          int op = int.parse(stdin.readLineSync()!);

          if (op == 1) {
            stdout.write("Amount: ");
            double amt = double.parse(stdin.readLineSync()!);
            acc.deposit(amt);
          } else if (op == 2) {
            stdout.write("Amount: ");
            double amt = double.parse(stdin.readLineSync()!);
            acc.withdraw(amt);
          } else if (op == 3) {
            print("Balance: ${acc.getBalance()}");
          } else {
            break;
          }
        }
      } else {
        print("Wrong password.");
      }
    }

    else if (choice == 3) {
      bank.transfer();
    }

    else {
      print("Thank you.");
      break;
    }
  }

}
