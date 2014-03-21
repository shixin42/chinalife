package com.chinalife.utils.servlet.pojo;

/**
 * Created by shixin on 3/18/14.
 */
public enum ErrorCode {
    LoginError(1000, "Username or password invalid."),

    DuplicateUserNicknameError(1010, "User nickname exists."),
    DuplicateUserEmailError(1011, "User email exists.");
    
    private int code;
    private String description;

    ErrorCode(int code, String description) {
        this.code = code;
        this.description = description;
    }

    public int getCode() {
        return code;
    }

    public String getDescription() {
        return description;
    }
}
