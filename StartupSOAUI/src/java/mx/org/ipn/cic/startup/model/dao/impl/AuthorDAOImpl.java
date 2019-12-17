package mx.org.ipn.cic.startup.model.dao.impl;

import mx.org.ipn.cic.startup.entities.Author;

import org.springframework.stereotype.Repository;

/**
 *
 * @author Gabriel
 */
@Repository
public class AuthorDAOImpl extends HibernateAbstractDAOImpl {
    
    public AuthorDAOImpl() {
        super(Author.class);
    }
    
}
