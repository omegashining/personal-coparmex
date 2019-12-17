package mx.org.ipn.cic.startup.model.dao.impl;

import com.google.common.base.Preconditions;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

/**
 *
 * @author Gabriel
 */
@Repository
@Transactional
public abstract class HibernateAbstractDAOImpl<T extends Serializable> {
    
    @Autowired
    private SessionFactory sessionFactory;
    
    private final Class< T> anyClass;
 
    public HibernateAbstractDAOImpl(final Class< T> classToSet) {
        this.anyClass = classToSet;
    }
 
    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }
 
    protected final Session getCurrentSession() {
        return this.sessionFactory.getCurrentSession();
    }
 
    public T getById(final Integer id) {
        Preconditions.checkArgument(id != null);
        return (T) this.getCurrentSession().get(this.anyClass, id);
    }
 
    public List< T> getAll() {
        return this.getCurrentSession().createQuery("from " + this.anyClass.getName()).list();
    }
 
    public void create(final T entity) {
        Preconditions.checkNotNull(entity);
        this.getCurrentSession().persist(entity);
    }
 
    public void update(final T entity) {
        Preconditions.checkNotNull(entity);
        this.getCurrentSession().merge(entity);
    }
 
    public void delete(final T entity) {
        Preconditions.checkNotNull(entity);
        this.getCurrentSession().delete(entity);
    }
 
    public void deleteById(final Integer entityId) {
        final T entity = this.getById(entityId);
        Preconditions.checkState(entity != null);
        this.delete(entity);
    }
    
    public int count(String queryString) {
        Session session = this.getCurrentSession();
        int cantidad = 0;
        
        try {
            cantidad = ((Long) session.createQuery(queryString).uniqueResult()).intValue();
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return cantidad;
    }
    
    public <T> T findOne(String queryString) {
        Session session = this.getCurrentSession();
        T entity = null;
        
        try {
            entity = (T) session.createQuery(queryString).uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return entity;
    }
    
    public <T> List<T> findMany(String queryString) {
        Session session = this.getCurrentSession();
        List<T> entities = null;
        
        try {
            Query query = session.createQuery(queryString);
            entities = query.list();
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return entities;
    }
    
    public <T> List<T> findByDate(String queryString, Date fechaInicial, Date fechaFinal) {
        Session session = this.getCurrentSession();
        List<T> entities = null;
        
        try {
            Query query = session.createQuery(queryString);
            query.setParameter("start", fechaInicial);
            query.setParameter("end", fechaFinal);
            entities = query.list();
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return entities;
    }
    
    public <T> List<T> findByPage(String queryString, int pageNumber, int pageSize) {
        Session session = this.getCurrentSession();
        List<T> entities = null;
        
        try {
            Query query = session.createQuery(queryString);
            query.setFirstResult((pageNumber - 1) * pageSize);
            query.setMaxResults(pageSize);
            entities = query.list();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return entities;
    }
    
}
