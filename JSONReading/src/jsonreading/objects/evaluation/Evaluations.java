package jsonreading.objects.evaluation;

import jsonreading.objects.JSONObject;

/**
 *
 * @author Gabriel
 */
public class Evaluations extends JSONObject {
    
    private RowEvaluation[] rows;

    public RowEvaluation[] getRows() {
        return rows;
    }

    public void setRows(RowEvaluation[] rows) {
        this.rows = rows;
    }

    @Override
    public String toString() {
        return "Evaluations{" + "total_rows=" + total_rows + ", offset=" + offset + ", rows=" + rows + '}';
    }

    @Override
    public Object[] getTitles() {
        return new Object[]{"ID", "RATE EVENT", "RATE CONFERENCE", "RATE NETWORKING", "RATE ORGANIZATION", "OPTION", "COMMENT", "TYPE", "DATE", "UID"};
    }
    
}


