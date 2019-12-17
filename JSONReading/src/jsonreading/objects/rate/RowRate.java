package jsonreading.objects.rate;

import jsonreading.objects.Row;

/**
 *
 * @author Gabriel
 */
public class RowRate extends Row {
    
    private ValueRate value;

    public ValueRate getValue() {
        return value;
    }

    public void setValue(ValueRate value) {
        this.value = value;
    }

    @Override
    public String toString() {
        return "Row{" + "id=" + id + ", key=" + key + ", value=" + value + '}';
    }
    
}
