package mx.org.ipn.cic.startup.controller;

import mx.org.ipn.cic.startup.entities.Event;
import mx.org.ipn.cic.startup.service.EventS;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 *
 * @author Gabriel
 */
@Controller
@RequestMapping("/event")
public class EventC {
    
    @Autowired
    private EventS eventS;
    
    @RequestMapping(value="/all", method=RequestMethod.GET)
    public @ResponseBody Event[] all() {
        return this.eventS.getEvents();
    }
    
    @RequestMapping(value="/one/{id}", method=RequestMethod.GET)
    public @ResponseBody Event one(@PathVariable Integer id) {
        return this.eventS.getEvent(id);
    }
    
}
