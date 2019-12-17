package jsonreading.objects.rate;

import jsonreading.objects.Value;

/**
 *
 * @author Gabriel
 */
public class ValueRate extends Value {

    private String value;
    private String event;

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public String getEvent() {
        return event;
    }

    public void setEvent(String event) {
        this.event = event;
    }

    @Override
    public Object[] getObject(int index) {
        return new Object[] {index, value, event, type, date, uid};
    }

    @Override
    public String toString() {
        return "Sigin{" + "_id=" + _id + ", _rev=" + _rev + ", value=" + value + ", event=" + event + ", type=" + type + ", date=" + date + ", uid=" + uid + '}';
    }
    
}
