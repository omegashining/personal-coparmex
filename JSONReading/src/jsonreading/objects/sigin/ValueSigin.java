package jsonreading.objects.sigin;

import jsonreading.objects.Value;

/**
 *
 * @author Gabriel
 */
public class ValueSigin extends Value {
    
    private String gafete;
    private String device;

    public String getGafete() {
        return gafete;
    }

    public void setGafete(String gafete) {
        this.gafete = gafete;
    }

    public String getDevice() {
        return device;
    }

    public void setDevice(String device) {
        this.device = device;
    }

    @Override
    public Object[] getObject(int index) {
        return new Object[] {index, gafete, device, type, date, uid};
    }

    @Override
    public String toString() {
        return "Sigin{" + "_id=" + _id + ", _rev=" + _rev + ", gafete=" + gafete + ", device=" + device + ", type=" + type + ", date=" + date + ", uid=" + uid + '}';
    }
    
}
