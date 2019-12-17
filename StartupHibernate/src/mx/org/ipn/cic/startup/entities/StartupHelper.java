package mx.org.ipn.cic.startup.entities;

import org.hibernate.Session;

public class StartupHelper {

    Session session = null;

    public StartupHelper() {
        this.session = HibernateUtil.getSessionFactory().getCurrentSession();
    }
    
}
