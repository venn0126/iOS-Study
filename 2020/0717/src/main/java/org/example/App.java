package org.example;

import java.util.Arrays;

/**
 * Hello world!
 */
public class App {
    public static void main(String[] args) {
//        System.out.println( "Hello World!" );

//        int[] nns = new int[] {1,2,8,9};
//        for (int i = 0; i < nns.length; i++) {
//            System.out.println(nns[i]);
//        }
//
//        for (int n : nns) {
//            System.out.println(n);
//        }
//        Arrays.sort(nns);
//        System.out.println(nns);

//        TestClass cls = new TestClass();
////        cls.fosName = "niu";
//        cls.setFosName("null");
//        cls.setAge(19);
//
//        TestClass cls = new TestClass("niuwe", 10);
//        System.out.println(cls.getFosName() + cls.getAge());
//        cls.hello();

//        TestClass cls1 = new TestClass();

       TestStudent stu = new TestStudent();
       stu.setFosName("bin");
       System.out.println(stu.getFosName());
        System.out.println(stu instanceof Object);

        stu.hello();

    }


}
