package org.example;

public class TestStudent extends TestClass {

    private  float score;

    public void setScore(float score) {
        this.score = score;
    }

    public float getScore() {
        return score;
    }

    public void helloS(){
        System.out.println(fosName);
    }

    @Override
    public void hello() {
        super.hello();
        System.out.println("test stud");
    }
}
