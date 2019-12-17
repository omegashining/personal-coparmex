package mx.org.ipn.cic.startup.entities;

import java.util.HashSet;
import java.util.Set;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import static mx.org.ipn.cic.startup.constants.DataBase.CATALOG;

@Entity
@Table(name = "event", catalog = CATALOG)
public class Event implements java.io.Serializable {

    @Id
    @Column(name = "idEvent", unique = true, nullable = false)
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int idEvent;
    @ManyToOne
    @JoinColumn(name = "type_idType")
    private Type type;
    @Column(name = "identifier", nullable = false, length = 50)
    private String identifier;
    @Column(name = "title", nullable = false, length = 50)
    private String title;
    @Column(name = "datee", nullable = false, length = 10)
    private String date;
    @Column(name = "timee", nullable = false, length = 10)
    private String time;
    @Column(name = "duration", nullable = false)
    private Integer duration;
    @Column(name = "location", nullable = false, length = 50)
    private String location;
    @Column(name = "coordinate", nullable = false, length = 10)
    private String coordinate;
    @Column(name = "description", nullable = false, length = 255)
    private String description;
    @Column(name = "image", nullable = false, length = 50)
    private String image;
    @Column(name = "alarm", nullable = false)
    private boolean alarm;
    @Column(name = "stared", nullable = false)
    private boolean stared;
    @ManyToMany(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    @JoinTable(name = "event_author", catalog = CATALOG, 
            joinColumns = { @JoinColumn(name = "event_idEvent", nullable = false, updatable = false) }, 
            inverseJoinColumns = { @JoinColumn(name = "author_idAuthor", nullable = false, updatable = false) })
    private Set<Author> authors = new HashSet<>(0);

    public Event() {
    }

    public Event(int idEvent, Type type, String identifier, String title, String date, String time, int duration, String location, String coordinate, String description, String image, boolean alarm, boolean stared) {
        this.idEvent = idEvent;
        this.type = type;
        this.identifier = identifier;
        this.title = title;
        this.date = date;
        this.time = time;
        this.duration = duration;
        this.location = location;
        this.coordinate = coordinate;
        this.description = description;
        this.image = image;
        this.alarm = alarm;
        this.stared = stared;
    }

    public Event(int idEvent, Type type, String identifier, String title, String date, String time, int duration, String location, String coordinate, String description, String image, boolean alarm, boolean stared, Set<Author> authors) {
        this.idEvent = idEvent;
        this.type = type;
        this.identifier = identifier;
        this.title = title;
        this.date = date;
        this.time = time;
        this.duration = duration;
        this.location = location;
        this.coordinate = coordinate;
        this.description = description;
        this.image = image;
        this.alarm = alarm;
        this.stared = stared;
        this.authors = authors;
    }

    public int getIdEvent() {
        return this.idEvent;
    }

    public void setIdEvent(int idEvent) {
        this.idEvent = idEvent;
    }

    public Type getType() {
        return this.type;
    }

    public void setType(Type type) {
        this.type = type;
    }

    public String getIdentifier() {
        return this.identifier;
    }

    public void setIdentifier(String identifier) {
        this.identifier = identifier;
    }

    public String getTitle() {
        return this.title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDate() {
        return this.date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getTime() {
        return this.time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public int getDuration() {
        return this.duration;
    }

    public void setDuration(int duration) {
        this.duration = duration;
    }

    public String getLocation() {
        return this.location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getCoordinate() {
        return this.coordinate;
    }

    public void setCoordinate(String coordinate) {
        this.coordinate = coordinate;
    }

    public String getDescription() {
        return this.description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getImage() {
        return this.image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public boolean isAlarm() {
        return this.alarm;
    }

    public void setAlarm(boolean alarm) {
        this.alarm = alarm;
    }

    public boolean isStared() {
        return this.stared;
    }

    public void setStared(boolean stared) {
        this.stared = stared;
    }

    public Set<Author> getAuthors() {
        return this.authors;
    }

    public void setAuthors(Set<Author> authors) {
        this.authors = authors;
    }

    @Override
    public String toString() {
        return "Event{" + "idEvent=" + idEvent + ", type=" + type + ", identifier=" + identifier + ", title=" + title + ", date=" + date + ", time=" + time + ", duration=" + duration + ", location=" + location + ", coordinate=" + coordinate + ", description=" + description + ", image=" + image + ", alarm=" + alarm + ", stared=" + stared + '}';
    }
    
}
