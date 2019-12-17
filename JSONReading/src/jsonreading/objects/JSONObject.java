package jsonreading.objects;

/**
 *
 * @author Gabriel
 */
public abstract class JSONObject {
    
    protected int total_rows;
    protected int offset;

    public int getTotal_rows() {
        return total_rows;
    }

    public void setTotal_rows(int total_rows) {
        this.total_rows = total_rows;
    }

    public int getOffset() {
        return offset;
    }

    public void setOffset(int offset) {
        this.offset = offset;
    }
    
    public abstract Object[] getTitles();
    
    @Override
    public abstract String toString();
    
}
