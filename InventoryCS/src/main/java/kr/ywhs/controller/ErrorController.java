package kr.ywhs.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class ErrorController {
    @RequestMapping(value = "/errorSS", method = RequestMethod.GET)
    public String errorSSView() {
        return "errorSS";
    }
    
    @RequestMapping(value = "/errorPS", method = RequestMethod.GET)
    public String errorPSView() {
        return "errorPS";
    }
    
    @RequestMapping(value = "/errorBM", method = RequestMethod.GET)
    public String errorBMView() {
        return "errorBM";
    }
    
    @RequestMapping(value = "/errorDBM", method = RequestMethod.GET)
    public String errorDBMView() {
        return "errorDBM";
    }
}
