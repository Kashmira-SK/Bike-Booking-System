package com.bikerental.BikeRentalSystem.util;

import java.io.*;
import java.nio.file.*;
import java.util.*;

public class FileHelper {

    // Make sure the data folder and file exist before any operation
    private static void ensureFile(String filePath) throws IOException {
        File file = new File(filePath);
        file.getParentFile().mkdirs();
        if (!file.exists()) file.createNewFile();
    }

    // Read all non-empty lines from a file
    public static List<String> readAll(String filePath) {
        List<String> lines = new ArrayList<>();
        try {
            ensureFile(filePath);
            BufferedReader reader = new BufferedReader(new FileReader(filePath));
            String line;
            while ((line = reader.readLine()) != null) {
                if (!line.trim().isEmpty()) lines.add(line.trim());
            }
            reader.close();
        } catch (IOException e) {
            System.err.println("FileHelper.readAll error: " + e.getMessage());
        }
        return lines;
    }

    // Append one record to a file
    public static boolean append(String filePath, String record) {
        try {
            ensureFile(filePath);
            BufferedWriter writer = new BufferedWriter(new FileWriter(filePath, true));
            writer.write(record);
            writer.newLine();
            writer.close();
            return true;
        } catch (IOException e) {
            System.err.println("FileHelper.append error: " + e.getMessage());
            return false;
        }
    }

    // Overwrite the entire file with a new list of lines (used for update/delete)
    public static boolean writeAll(String filePath, List<String> lines) {
        try {
            ensureFile(filePath);
            BufferedWriter writer = new BufferedWriter(new FileWriter(filePath, false));
            for (String line : lines) {
                writer.write(line);
                writer.newLine();
            }
            writer.close();
            return true;
        } catch (IOException e) {
            System.err.println("FileHelper.writeAll error: " + e.getMessage());
            return false;
        }
    }

    // Find a single line where the first field (id) matches
    public static String findById(String filePath, String id) {
        for (String line : readAll(filePath)) {
            String[] parts = line.split("\\" + AppConstants.SEP);
            if (parts.length > 0 && parts[0].equals(id)) return line;
        }
        return null;
    }

    // Delete a line by id, returns true if something was deleted
    public static boolean deleteById(String filePath, String id) {
        List<String> all = readAll(filePath);
        List<String> updated = new ArrayList<>();
        boolean found = false;
        for (String line : all) {
            String[] parts = line.split("\\" + AppConstants.SEP);
            if (parts.length > 0 && parts[0].equals(id)) {
                found = true;
            } else {
                updated.add(line);
            }
        }
        if (found) writeAll(filePath, updated);
        return found;
    }

    // Generate a simple unique ID
    public static String generateId() {
        return String.valueOf(System.currentTimeMillis());
    }
}