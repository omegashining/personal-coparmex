package jsonreading.objects.comment;

import jsonreading.objects.Value;

/**
 *
 * @author Gabriel
 */
public class ValueComment extends Value {
    
    private String text;
    private String event;

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public String getEvent() {
        return event;
    }

    public void setEvent(String event) {
        this.event = event;
    }
    
    @Override
    public Object[] getObject(int index) {
        return new Object[] {index, text, event, type, date, uid};
    }

    @Override
    public String toString() {
        return "Content{" + "_id=" + _id + ", _rev=" + _rev + ", text=" + text + ", event=" + event + ", type=" + type + ", date=" + date + ", uid=" + uid + '}';
    }
    
}
