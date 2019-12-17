package mx.org.ipn.cic.startup.controller;

import mx.org.ipn.cic.startup.objects.Notification;
import mx.org.ipn.cic.startup.service.UserS;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 *
 * @author Gabriel
 */
@Controller
@RequestMapping("/user")
public class UserC {
    
    @Autowired
    private UserS userS;
    
    @RequestMapping(value="/validation/{user}", method=RequestMethod.GET)
    public @ResponseBody Notification validation(@PathVariable String user, @RequestParam(value="password", required=false) String password) {
        return this.userS.validation(user, password);
    }
    
}
