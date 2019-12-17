package mx.org.ipn.cic.startup.model.dao.impl;

import mx.org.ipn.cic.startup.entities.Type;

import org.springframework.stereotype.Repository;

/**
 *
 * @author Gabriel
 */
@Repository
public class TypeDAOImpl extends HibernateAbstractDAOImpl {
    
    public TypeDAOImpl() {
        super(Type.class);
    }
    
}
