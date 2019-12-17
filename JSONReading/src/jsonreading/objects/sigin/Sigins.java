package jsonreading.objects.sigin;

import jsonreading.objects.JSONObject;

/**
 *
 * @author Gabriel
 */
public class Sigins extends JSONObject {
    
    private RowSigin[] rows;

    public RowSigin[] getRows() {
        return rows;
    }

    public void setRows(RowSigin[] rows) {
        this.rows = rows;
    }

    @Override
    public String toString() {
        return "Evaluations{" + "total_rows=" + total_rows + ", offset=" + offset + ", rows=" + rows + '}';
    }

    @Override
    public Object[] getTitles() {
        return new Object[]{"ID", "GAFETE", "DEVICE", "TYPE", "DATE", "UID"};
    }
    
}
