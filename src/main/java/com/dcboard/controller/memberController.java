package com.dcboard.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class memberController {

    @GetMapping("/index")
    public String index() {

        return "index";
    }

    @GetMapping("/member/login")
    public String login() {

        return "member/login";
    }

    @GetMapping("/about")
    public String about() {

        return "about";
    }

    @GetMapping("/blog")
    public String blog() {

        return "blog";
    }
    @GetMapping("/fragments/layout")
    public String layout() {

        return "fragments/layout";
    }

}
