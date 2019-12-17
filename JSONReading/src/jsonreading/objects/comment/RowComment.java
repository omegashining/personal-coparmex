package jsonreading.objects.comment;

import jsonreading.objects.Row;

/**
 *
 * @author Gabriel
 */
public class RowComment extends Row {
    
    private ValueComment value;

    public ValueComment getValue() {
        return value;
    }

    public void setValue(ValueComment value) {
        this.value = value;
    }

    @Override
    public String toString() {
        return "Row{" + "id=" + id + ", key=" + key + ", value=" + value + '}';
    }
    
}
