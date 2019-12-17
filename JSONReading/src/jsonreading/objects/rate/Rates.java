package jsonreading.objects.rate;

import jsonreading.objects.JSONObject;

/**
 *
 * @author Gabriel
 */
public class Rates extends JSONObject {
    
    private RowRate[] rows;

    public RowRate[] getRows() {
        return rows;
    }

    public void setRows(RowRate[] rows) {
        this.rows = rows;
    }

    @Override
    public String toString() {
        return "Evaluations{" + "total_rows=" + total_rows + ", offset=" + offset + ", rows=" + rows + '}';
    }

    @Override
    public Object[] getTitles() {
        return new Object[]{"ID", "VALUE", "EVENT", "TYPE", "DATE", "UID"};
    }
    
}
