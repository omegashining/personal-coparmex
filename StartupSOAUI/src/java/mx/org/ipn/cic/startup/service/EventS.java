package mx.org.ipn.cic.startup.service;

import java.util.List;
import javax.annotation.Resource;

import mx.org.ipn.cic.startup.model.dao.impl.EventDAOImpl;
import mx.org.ipn.cic.startup.entities.Event;

import org.springframework.stereotype.Service;

/**
 *
 * @author Gabriel
 */
@Service
public class EventS {
    
    @Resource
    private EventDAOImpl eventDAO;
    
    public Event getEvent(int idEvent) {
        try {
            Event event = (Event) this.eventDAO.getById(idEvent);
            
            return (event != null) ? event : new Event();
        } catch(Exception ex) {
            ex.printStackTrace();
            return new Event();
        }
    }
    
    public Event[] getEvents() {
        List<Event> events = this.eventDAO.getAll();
        
        return events.toArray(new Event[events.size()]);
    }
    
}
