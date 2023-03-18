// Task 2 Bytewise Fellowship - Abdul Basit
import 'dart:io';

class Num {
  int num1 = 2;
}

class Student {
  String name;
  int age;
  
  Student(this.name, this.age);
  
  void sayHi() {
    print("Hi, my name is $name and I am $age years old.");
  }
}

class Animal {
  String name;
  
  Animal(this.name);
  
  void speak() {
    print("$name makes a sound");
  }
}

class Dog extends Animal {
  Dog(String name) : super(name);
  
  void speak() {
    print("$name barks");
  }
}

main() {

  //stdout.writeln('What is your name: ?');
  //var name = stdin.readLineSync();
  //print('My name is $name');

  //Null Aware
  //var n;
  //int number;

  //number = n?.num1 ?? 4;
  //print(number);


  //for (int i = 1; i <= 10; i++) {
    //print("The square of $i is ${i * i}.");
  //}

  //Basic Class & Constructor
  //Student Basit = Student("Basit", 21);
  //Basit.sayHi();

  //Inheritance + Function Overriding
  //Animal animal = Animal("General Animal");
  //animal.speak();
  
  //Dog dog = Dog("Bruno");
  //dog.speak(); 



}
