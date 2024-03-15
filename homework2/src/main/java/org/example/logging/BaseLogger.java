package org.example.logging;

public abstract class BaseLogger implements Logger{
    public void logFirst(String message) {
        System.out.println("Log is started.");
        log(message);
        System.out.println("Log is ended");
    }
}
