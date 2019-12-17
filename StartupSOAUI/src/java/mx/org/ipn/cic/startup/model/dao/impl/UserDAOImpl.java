package mx.org.ipn.cic.startup.model.dao.impl;

import mx.org.ipn.cic.startup.entities.User;

import org.springframework.stereotype.Repository;

/**
 *
 * @author Gabriel
 */
@Repository
public class UserDAOImpl extends HibernateAbstractDAOImpl {
    
    public UserDAOImpl() {
        super(User.class);
    }
    
}
