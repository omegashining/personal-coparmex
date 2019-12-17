package mx.org.ipn.cic.startup.util;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;

/**
 *
 * @author Gabriel
 */
public class FileUtilities {

    public static void create(String path) throws IOException {
        try (FileWriter fileWriter = new FileWriter(path)) {
            BufferedWriter bufferedWriter = new BufferedWriter(fileWriter);
            bufferedWriter.close();
        }
    }

    public static void rename(String path, String newPath) {
        File file = new File(path);
        File newFile = new File(newPath);
        file.renameTo(newFile);
    }

    public static void save(String path, String content) throws IOException {
        try (FileWriter fileWriter = new FileWriter(path); BufferedWriter bufferedWriter = new BufferedWriter(fileWriter)) {
            bufferedWriter.write(content);
        }
    }

    public static void delete(String path) {
        File file = new File(path);
        file.delete();
    }

    public static String getContent(String path) throws Exception {
        String content = "";
        try (FileReader fileReader = new FileReader(path); BufferedReader bufferedReader = new BufferedReader(fileReader)) {
            String line;
            while ((line = bufferedReader.readLine()) != null) {
                content += line + "\n";
            }
        }

        return content;
    }
}
