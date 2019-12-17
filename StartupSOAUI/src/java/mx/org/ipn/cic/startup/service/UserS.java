package mx.org.ipn.cic.startup.service;

import javax.annotation.Resource;

import mx.org.ipn.cic.startup.model.dao.impl.UserDAOImpl;
import mx.org.ipn.cic.startup.objects.Notification;
import mx.org.ipn.cic.startup.entities.User;

import org.springframework.stereotype.Service;

/**
 *
 * @author Gabriel
 */
@Service
public class UserS {
    
    @Resource
    private UserDAOImpl userDAO;
    
    public User getUser(String username) {
        try {
            return (User) this.userDAO.findOne("from User as u where u.username='" + username + "'");
        } catch(Exception ex) {
            return new User();
        }
    }
    
    public Notification validation(String username, String password) {
        Notification acuse = new Notification("Usuario y/o Password incorrecto(s).");
        
        User user = this.getUser(username);
        
        if(user!=null && user.getUsername()!=null) {
            if(user.getPassword().equals(password)) {
                acuse.setMessage("Sesión iniciada correctamente.");
                acuse.setStatus(true);
            }
            
        }
        
        return acuse;
    }
    
}
