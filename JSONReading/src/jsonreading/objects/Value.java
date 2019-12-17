package jsonreading.objects;

/**
 *
 * @author Gabriel
 */
public abstract class Value {
    
    protected String _id;
    protected String _rev;
    protected String type;
    protected String date;
    protected String uid;

    public String getId() {
        return _id;
    }

    public void setId(String _id) {
        this._id = _id;
    }

    public String getRev() {
        return _rev;
    }

    public void setRev(String _rev) {
        this._rev = _rev;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getUid() {
        return uid;
    }

    public void setUid(String uid) {
        this.uid = uid;
    }
    
    public abstract Object[] getObject(int index);
    
    @Override
    public abstract String toString();
    
}
