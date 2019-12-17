package mx.org.ipn.cic.startup.entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import static mx.org.ipn.cic.startup.constants.DataBase.CATALOG;

@Entity
@Table(name = "type", catalog = CATALOG)
public class Type implements java.io.Serializable {

    @Id
    @Column(name = "idType", unique = true, nullable = false)
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int idType;
    @Column(name = "description", nullable = false, length = 45)
    private String description;

    public Type() {
    }

    public Type(int idType, String description) {
        this.idType = idType;
        this.description = description;
    }

    public int getIdType() {
        return this.idType;
    }

    public void setIdType(int idType) {
        this.idType = idType;
    }

    public String getDescription() {
        return this.description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    @Override
    public String toString() {
        return "Type{" + "idType=" + idType + ", description=" + description + '}';
    }
    
}
