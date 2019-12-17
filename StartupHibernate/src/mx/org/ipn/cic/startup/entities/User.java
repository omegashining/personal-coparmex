package mx.org.ipn.cic.startup.entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import static mx.org.ipn.cic.startup.constants.DataBase.CATALOG;

@Entity
@Table(name = "userr", catalog = CATALOG)
public class User implements java.io.Serializable {

    @Id
    @Column(name = "idUser", unique = true, nullable = false)
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int idUser;
    @Column(name = "username", nullable = false, length = 45)
    private String username;
    @Column(name = "password", nullable = false, length = 45)
    private String password;
    @Column(name = "name", nullable = false, length = 45)
    private String name;

    public User() {
    }

    public User(int idUser, String username, String password, String name) {
        this.idUser = idUser;
        this.username = username;
        this.password = password;
        this.name = name;
    }

    public int getIdUser() {
        return this.idUser;
    }

    public void setIdUser(int idUser) {
        this.idUser = idUser;
    }

    public String getUsername() {
        return this.username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return this.password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getName() {
        return this.name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Override
    public String toString() {
        return "User{" + "idUser=" + idUser + ", username=" + username + ", password=" + password + ", name=" + name + '}';
    }
    
}
