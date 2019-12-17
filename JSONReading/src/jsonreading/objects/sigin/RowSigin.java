package jsonreading.objects.sigin;

import jsonreading.objects.Row;

/**
 *
 * @author Gabriel
 */
public class RowSigin extends Row {
    
    private ValueSigin value;

    public ValueSigin getValue() {
        return value;
    }

    public void setValue(ValueSigin value) {
        this.value = value;
    }

    @Override
    public String toString() {
        return "Row{" + "id=" + id + ", key=" + key + ", value=" + value + '}';
    }
    
}
