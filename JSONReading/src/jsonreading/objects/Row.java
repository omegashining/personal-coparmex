package jsonreading.objects;

/**
 *
 * @author Gabriel
 */
public abstract class Row {
    
    protected String id;
    protected String[] key;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String[] getKey() {
        return key;
    }

    public void setKey(String[] key) {
        this.key = key;
    }
    
    @Override
    public abstract String toString();
    
}
