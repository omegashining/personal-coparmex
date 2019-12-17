package jsonreading.objects.comment;

import jsonreading.objects.JSONObject;

/**
 *
 * @author Gabriel
 */
public class Comments extends JSONObject {
    
    private RowComment[] rows;

    public RowComment[] getRows() {
        return rows;
    }

    public void setRows(RowComment[] rows) {
        this.rows = rows;
    }

    @Override
    public String toString() {
        return "Comments{" + "total_rows=" + total_rows + ", offset=" + offset + ", rows=" + rows + '}';
    }

    @Override
    public Object[] getTitles() {
        return new Object[]{"ID", "TEXT", "EVENT", "TYPE", "DATE", "UID"};
    }
    
}
