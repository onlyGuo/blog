package com.aiyi.blog.controller;

import com.aiyi.blog.assets.NoLogin;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("admin")
public class AdminController {


    @RequestMapping
    @NoLogin
    public String index(){
        return "admin/index";
    }
}
