package mx.org.ipn.cic.startup.model.dao.impl;

import mx.org.ipn.cic.startup.entities.Event;

import org.springframework.stereotype.Repository;

/**
 *
 * @author Gabriel
 */
@Repository
public class EventDAOImpl extends HibernateAbstractDAOImpl {
    
    public EventDAOImpl() {
        super(Event.class);
    }
    
}
