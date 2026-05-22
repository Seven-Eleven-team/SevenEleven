package com.bu.jichulmate.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/party")
public class PartyViewController {

    @GetMapping("/seller-identity")
    public String sellerIdentity() {
        return "party/seller-identity";
    }

    @GetMapping("/seller-register")
    public String sellerRegister() {
        return "party/seller-register";
    }

    @GetMapping("/seller-confirm")
    public String sellerConfirm() {
        return "party/seller-confirm";
    }

    @GetMapping("/seller-verify")
    public String sellerVerify() {
        return "party/seller-verify";
    }

    @GetMapping("/seller-profile")
    public String sellerProfile() {
        return "party/seller-profile";
    }
}