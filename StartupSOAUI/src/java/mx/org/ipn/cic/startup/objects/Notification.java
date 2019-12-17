package mx.org.ipn.cic.startup.objects;

/**
 *
 * @author Gabriel
 */
public class Notification {
    
    private boolean status;
    private String message;

    public Notification() {
    }

    public Notification(String message) {
        this.status = false;
        this.message = message;
    }
    
    public boolean isStatus() {
        return status;
    }
    
    public void setStatus(boolean status) {
        this.status = status;
    }
    
    public String getMessage() {
        return message;
    }
    
    public void setMessage(String message) {
        this.message = message;
    }
    
}
