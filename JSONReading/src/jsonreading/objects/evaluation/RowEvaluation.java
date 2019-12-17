package jsonreading.objects.evaluation;

import jsonreading.objects.Row;

/**
 *
 * @author Gabriel
 */
public class RowEvaluation extends Row {
    
    private ValueEvaluation value;

    public ValueEvaluation getValue() {
        return value;
    }

    public void setValue(ValueEvaluation value) {
        this.value = value;
    }

    @Override
    public String toString() {
        return "Row{" + "id=" + id + ", key=" + key + ", value=" + value + '}';
    }
    
}
