package mx.org.ipn.cic.startup.util;

import java.io.File;
import java.io.FilenameFilter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class FolderUtilities {

    public static void create(String path) {
        File folder = new File(path);
        folder.mkdir();
    }
    
    public static File[] listFilesFor(File folder) {
        FilenameFilter jpgFilter = new FilenameFilter() {
            @Override
            public boolean accept(File dir, String name) {
                return name.toLowerCase().endsWith(".jpg");
            }
        };
        
        List<File> list = new ArrayList();
        for (File fileEntry : folder.listFiles()) {
            Collections.addAll(list, fileEntry.listFiles(jpgFilter));
        }
        
        return list.toArray(new File[list.size()]);
    }
    
}
