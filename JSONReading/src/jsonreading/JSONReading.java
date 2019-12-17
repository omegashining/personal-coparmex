package jsonreading;

import com.google.gson.Gson;

import java.util.Map;
import java.util.TreeMap;
import jsonreading.objects.comment.Comments;
import jsonreading.objects.comment.RowComment;

import jsonreading.objects.evaluation.Evaluations;
import jsonreading.objects.evaluation.RowEvaluation;
import jsonreading.objects.rate.Rates;
import jsonreading.objects.rate.RowRate;
import jsonreading.objects.sigin.RowSigin;
import jsonreading.objects.sigin.Sigins;

import mx.gob.org.ipn.cic.mu.utl.file.ExcelUtil;
import mx.gob.org.ipn.cic.mu.utl.web.URLUtil;

import org.apache.poi.xssf.usermodel.XSSFWorkbook;

/**
 *
 * @author Gabriel
 */
public class JSONReading {
    
    public static void main(String[] args) throws Exception {
        XSSFWorkbook workbook = new XSSFWorkbook();
        
        Gson gson = new Gson();
        
        // EVALUATIONS
        String json = URLUtil.read("http://localhost:8084/conferences/_design/evaluations/_view/list");
        
        Evaluations evaluations = gson.fromJson(json, Evaluations.class);
        
        Map<String, Object[]> data = new TreeMap<>();
        data.put("1", evaluations.getTitles());
        
        int index = 1;
        for (RowEvaluation evaluation: evaluations.getRows()) {
            data.put((index+1)+"", evaluation.getValue().getObject(index++));
        }
        
        ExcelUtil.createSheet(workbook, data, "Evaluación");
        
        // COMMENTS
        
        json = URLUtil.read("http://localhost:8084/conferences/_design/comments/_view/list");
        
        Comments comments = gson.fromJson(json, Comments.class);
        
        data = new TreeMap<>();
        data.put("1", comments.getTitles());
        
        index = 1;
        for (RowComment comment: comments.getRows()) {
            data.put((index+1)+"", comment.getValue().getObject(index++));
        }
        
        ExcelUtil.createSheet(workbook, data, "Comentarios");
        
        // SIGINS
        
        json = URLUtil.read("http://localhost:8084/conferences/_design/signin/_view/list");
        
        Sigins sigins = gson.fromJson(json, Sigins.class);
        
        data = new TreeMap<>();
        data.put("1", sigins.getTitles());
        
        index = 1;
        for (RowSigin sigin: sigins.getRows()) {
            data.put((index+1)+"", sigin.getValue().getObject(index++));
        }
        
        ExcelUtil.createSheet(workbook, data, "Sesiones");
        
        // RATES
        
        json = URLUtil.read("http://localhost:8084/conferences/_design/ratings/_view/list");
        
        Rates rates = gson.fromJson(json, Rates.class);
        
        data = new TreeMap<>();
        data.put("1", rates.getTitles());
        
        index = 1;
        for (RowRate rate: rates.getRows()) {
            data.put((index+1)+"", rate.getValue().getObject(index++));
        }
        
        ExcelUtil.createSheet(workbook, data, "Rating");
        
        ExcelUtil.save(workbook, "coparmex");
    }
    
}
