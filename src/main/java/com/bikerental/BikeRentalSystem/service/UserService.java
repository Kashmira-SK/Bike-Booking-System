package com.bikerental.BikeRentalSystem.service;

import com.bikerental.BikeRentalSystem.model.User;
import com.bikerental.BikeRentalSystem.util.FileHelper;
import java.io.IOException;
import java.util.List;

public class UserService {
    private static final String FILE_PATH = "data/users.txt";

    public void createUser(User user) throws IOException {
        FileHelper.appendLine(FILE_PATH, user.toFileString());
    }

    public List<String> readAll() throws IOException {
        return FileHelper.readLines(FILE_PATH);
    }
}