package com.dcboard.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class dcboardController {

    @GetMapping("/index")
    public String index() {

        return "index";
    }

}
