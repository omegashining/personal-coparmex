package mx.org.ipn.cic.startup.entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import static mx.org.ipn.cic.startup.constants.DataBase.CATALOG;

@Entity
@Table(name = "author", catalog = CATALOG)
public class Author implements java.io.Serializable {

    @Id
    @Column(name = "idAuthor", unique = true, nullable = false)
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int idAuthor;
    @Column(name = "name", nullable = false, length = 80)
    private String name;
    @Column(name = "organization", nullable = false, length = 80)
    private String organization;

    public Author() {
    }

    public Author(int idAuthor, String name, String organization) {
        this.idAuthor = idAuthor;
        this.name = name;
        this.organization = organization;
    }

    public int getIdAuthor() {
        return this.idAuthor;
    }

    public void setIdAuthor(int idAuthor) {
        this.idAuthor = idAuthor;
    }

    public String getName() {
        return this.name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getOrganization() {
        return this.organization;
    }

    public void setOrganization(String organization) {
        this.organization = organization;
    }

    @Override
    public String toString() {
        return "Author{" + "idAuthor=" + idAuthor + ", name=" + name + ", organization=" + organization + '}';
    }
    
}
