package org.example;

public class TestClass {


    protected String fosName = "tian";
    private int age = 19;


    public TestClass(){
        this("niu");
    }

    public  TestClass(String fosName){
        this(fosName,19);
    }

    public TestClass(String fosName,int age){
        this.fosName = fosName;
        this.age = age;
    }

    public String getFosName() {
        return fosName;
    }
    public void setFosName(String fosName) {
        this.fosName = fosName;
    }

    public void setAge(int age) {
        this.age = age;
    }
    public int getAge() {
        return age;
    }



    public  void hello(){
        System.out.println("hello test class");
    }

    public  void hello(String fosName){
        System.out.println(fosName);
    }

    public void hello(String fosName,int age){
        if (age > 18){
            System.out.println(fosName);
        }else  {
            System.out.println("you are not adult");

        }
    }

    /*

    public void setFosName(String fosName) {
        if (fosName == null){
            throw new IllegalArgumentException("invalid fosName");

        }
        this.fosName = fosName;
    }

    public String getFosName() {
//        printTian();
        return fosName;
    }

    public void setAge(int age) {
        if (age < 0 || age > 100){
            throw  new IllegalArgumentException("invalid age");
        }
        this.age = age;
    }

    public int getAge() {
        return age;
    }

    private void printTian(){
        System.out.println("gao tian is my life");
    }

    */

}
